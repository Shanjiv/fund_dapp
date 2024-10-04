//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
//pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

function getPrice() internal view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);

    // Try to get the latest round data from the price feed
    (
        , // roundId
        int256 price, // The price we are interested in
        , // startedAt
        , // updatedAt
        // answeredInRound
    ) = priceFeed.latestRoundData();

    // Check if the price returned is greater than 0 to ensure it’s valid
    require(price > 0, "Invalid price data received from Chainlink");

    return uint256(price * 1e10); // Adjusting to 18 decimals
}

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    //function getVersion() internal view returns (uint256) {
    //    return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    //}
    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
    //0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
} 


