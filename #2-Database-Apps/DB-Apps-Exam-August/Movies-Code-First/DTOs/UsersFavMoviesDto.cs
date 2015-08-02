using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Movies_Code_First.Models;

namespace Movies_Code_First
{
    class UsersFavMoviesDto
    {
        public string Username { get; set; }
        public ICollection<string> FavouriteMovies { get; set; }
    }
}
