using System;
using System.ComponentModel.DataAnnotations;

namespace BookShop.Models
{
    public class Purchase
    {
        [Key]
        public int PurchaseId { get; set; }
        public ApplicationUser User { get; set; }
        public Book Book { get; set; }
        public decimal Price { get; set; }
        public DateTime DateOfPurchase { get; set; }
        public bool IsRecalled { get; set; }
    }
}
