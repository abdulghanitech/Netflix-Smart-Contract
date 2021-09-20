// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// Author: Abdul Ghani
// Description: A simple contract to facilitate buying and selling of Netflix screens within the Community.
contract Netflix{
    uint public totalListings = 0;

    struct Listing{
        uint id;
        string name;
        string description;
        uint price;
        address sellerId;
        bool isActive;
    }

    // store the listings in a map
    mapping(uint => Listing) listings;

    uint[] public listingAddresses;

    // add a listing to the map
    function addListing(string memory name, string memory description, uint price) public {

        // TODO: check if all the parameters are passed correctly
        require(price > 0, "Price should be greater than 0");
      
        Listing memory listing = Listing({
            id: totalListings,
            name: name,
            description: description,
            price: price,
            sellerId: msg.sender,
            isActive: true
        });

        listings[totalListings] = listing;   

         // push the listing address to the listingAddresses array
        listingAddresses.push(totalListings); 

        totalListings++;    // increment the totalListings counter    
    }

    // get a single listing from the map by its id
    function getListing(uint id) public view returns (Listing memory listing){
        return listings[id];
    }


    // show all the active listings
    function getListings() public view returns (Listing[] memory) {
        Listing[] memory templistings = new Listing[](totalListings);
       for(uint i = 0; i < totalListings; i++){
        // if the listing is active, add it to the array
        if(listings[i].isActive){
          Listing storage tempListing = listings[i];
          templistings[i] = tempListing;
        }
       }
       return templistings;          
    }

    // Buying an Item from the listing by listing id.
    /* You should be able to buy an item being actively listed for the asking price. Assume the items
    to be strings of maximum 50 characters and that the seller will always deliver the item once
    sold (but he/she should not get paid until the item is delivered). The item (above mentioned
    string) should not be leaked to any other person during the course of the transaction (listing,
    sale, delivery). */
    function buy(uint id) public payable{

        // check if the listing is active
        require(listings[id].isActive == true, "The listing is not active");

        // transfer the money to the seller
        payable(listings[id].sellerId).send(listings[id].price);

        // set the listing to inactive
        listings[id].isActive = false;
    }
}
