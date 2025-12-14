using EmpAppBusinessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeAppAssesment.Employee
{
    public partial class ListEmployees : System.Web.UI.Page
    {
        EmployeeService service;

        protected void Page_Init(object sender, EventArgs e)
        {
            service = new EmployeeService(
                System.Configuration.ConfigurationManager.ConnectionStrings["db"].ConnectionString
            );
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEmployees();
            }
        }

        private void BindEmployees()
        {
            var employees = service.GetEmployees();
            GridEmployees.DataSource = employees;
            GridEmployees.DataBind();
        }
    }
}