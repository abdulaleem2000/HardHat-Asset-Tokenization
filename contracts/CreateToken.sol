
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public immutable i_owner;
    // Constructor: Set the token name, symbol, and initial supply
    constructor(string memory _tokenName, string memory _symbol,uint256 _divisibility,uint256 _initialSupply) ERC20(_tokenName, _symbol) {
        i_owner = msg.sender;
        _mint(msg.sender, _initialSupply * 10**18); // Initial supply: 1,000,000 tokens
      


    }

    function getTokenName() public view returns (string memory) {
        string memory token = name();
        return token;
    }
    
}
