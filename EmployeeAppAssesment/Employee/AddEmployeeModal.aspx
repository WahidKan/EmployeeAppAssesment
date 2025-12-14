<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployeeModal.aspx.cs"
    Inherits="EmployeeAppAssesment.Employee.AddEmployeeModal" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
</head>

<body>
    <form id="form1" runat="server">
        <div class="container py-4 px-3">

            <h5 class="mb-4 text-center"></h5>

            <div class="mb-3">
                <label class="form-label">Name</label>
                <asp:TextBox runat="server" ID="txtName" CssClass="form-control w-100 w-md-75" MaxLength="50"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">DOB</label>
                <asp:TextBox runat="server" ID="txtDOB" CssClass="form-control w-100 w-md-50" TextMode="Date"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Address</label>
                <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control w-100" MaxLength="200"></asp:TextBox>
            </div>

            <div class="modal-footer d-flex justify-content-between align-items-center">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" />
                <div>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ms-2" OnClientClick="return clearForm();" />
                </div>
            </div>



        </div>
    </form>
</body>
</html>

<script>
    function clearForm() {
        document.getElementById('<%= txtName.ClientID %>').value = '';
        document.getElementById('<%= txtDOB.ClientID %>').value = '';
        document.getElementById('<%= txtAddress.ClientID %>').value = '';
        document.getElementById('<%= lblError.ClientID %>').innerText = '';
        return false;
    }
</script>
