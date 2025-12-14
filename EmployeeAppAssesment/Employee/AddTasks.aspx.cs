using EmpAppBusinessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeAppAssesment.Employee
{
    public partial class AddTasks : System.Web.UI.Page
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
                int employeeId;
                if (int.TryParse(Request.QueryString["employeeId"], out employeeId))
                {
                    DataTable dtEmployees = service.GetEmployees();

                    DataRow[] rows = dtEmployees.Select("EmployeeId = " + employeeId);
                    if (rows.Length > 0)
                    {
                        lblEmpName.Text = rows[0]["Name"].ToString();
                    }

                    GridExistingTasks.DataSource = service.GetTasksByEmployee(employeeId);
                    GridExistingTasks.DataBind();
                }

            }
        }
        protected void GridExistingTasks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DateTime dueDate;
                if (DateTime.TryParse(e.Row.Cells[2].Text, out dueDate))
                {
                    if (dueDate < DateTime.Today)
                    {
                        e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                        e.Row.Cells[2].Font.Bold = true;
                    }
                }
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListEmployees.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int employeeId = int.Parse(Request.QueryString["employeeId"]);

            List<EmployeeTaskModel> tasks = new List<EmployeeTaskModel>();

            string[] names = Request.Form.GetValues("taskName");
            string[] descs = Request.Form.GetValues("taskDesc");
            string[] dates = Request.Form.GetValues("taskDate");

            if (names != null)
            {
                for (int i = 0; i < names.Length; i++)
                {
                    tasks.Add(new EmployeeTaskModel
                    {
                        Name = names[i],
                        Description = descs[i],
                        DueDate = DateTime.Parse(dates[i])
                    });
                }
            }

            service.SaveTasksByEmployee(employeeId, tasks);
            Response.Redirect("AddTasks.aspx?employeeId=" + employeeId);
        }
    }
}