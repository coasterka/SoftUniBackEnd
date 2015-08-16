using System.ServiceModel;

namespace DistanceCalculatorSoapService
{
    [ServiceContract]
    public interface IServiceDistanceCalculator
    {
        [OperationContract]
        float CalcDistance(Point startPoint, Point endPoint);
    }
}
