// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "@solmate/tokens/ERC20.sol";

contract Life is ERC20 {
    address public immutable owner;
    uint256 public immutable maxSupply;

    constructor(uint256 _maxSupply) ERC20("life", "LIFE", 18) {
        owner = msg.sender;
        maxSupply = _maxSupply;
        /// @dev insert minting logic to treasury, staking, distribution contracts here
    }

    function mint(to, amount) external {
        require(msg.sender == owner, "Only the owner can mint");
        require(totalSupply+amount<=maxSupply, "amount exceeds maximum supply");
        _mint(to, amount);
    }
}
