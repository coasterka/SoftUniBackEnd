namespace Movies_Code_First
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using Movies_Code_First.Models;

    public class MoviesContext : DbContext
    {
        public MoviesContext()
            : base("MoviesContext")
        {
        }
        public virtual IDbSet<Country> Countries { get; set; }
        public virtual IDbSet<Movie> Movies { get; set; }
        public virtual IDbSet<Rating> Ratings { get; set; }
        public virtual IDbSet<User> Users { get; set; }
    }
}