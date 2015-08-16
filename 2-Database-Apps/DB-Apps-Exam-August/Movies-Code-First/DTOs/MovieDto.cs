using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Movies_Code_First.Models;

namespace Movies_Code_First
{
    class MovieDto
    {
        public string Isbn { get; set; }
        public string Title { get; set; }
        public AgeRestriction AgeRestriction { get; set; }
    }
}
