﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookShop.Models
{
    public class ApplicationUser : IdentityUser
    {
        private ICollection<Purchase> purchases;

        public ApplicationUser()
        {
            this.purchases = new HashSet<Purchase>();
        }

        public virtual ICollection<Purchase> Purchases
        {
            get { return this.purchases; }
            set { this.purchases = value; }
        }
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager,
            string authenticationType)
        {
            var userIdentity = await manager.CreateIdentityAsync(this, authenticationType);
            return userIdentity;
        }
    }
}
