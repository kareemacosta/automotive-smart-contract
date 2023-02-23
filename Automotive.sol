//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Automotive {
    //variables
    address public owner;

    mapping(address => bool) public buyers;
    string public vehicleMake;
    string public vehicleModel;
    uint public price;

    //events
    event Purchase(address _buyer, string _make, string _model, uint _price);

    //constructor
    constructor() public {
        owner = msg.sender;
    }

    //functions
    function buyVehicle(string memory _make, string memory _model) public payable {
        require(msg.value == price, "Incorrect amount of Ether sent");
        require(buyers[msg.sender] == false, "You have already purchased this vehicle");
        buyers[msg.sender] = true;
        vehicleMake = _make;
        vehicleModel = _model;
        emit Purchase(msg.sender, _make, _model, msg.value);
    }

    function setPrice(uint _price) public {
        require(msg.sender == owner, "Only the owner can set the price");
        price = _price;
    }

    function checkOwnership() public view returns (bool) {
        return buyers[msg.sender];
    }
}
