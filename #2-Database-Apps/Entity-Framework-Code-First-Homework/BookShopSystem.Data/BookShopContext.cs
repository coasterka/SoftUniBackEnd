namespace BookShopSystem.Data
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using BookShopSystem.Data.Migrations;
    using BookShopSystem.Models;

    public class BookShopContext : DbContext
    {
        public BookShopContext()
            : base("BookShopContext")
        {
            //Database.SetInitializer(new MigrateDatabaseToLatestVersion<BookShopContext,
                //Configuration>());
        }
        public virtual IDbSet<Book> Books { get; set; }
        public virtual IDbSet<Author> Authors { get; set; }
        public virtual IDbSet<Category> Categories { get; set; }
    }
}