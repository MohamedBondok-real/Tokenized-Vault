//SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Vault {
    IERC20 public immutable token;

    uint256 public totalSupply; //shares
    mapping (address => uint256) public balanceOf;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function mint (address _to, uint256 _shares) private {
        totalSupply += _shares;
        balanceOf[_to] += _shares;
    }

        function burn (address _from, uint256 _shares) private {
        totalSupply -= _shares;
        balanceOf[_from] -= _shares;
    }

    function deposit (uint256 _amount) external {
        uint256 shares;
        if (totalSupply == 0){
            shares = _amount;
        } else {
            shares = (_amount * totalSupply) / token.balanceOf(address(this));
        }

        mint(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw (uint256 _shares) external {
        uint256 amount =
            (_shares * token.balanceOf(address(this))) / totalSupply;

            burn (msg.sender, _shares);
            token.transfer(msg.sender, amount);
    }
}