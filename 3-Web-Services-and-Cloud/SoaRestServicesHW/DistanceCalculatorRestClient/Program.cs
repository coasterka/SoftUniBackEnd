using System;
using System.Net;

namespace DistanceCalculatorRestClient
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var client = new WebClient())
            {
                // we use DownloadString() if we want to go through
                // the HTTP GET method
                var response = client.DownloadString(
                    "http://localhost:7904/points/distance?x1=5&y1=5&x2=10&y2=10");
                Console.WriteLine(response);
            }
        }
    }
}
