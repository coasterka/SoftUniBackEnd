using System;

namespace DistanceCalculatorSoapService
{
    public class ServiceDistanceCalculator : IServiceDistanceCalculator
    {
        public float CalcDistance(Point startPoint, Point endPoint)
        {
            return (float)Math.Sqrt(
                (Math.Pow(startPoint.X - endPoint.X, 2) + Math.Pow(startPoint.Y - endPoint.Y, 2))
            );
        }
    }
}
