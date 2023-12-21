// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./CreateToken.sol";


// Struct to represent asset details
struct AssetDetails {
    string name;
    string description;
    uint256 value;
}

// AssetToken represents the tokenized version of a real-world asset
contract AssetToken{
    // Address of the custodian who holds the underlying asset
    address payable public immutable custodian;//account address of property owner
    address public immutable owner;
    //address immutable tokenContractAddress;
    AssetDetails assetDetails;
    MyToken myToken;
    address public tokenContractAddress;
    // Mapping from token ID to asset details
    //mapping(address => AssetDetails) public assetDetails;

    // Event to notify when tokens are minted (created)
    event Mint(address indexed to, uint256 amount, AssetDetails assetInfo);

    // Event to notify when tokens are burned (destroyed)
    event Burn(address indexed from, uint256 amount);

    // Modifier to ensure that only the custodian can execute a function
    modifier onlyCustodian() {
        require(msg.sender == custodian, "Not the custodian");
        _;
    }

    // Modifier to ensure that only the owner can execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    constructor(AssetDetails memory _assetDetails, address payable _custodion, address _tokenContractAddress){
                assetDetails = _assetDetails;
                custodian = _custodion;
                tokenContractAddress = _tokenContractAddress;
                myToken = MyToken(_tokenContractAddress);
                owner = msg.sender;

    }
  

    // function getTokenName() public view  onlyOwner returns (string memory) {
    //     return myToken.getTokenName();
    // }

    // function getBalance() public view  onlyOwner returns (uint256) {
    //     return myToken.balanceOf(owner);
    // }

    // function getSender() public view onlyOwner returns (address) {
    //     return owner;
    // }

    function getAssetDetails() public view onlyOwner returns (AssetDetails memory) {
        return assetDetails;
    }




    // constructor(
    //     AssetDetails memory _assetDetails,
    //     address _tokenContractAddress,
        
    //     address _custodian
    //     )  {

    //     custodian = _custodian;
    //     tokenContractAddress = _tokenContractAddress;
    //     // Mint initial supply to the custodian
    //     //_mint(_custodian, _initialSupply);
    // };

    // Mint new tokens when the custodian creates more tokens (asset appreciation, for example)
    // function mint(
    //     address to,
    //     uint256 amount,
    //     AssetDetails memory assetInfo
    // ) external onlyCustodian {
    //     _mint(to, amount);
    //     assetDetails[amount] = assetInfo;
    //     emit Mint(to, amount, assetInfo);
    // }

    // // Burn tokens when the custodian needs to remove tokens from circulation
    // function burn(address from, uint256 amount) external onlyCustodian {
    //     _burn(from, amount);
    //     // Remove asset details when burning tokens
    //     delete assetDetails[amount];
    //     emit Burn(from, amount);
    // }

    // Update the custodian address
    // function updateCustodian(address newCustodian) external onlyOwner {
    //     custodian = newCustodian;
    // }
}
