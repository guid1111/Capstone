namespace OptionPricer;

public class FxOptionPrice
{
    public FxOptionPrice(decimal bidPremium, decimal offerPremium)
    {
        BidPremium = bidPremium;
        OfferPremium = offerPremium;
    }

    public decimal BidPremium { get; }
    public decimal OfferPremium { get; }    
}
