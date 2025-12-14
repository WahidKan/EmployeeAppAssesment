<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="EmployeeAppAssesment.Employee.AddEmployee" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Employee</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2>Add Employee</h2>

            <div class="mb-3">
                <label>Name</label>
                <asp:TextBox runat="server" ID="txtName" CssClass="form-control" MaxLength="30"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label>DOB</label>
                <asp:TextBox runat="server" ID="txtDOB" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label>Address</label>
                <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control"></asp:TextBox>
            </div>

            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Text="Save Employee" OnClick="btnSave_Click" />
        </div>
    </form>
</body>
</html>
