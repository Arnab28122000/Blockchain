//Arnabcoin ICO

//version of compiler
pragma solidity ^0.4.11;

contract arnabcoin_ico {
    //Introducing the total no. of arnab coins available for sale
    uint public max_arnabcoins = 1000000;
    
    //Introducing USD to arnabcoin conversion rate
    uint public usd_to_arnabcoins = 1000;
    
    //Introducing the total no. of arnab coin that has been brought by the investors
    uint public total_arnabcoins_bought = 0;
    
    //Mapping from the investor address to its quity in arnabcoins and usd
    mapping(address => uint) equity_arnabcoins;
    mapping(address => uint) equity_usd;
    
    //Checking if an investor can buy arnabcoins
    modifier can_buy_arnabcoins(uint usd_invested){
        require (usd_invested * usd_to_arnabcoins + total_arnabcoins_bought <= max_arnabcoins);
        _;
    }
    
    //Getting the equity in Arnabcoins of an investor
    function equity_in_arnabcoins(address investor) external constant returns (uint){
        return equity_arnabcoins[investor];
    }
    
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
    
    //Buying Arnabcoins
    function buy_arnabcoins(address investor, uint usd_invested) external
    can_buy_arnabcoins(usd_invested) {
        uint arnabcoins_bought = usd_invested * usd_to_arnabcoins;
        equity_arnabcoins[investor] += arnabcoins_bought;
        equity_usd[investor] = equity_arnabcoins[investor] / 1000;
        total_arnabcoins_bought += arnabcoins_bought;
    }
    
    //Selling Arnabcoins
    function sell_arnabcoins(address investor, uint arnabcoins_sold) external {
        equity_arnabcoins[investor] -= arnabcoins_sold;
        equity_usd[investor] = equity_arnabcoins[investor] / 1000;
        total_arnabcoins_bought -= arnabcoins_sold;
    }
    
}