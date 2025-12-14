<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTasks.aspx.cs" Inherits="EmployeeAppAssesment.Employee.AddTasks" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Tasks</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2></h2>

            <h4>Employee Name: 
                <span id="empName">
                    <asp:Label ID="lblEmpName" runat="server"></asp:Label>
                </span>
            </h4>

            <div class="row">
                <div class="col-md-6">
                    <h5>Existing Tasks</h5>
                    <asp:GridView ID="GridExistingTasks" runat="server" CssClass="table table-bordered table-striped"
                        AutoGenerateColumns="false" OnRowDataBound="GridExistingTasks_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Task Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="col-md-6">
                    <h5>Add New Tasks</h5>
                    <table class="table table-bordered" id="taskTable">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Due Date</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>

                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-success" id="addRow">Add Task Row</button>
                        <asp:Button ID="btnSave" runat="server" Text="Save Tasks" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-secondary" OnClick="btnBack_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {
            const empId = new URLSearchParams(window.location.search).get("employeeId");
            $("#lblEmpId").text(empId);

            $("#addRow").click(function () {
                $("#taskTable tbody").append(`
                    <tr>
                        <td><input class='form-control' name='taskName' /></td>
                        <td><input class='form-control' name='taskDesc' /></td>
                        <td><input class='form-control' name='taskDate' type='date' /></td>
                    </tr>
                `);
            });

            $("#<%= btnSave.ClientID %>").click(function (e) {
                let valid = true;
                $("#taskTable tbody tr").each(function () {
                    const name = $(this).find("input[name='taskName']").val().trim();
                    const desc = $(this).find("input[name='taskDesc']").val().trim();
                    const date = $(this).find("input[name='taskDate']").val().trim();

                    if (!name || !desc || !date) {
                        valid = false;
                        $(this).find("input").css("border", "1px solid red");
                    } else {
                        $(this).find("input").css("border", "");
                    }
                });

                if (!valid) {
                    alert("Please fill all task fields before saving.");
                    e.preventDefault(); 
                }
            });
        });
    </script>
</body>
</html>
