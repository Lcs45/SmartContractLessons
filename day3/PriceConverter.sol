// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts@1.3.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal  view returns(uint256){
         (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        ).latestRoundData();
        return uint256(answer*1e10);

    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        return (getPrice()*ethAmount)/1e18;
    }

    function getVersion() internal view returns (uint256){
        return AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        ).version();
    }

}