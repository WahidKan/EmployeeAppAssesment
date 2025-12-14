using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmpAppBusinessLayer
{
    public class EmployeeTaskModel
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime DueDate { get; set; }
    }
    public class EmployeeService
    {
        private string _connectionString;

        public EmployeeService(string connectionString)
        {
            _connectionString = connectionString;
        }

        public bool SaveEmployee(string name, DateTime dob, string address)
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Employee(Name, DOB, Address) VALUES(@Name,@DOB,@Address)", con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@DOB", dob);
                cmd.Parameters.AddWithValue("@Address", address);

                con.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public DataTable GetEmployees()
        {
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Employee", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public bool SaveTasksByEmployee(int employeeId, List<EmployeeTaskModel> tasks)
        {
            if (tasks == null || tasks.Count == 0)
                return false;

            DataTable table = new DataTable();
            table.Columns.Add("Name", typeof(string));
            table.Columns.Add("Description", typeof(string));
            table.Columns.Add("DueDate", typeof(DateTime));

            foreach (var task in tasks)
            {
                table.Rows.Add(task.Name, task.Description, task.DueDate);
            }

            using (SqlConnection con = new SqlConnection(_connectionString))
            using (SqlCommand cmd = new SqlCommand("dbo.SaveEmployeeTasks", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@EmployeeId", SqlDbType.Int).Value = employeeId;

                var tvpParam = cmd.Parameters.AddWithValue("@Tasks", table);
                tvpParam.SqlDbType = SqlDbType.Structured;
                tvpParam.TypeName = "dbo.EmployeeTaskType";

                con.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }


        public DataTable GetTasksByEmployee(int employeeId)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                string query = @"
                    SELECT TaskId, Name, Description, DueDate
                    FROM EmployeeTask
                    WHERE EmployeeId = @EmployeeId
                    ORDER BY DueDate ASC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", employeeId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

    }
}
