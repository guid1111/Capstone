using Microsoft.VisualStudio.TestTools.UnitTesting;
using OptionPricer.Controllers;
using System.Linq;

namespace OptionPricer.Tests;


[TestClass]
public class UnitTest1
{
    [TestMethod]
    public void GetCurrencies_AllCurrenciesAreReturned()
    {
        OptionPriceController optionPriceController = new OptionPriceController();        
        var currencies = optionPriceController.GetCurrencies();

        Assert.IsNotNull(currencies);
        Assert.AreEqual(currencies.Count(), 2);        
    }

    [TestMethod]
    public void GetTenors_AllTenorsAreReturned()
    {
        OptionPriceController optionPriceController = new OptionPriceController();        
        var tenors = optionPriceController.GetTenors();

        Assert.IsNotNull(tenors);
        Assert.AreEqual(tenors.Count(), 3);        
    }

    [TestMethod]
    public void GetOptionPrice_OptionPriceIsReturned()
    {
        OptionPriceController optionPriceController = new OptionPriceController();        
        var price = optionPriceController.GetOptionPrice("EURUSD", "1M", 1.01m, 50000000m);

        Assert.IsNotNull(price);
        Assert.IsTrue(price.BidPremium > 0);        
        Assert.IsTrue(price.OfferPremium < 0); 
    }
}

