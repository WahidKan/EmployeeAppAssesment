using EmpAppBusinessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace EmployeeAppAssesment.Employee
{
    public partial class AddEmployee : System.Web.UI.Page
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
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            DateTime dob = Convert.ToDateTime(txtDOB.Text);
            string address = txtAddress.Text.Trim();

            service.SaveEmployee(name, dob, address);

            Response.Redirect("ListEmployees.aspx");
        }
    }
}