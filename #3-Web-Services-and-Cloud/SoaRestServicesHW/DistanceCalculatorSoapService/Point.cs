using System;

namespace DistanceCalculatorSoapService
{
    [Serializable] public class Point
    {
        private int x;
        private int y;
        public Point(int x, int y)
        {
            this.X = x;
            this.Y = y;
        }
        public int X { get { return this.x; } set { this.x = value; } }
        public int Y { get { return this.y; } set { this.y = value; } }
    }
}