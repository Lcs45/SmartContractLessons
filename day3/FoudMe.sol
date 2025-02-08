// Geet funds from users
// WithDraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();


contract  FoundMe {
    using PriceConverter for uint256;
    uint256 public  constant MINNUM_USD = 5*1e18;
    address public immutable i_owner;

    address[] public funders;
    mapping (address funder =>uint256 amountFunded) public addressToAmountFunded;


    function found() public payable {
        // require(getConversionRate(msg.value)>minmumUsd,"didn't send enough eth");
        require(msg.value.getConversionRate()>MINNUM_USD,"didn't send enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=msg.value;
    }

    function withdraw() public OnlyOwner {

        for (uint256 funderIndex = 0;funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // transfer
        // send
        // call

        // msg.sender = address
        // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"send failed");
        (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"send failed");

    } 

    constructor(){
        i_owner = msg.sender;
    }

    modifier OnlyOwner() {
        //require(msg.sender == i_owner,"Sender is not owner");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    // receive()
    // fallback()

    receive() external payable { 
        found();
    }

    fallback() external payable { 
        found();
    }


}