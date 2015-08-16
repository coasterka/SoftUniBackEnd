using System;
using DistanceCalculatorClient.ServiceReferenceDistanceCalculator;

namespace DistanceCalculatorClient
{
    class Program
    {
        static void Main()
        {
            var client = new ServiceDistanceCalculatorClient();
            using (client)
            {
                Point a = new Point
                {
                    x = 5,
                    y = 5
                };
                Point b = new Point
                {
                    x = 10,
                    y = 10
                };
                var result = client.CalcDistance(a, b);
                Console.WriteLine(result);
            }
        }
    }
}
