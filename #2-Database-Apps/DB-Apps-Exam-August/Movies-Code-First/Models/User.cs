using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Movies_Code_First.Models
{
    public class User
    {
        private ICollection<Movie> favoriteMovies;
        private ICollection<Rating> ratings;
        public User()
        {
            this.favoriteMovies = new HashSet<Movie>();
            this.ratings = new HashSet<Rating>();
        }
        [Key]
        public int UserId { get; set; }
        [Required]
        [MinLength(5)]
        public string UserName { get; set; }
        public string Email { get; set; }
        public int? Age { get; set; }
        public int? CountryId { get; set; }
        [ForeignKey("CountryId")]
        public virtual Country Country { get; set; }
        public virtual ICollection<Movie> FavoriteMovies {
            get { return this.favoriteMovies; }
            set { this.favoriteMovies = value; }
        }
        public virtual ICollection<Rating> Ratings {
            get { return this.ratings; }
            set { this.ratings = value; }
        }
    }
}
