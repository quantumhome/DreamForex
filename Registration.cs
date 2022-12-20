using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DreamForex
{
    public class Registration
    {
        public string UserName { get; set; }
        public bool UserNameInUse { get; set; }
    }

    public class LiveRate
    {
        public string product { get; set; }
        public string orderNo { get; set; }
        public string CurrCode { get; set; }
        public int fxQty { get; set; }
        public double CurrRate { get; set; }
        public double clientAmount { get; set; }
        public double dreamAmount { get; set; }
        public double totAmount { get; set; }
        public int prodId { get; set; }
        public double commClient { get; set; }
        public double commDream { get; set; }
        public double rateToClient { get; set; }

    }

    public class userQuoteReg
    {
        public string orderNumner { get; set; }
        public string currencyCode { get; set; }
        public double forexAmount { get; set; }
        public string purpose { get; set; }
        public double exRate { get; set; }
        public double totalAmount { get; set; }
    }
}