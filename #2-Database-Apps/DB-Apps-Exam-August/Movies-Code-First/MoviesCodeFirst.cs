using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Movies_Code_First.Models;

namespace Movies_Code_First
{
    class MoviesCodeFirst
    {
        static void Main()
        {
            Database.SetInitializer(new MoviesMigrationStrategy());
            var context = new MoviesContext();
            var moviesCount = context.Movies.Count();
            Console.WriteLine(moviesCount);
        }
    }
}
