using System.Runtime.CompilerServices;
using BookShop.Models;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookShop.Data
{
    using System.Data.Entity;

    public class BookShopContext : IdentityDbContext<ApplicationUser>
    {
        public BookShopContext()
            : base("BookShopNew")
        {
            Database.SetInitializer(new DbInitializer());
        }

        public virtual IDbSet<Book> Books { get; set; }
        public virtual IDbSet<Category> Categories { get; set; }
        public virtual IDbSet<Author> Authors { get; set; }
        public virtual IDbSet<Purchase> Purchases { get; set; }
        public static BookShopContext Create()
        {
            return new BookShopContext();
        }
    }
}