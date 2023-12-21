// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Struct to represent asset details
struct AssetDetails {
    string name;
    string direction;
    uint256 amount;
    uint256 amountInterest;
    uint256 grossAnnualRent;
    uint256 netAmountRent;
    uint256 interestPayment;
    uint256 numberOfTokens;
    uint256 tokenPrice;
    uint256 minInvestment;
    uint256 homeInterest;
    uint256 deadline;
    
}

struct Details {
    string secMarket;
    string currency;
    string neighood;
    string yoc;
    string elevator;
    string buildedSurface;
    string bedrooms;
    string bathrooms;
    string isRented;
    string tokenName;
    string description;
    string dateCreated; 
}

struct InvestmentDetails{
    uint256 tokenPurchase;
    string query;
    address userAddress;
}

// AssetToken represents the tokenized version of a real-world asset
contract AssetNewToken is ERC20 {
    // Address of the custodian who holds the underlying asset
    //address public custodian;
    address immutable owner;
    uint256 public tokenPriceInMatics;
    //uint256 decimals = 18;
    uint256 public totalAssets;
    // Mapping from token ID to asset details
    mapping(string => AssetDetails) public assetDetails;
    mapping(string => Details) public details;

    mapping(uint256 => InvestmentDetails) public investments;
    uint256 public nextInvestmentId = 1;
    mapping(uint256 => InvestmentDetails)[] public investmentsArray;
    string[] public assetIds;
    uint256[] public investmentIds;
    //AssetDetails [] public assetDetails;

    // Event to notify when tokens are minted (created)
    event Mint(address indexed to, uint256 amount, AssetDetails assetInfo);

    // Event to notify when tokens are burned (destroyed)
    event Burn(address indexed from, uint256 amount);

    // Modifier to ensure that only the custodian can execute a function
    // modifier onlyCustodian() {
    //     require(msg.sender == custodian, "Not the custodian");
    //     _;
    // }

    // Modifier to ensure that only the owner can execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }



    // Constructor initializes the ERC20 token
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) {
       
        owner = msg.sender;
        // Mint initial supply to the custodian
        totalAssets = 0;
        _mint(msg.sender, _initialSupply * 10**18);
    }

    // function getTokenPriceInDollars() public view returns(uint256)  {
    //     return tokenPriceInDollars;
//     // }
// function getValueWithDecimal(uint256 value) public pure returns (uint256) {
//         // Assume one decimal place
//         return value / 10;
//     }
    // Mint new tokens when the custodian creates more tokens (asset appreciation, for example)
    function mint(
        AssetDetails memory assetInfo,
        Details memory assetInfo2
    ) external onlyOwner {
       
        bytes memory bytesName = bytes(assetInfo.name);
        bytes memory bytesDirection = bytes(assetInfo.direction);

        bytes memory concatenated = abi.encodePacked(bytesName, bytesDirection);
        string memory result = string(concatenated);

        totalAssets += 1;
        // uint256 value = getValueWithDecimal(assetInfo.tokenPrice);
        // assetInfo.tokenPrice = value;
        //uint256 propertyValue = assetInfo.propertyValue;
        tokenPriceInMatics = assetInfo.tokenPrice;
        //uint256 amount = BigNumber.from(input).mul(BigNumber.from(10).pow(decimals));
        //totalTokens = propertyValue/_tokenPrice;

        _mint(msg.sender, assetInfo.numberOfTokens);
        assetDetails[result] = assetInfo;
        details[result] = assetInfo2;
        assetIds.push(result);
        //assetDetails.push(assetInfo);
        //tokenPrice = _tokenPrice;
        emit Mint(msg.sender, assetInfo.numberOfTokens, assetInfo);

    }
    // function getTotalTokens() public view returns (uint256) {
    //     return totalTokens;
    // }
    function getAssetDetails(string memory _query) public view returns(AssetDetails memory) {
        
        return assetDetails[_query];

        
    }
    function getAllAssetDetails() external view returns (AssetDetails[] memory,Details[] memory) {
        AssetDetails[] memory allDetails = new AssetDetails[](assetIds.length);
        Details[] memory allDetails2 = new Details[](assetIds.length);
        for (uint256 i = 0; i < assetIds.length; i++) {
            string memory assetId = assetIds[i];
            allDetails[i] = assetDetails[assetId];
            allDetails2[i] = details[assetId];
        }
        return (allDetails, allDetails2);
    }
    
    function addInvestments(string memory _query, uint256 _tokensPurchase, address _userAddress)public {
        InvestmentDetails memory newInvestment = InvestmentDetails(_tokensPurchase, _query, _userAddress);

        investments[nextInvestmentId] = newInvestment;
        investmentIds.push(nextInvestmentId);
        nextInvestmentId++;

    }
    //getting all investments
    function getInvestments()public view returns(InvestmentDetails[] memory){
        InvestmentDetails[] memory allDetails = new InvestmentDetails[](nextInvestmentId);
        for (uint256 i = 0; i < investmentIds.length; i++) {
            uint256 investmentId = investmentIds[i];
            allDetails[i] = investments[investmentId];
          

        }
        return allDetails;
    }
    // Burn tokens when the custodian needs to remove tokens from circulation
    function burn(address from, uint256 amount,string memory _query) external onlyOwner {
        _burn(from, amount);
        // Remove asset details when burning tokens
        delete assetDetails[_query];
        emit Burn(from, amount);
    }

    // Update the custodian address
    // function updateCustodian(address newCustodian) external onlyOwner {
    //     custodian = newCustodian;
    // }

    function approve(address spender, uint256 value) public override onlyOwner returns (bool) {
      
        return super.approve(spender, value);
    }
}


