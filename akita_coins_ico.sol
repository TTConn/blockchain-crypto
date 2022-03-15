// AkitaCoins ICO

//Compiler Version
pragma solidity >=0.7.0 <0.9.0;

contract akitacoin_ico {

    // Introduce the maximum number of AkitaCoins available for sale
    uint public max_akitacoins = 1000000;

    // Conversion rate: USD to AkitaCoins
    uint public usd_to_akitacoins = 1000;

    // Total number of Akitacoins that have been purchased
    uint public total_akitacoins_purchased = 0;

    // Map: investor address to its equity in AkitaCoins and USD
    mapping(address => uint) equity_akitacoins;
    mapping(address => uint) equity_usd;

    // Check: can investor purchase
    modifier can_buy_akitacoins(uint usd_invested) {
        require(usd_invested * usd_to_akitacoins + total_akitacoins_purchased <= max_akitacoins);
        _;
    }

    // Get equity in AkitaCoins of an investor
    function equity_in_akitacoins(address investor) external constant returns (uint) {
        return equity_akitacoins[investor];
    }

    // Get equity in USD of an investor
        function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buy AkitaCoins
    function buy_akitacoins(address investor, uint usd_invested) external
    can_buy_akitacoins(usd_invested) {
        uint akitacoins_bought = usd_invested * usd_to_akitacoins;
        equity_akitacoins[investor] += akitacoins_bought;
        equity_usd[investor] = equity_akitacoins[investor] / usd_to_akitacoins;
        total_akitacoins_purchased += akitacoins_bought;
    }

    // Sell AkitaCoins
    function sell_akitacoins(address investor, uint akitacoins_sold) external {
        equity_akitacoins[investor] -= akitacoins_sold;
        equity_usd[investor] = equity_akitacoins[investor] / usd_to_akitacoins;
        total_akitacoins_purchased -= akitacoins_sold;
    }

}
