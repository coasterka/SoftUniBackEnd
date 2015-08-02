using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Movies_Code_First.Models;

namespace Movies_Code_First
{
    class UserDto
    {
        public string UserName { get; set; }
        public int? Age { get; set; }
        public string Email { get; set; }
        public string Country { get; set; }
    }
}
