using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeworkTasks
{
    class DAO
    {
        private static SoftUniEntities context = new SoftUniEntities();
        public static void Add(Employee employee)
        {
            context.Employees.Add(employee);
            context.SaveChanges();
        }

        public static Employee FindByKey(object key)
        {
            var employee = context.Employees.Find(key);

            if (employee == null)
            {
                throw new ObjectNotFoundException("No employee found");
            }

            return employee;
        }

        public static void Modify(Employee employee, string firstName)
        {
            var id = employee.EmployeeID;
            var databaseEmployee = context.Employees.Find(id);
            databaseEmployee.FirstName = firstName;
            context.SaveChanges();
        }

        public static void Delete(Employee employee)
        {
            context.Employees.Remove(employee);
            context.SaveChanges();
        }
    }
}
