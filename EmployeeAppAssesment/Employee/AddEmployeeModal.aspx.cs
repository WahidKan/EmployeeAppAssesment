using EmpAppBusinessLayer;
using System;
using System.Configuration;
using System.Web.UI;

namespace EmployeeAppAssesment.Employee
{
    public partial class AddEmployeeModal : System.Web.UI.Page
    {
        private EmployeeService service;

        protected void Page_Init(object sender, EventArgs e)
        {
            string conn = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            service = new EmployeeService(conn);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            bool hasError = false;
            string errorMessage = "";

            string name = txtName.Text.Trim();
            if (string.IsNullOrWhiteSpace(name))
            {
                hasError = true;
                errorMessage += "Name is required.<br/>";
            }

            DateTime dob;
            if (!DateTime.TryParse(txtDOB.Text.Trim(), out dob))
            {
                hasError = true;
                errorMessage += "Valid Date of Birth is required.<br/>";
            }

            string address = txtAddress.Text.Trim();
            if (string.IsNullOrWhiteSpace(address))
            {
                hasError = true;
                errorMessage += "Address is required.<br/>";
            }

            if (hasError)
            {
                lblError.Text = errorMessage;
                lblError.ForeColor = System.Drawing.Color.Red;
                return;
            }

            service.SaveEmployee(name, dob, address);

            string script = @"
        <script>
            window.parent.postMessage('employeeAdded', '*');
        </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "closeModal", script);
        }

    }
}
