using System;
using DistanceCalculatorClient.ServiceReferenceDistanceCalculator;

namespace DistanceCalculatorClient
{
    class Program
    {
        static void Main()
        {
            var client = new ServiceDistanceCalculatorClient();
            Point a = new Point(5, 5);
            Point b = new Point(10, 10);


            var result = client.CalcDistance(a, b);
            Console.WriteLine(result);
        }
    }
}
