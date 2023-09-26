using Microsoft.AspNetCore.Mvc;

namespace OptionPricer.Controllers;

[ApiController]
[Route("[controller]")]
public class OptionPriceController : ControllerBase
{    
    //Example GET:  http://localhost:8000/OptionPrice/Tenors
    [Route("Currencies")]
    public IEnumerable<string> GetCurrencies()
    {
        return new [] { "EURUSD", "JPYUSD", "USDKRW" };
    }

    //Example GET:  http://localhost:8000/OptionPrice/Currencies
    [Route("Tenors")]
    public IEnumerable<string> GetTenors()
    {
        return new [] { "1M", "2M", "3M" };
    }

    //Example GET:  http://localhost:8000/OptionPrice/EURUSD/1M?strike=1&notional=2000 
    [HttpGet(Name = "GetOptionPrice")]
    [Route("{currency}/{tenor}")]
    public FxOptionPrice GetOptionPrice(string currency,
                                        string tenor,
                                        [FromQuery(Name="strike")] decimal strike, 
                                        [FromQuery(Name="notional")] decimal notional)
    {
        var random = new Random();

        return new FxOptionPrice(random.Next(), random.Next() * -1);   
    }
}
