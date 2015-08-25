using System;
using System.Linq;
using BookShop.Data;

namespace BookShop.Client
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new BookShopContext();
            var auth = context.Authors.Count();
            Console.WriteLine(auth);
        }
    }
}
