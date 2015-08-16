using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeworkTasks
{
    class Program
    {
        static void Main(string[] args)
        {
            // Problem 2
            //var employee = DAO.FindByKey(10);
            //Console.WriteLine(employee.FirstName);
            //DAO.Modify(employee, "peshka");
            //Console.WriteLine(employee.FirstName);
            //employee.FirstName = "PESHKA";
            //DAO.Add(employee);

            // Problem 3

            // task 1
            //var context = new SoftUniEntities();
            //var projects = context.Employees
            //    .Where(e => e.Projects
            //        .Any(
            //            p => p.StartDate.Year >= 2001 &&
            //                 p.StartDate.Year <= 2003
            //        ))
            //    .OrderBy(e => e.FirstName)
            //    .Select(e => new
            //    {
            //        ManagerName = e.Manager.LastName,
            //        Projects = e.Projects
            //            .Where(p => p.StartDate.Year >= 2001 &&
            //                        p.StartDate.Year <= 2003)
            //    })
            //    .Take(5)
            //    .ToList();
            //foreach (var project in projects)
            //{
            //    Console.WriteLine("Manager: {0} {1}", project.ManagerName);
            //    foreach (var pr in project.Projects)
            //    {
            //        Console.WriteLine("Name: {0}, Start: {1}, End: {2}",
            //            pr.Name,
            //            pr.StartDate,
            //            pr.EndDate
            //            );
            //    }
            //}

            // task 2
            // addresses with employees' count
            //var context = new SoftUniEntities();
            //var addresses = context.Addresses
            //    .OrderByDescending(a => a.Employees.Count())
            //    .ThenBy(a => a.Town.Name)
            //    .Take(10)
            //    .Select(a => new
            //    {
            //        Address = a.AddressText,
            //        Town = a.Town.Name,
            //        EmployeeCount = a.Employees.Count()
            //    });
            //foreach (var address in addresses)
            //{
            //    Console.WriteLine("{0}, {1} - {2} employees",
            //        address.Address,
            //        address.Town,
            //        address.EmployeeCount
            //        );
            //}

            // task 3
            //var context = new SoftUniEntities();
            //var employee = context.Employees.Find(147);
            //var projects = employee.Projects
            //    .OrderBy(p => p.Name);
            //foreach (var pr in projects)
            //{
            //    Console.WriteLine("{0} {1} ({2}) - {3}",
            //        employee.FirstName,
            //        employee.LastName,
            //        employee.JobTitle,
            //        pr.Name);
            //}

            // task 4
            //var context = new SoftUniEntities();
            //var departments = context.Departments
            //    .Where(d => d.Employees.Count() > 5)
            //    .OrderBy(d => d.Employees.Count())
            //    .Select(d => new
            //    {
            //        DepartmentName = d.Name,
            //        ManagerName = d.Manager.LastName,
            //        Employees = d.Employees
            //            .Select(e => new
            //            {
            //                e.FirstName,
            //                e.LastName,
            //                e.HireDate,
            //                e.JobTitle
            //            })
            //    });
            //Console.WriteLine("Count of departments: {0}", departments.Count());
            //Console.WriteLine();
            //foreach (var dep in departments)
            //{
            //    Console.WriteLine("--{0} - Manager: {1}, Employees: {2}",
            //        dep.DepartmentName,
            //        dep.ManagerName,
            //        dep.Employees.Count()
            //        );
            //    foreach (var empl in dep.Employees)
            //    {
            //        Console.WriteLine("{0} {1}, {2} - {3}",
            //            empl.FirstName,
            //            empl.LastName,
            //            empl.HireDate,
            //            empl.JobTitle);
            //    }
            //}

            // Problem 4

            //var context = new SoftUniEntities();
            //var stopWatch = new Stopwatch();
            //stopWatch.Start();
            //PrintNumberOfEmployeesNativeQuery(context);
            //Console.WriteLine(stopWatch.Elapsed);

            //stopWatch.Restart();

            //PrintNumberOfEmployeesLinqQuery(context);
            //Console.WriteLine(stopWatch.Elapsed);
            //stopWatch.Stop();

            // Problem 5

            var context = new SoftUniEntities();
            var projByEmployee = context.usp_ProjectsByEmployee("Roberto", "Tamburello");
            foreach (var project in projByEmployee)
            {
                Console.WriteLine(project);
            }
            //Console.WriteLine(string.Join(", ", employee));

        }
        private static void PrintNumberOfEmployeesNativeQuery(SoftUniEntities context)
        {
            var employees = context.Employees.SqlQuery(@"
                SELECT *
                FROM Employees e
                JOIN EmployeesProjects ep
                ON e.EmployeeID = ep.EmployeeID
                JOIN Projects p
                ON p.ProjectID = ep.ProjectID
                WHERE YEAR(p.StartDate) BETWEEN '2001' AND '2003'")
                .ToList();
            Console.WriteLine(employees.Count);
        }

        private static void PrintNumberOfEmployeesLinqQuery(SoftUniEntities context)
        {
            var projects = context.Employees
                .Where(e => e.Projects
                    .Any(
                        p => p.StartDate.Year >= 2001 &&
                             p.StartDate.Year <= 2003
                    ))
                .OrderBy(e => e.FirstName)
                .Select(e => new
                {
                    ManagerName = e.Manager.LastName,
                    Projects = e.Projects
                        .Where(p => p.StartDate.Year >= 2001 &&
                                    p.StartDate.Year <= 2003)
                })
                .ToList();
            Console.WriteLine(projects.Count());
        }
    }
}
