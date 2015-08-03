using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Movies_Code_First.Models
{
    public class Country
    {
        private ICollection<User> users;
        public Country()
        {
            this.users = new HashSet<User>();
        }
        [Key]
        public int CountryId { get; set; }
        [Required]
        public string Name { get; set; }
        public virtual ICollection<User> Users {
            get { return this.users; }
            set { this.users = value; }
        }
    }
}
