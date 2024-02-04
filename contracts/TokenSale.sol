// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./NewToken.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// Struct to represent asset details

contract AssetTokenSale {
    // Address of the token being sold
    address public tokenAddress;
    address public owner;
    AggregatorV3Interface public priceFeed;
    address public priceFeedAddress;
    uint256 public maticPrice;
    uint256 public balance;
    address public userAddress;
    uint256 public tokensPurchase;
    //Ass AssetNewToken(tokenAddress)
    AssetNewToken assetNewToken;
    uint256 public maticsRequiredForOneToken;
    //MyToken contractCreateToken
    // Event to notify when tokens are sold
    event TokenSold(
        address indexed buyer,
        uint256 amount,
        AssetDetails assetInfo
    );

    // Modifier to ensure that only the owner can execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function getConversionRate(uint256 maticAmount, AggregatorV3Interface priceFeedI) internal view returns (uint256)
    {
        (, int256 answer, , , ) = priceFeedI.latestRoundData();
        //uint256 ethPrice = getPrice(priceFeed);
        //uint256 ans = uint256(answer * 10000000000);
        uint256 maticAmountInUsd = (uint256(answer)*maticAmount)/1e18;
        // or (Both will do the same thing)
        // uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // 1 * 10 ** 18 == 1000000000000000000
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return maticAmountInUsd;
    }

    // Constructor initializes the token sale
    constructor(address _tokenAddress) {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
        //userAddress = _userAddress;
        assetNewToken = AssetNewToken(_tokenAddress);
        //priceFeedAddress = _priceFeedAddress;
    }

    function getPrice() public  {
        priceFeed = AggregatorV3Interface(priceFeedAddress);
        maticPrice = getConversionRate(1e18, priceFeed);
    }

    function getTokenPur(string memory _query) public payable returns (uint256) {
        maticsRequiredForOneToken = assetNewToken.getAssetDetails(_query).tokenPrice;
        return maticsRequiredForOneToken;
    }

    function getSender() public view returns (address) {
        
         return  userAddress;
    }
    // Function to allow investors to purchase tokens
    function purchaseTokens(
     
        //AssetDetails memory assetInfo
        string memory _query,
        string memory _email
        //address _priceFeedAddress
    ) external payable {
        // Transfer tokens from the owner (seller) to the buyer
        priceFeed = AggregatorV3Interface(priceFeedAddress);
        maticPrice = getConversionRate(1e18, priceFeed);
      //                             token price/8426061
        
        maticsRequiredForOneToken = assetNewToken.getAssetDetails(_query).tokenPrice;// 0.1 matic
        //uint256 _maticsRequired = (amount*assetInfo.price);
        
        tokensPurchase = msg.value / maticsRequiredForOneToken;
        balance = msg.value;
        //require(tokensPurchase > 0, "Can't buy zero tokens, please buy more tokens");
      
        assetNewToken.transferFrom(owner,msg.sender, uint256(tokensPurchase));
        assetNewToken.addInvestments(_query, tokensPurchase, msg.sender, _email);
       // emit TokenSold(tx.origin, msg.value,  assetNewToken.getAssetDetails(300));
    }
}
