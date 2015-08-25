using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BookShop.Models
{
    public class Category
    {
        private ICollection<Book> books;
        public Category()
        {
            this.books = new HashSet<Book>();
        }
        [Key]
        public int CategoryId { get; set; }
        [Required]
        public string Name { get; set; }
        public int BookId { get; set; }
        public virtual ICollection<Book> Books
        {
            get { return this.books; }
            set { this.books = value; }
        }
    }
}
