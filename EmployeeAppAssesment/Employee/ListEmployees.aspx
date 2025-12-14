<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListEmployees.aspx.cs" Inherits="EmployeeAppAssesment.Employee.ListEmployees" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>List Employees</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <button type="button" class="btn btn-outline-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#addEmployeeModal">
                    Create Employee
                </button>

                <h2 class="m-0 text-center flex-grow-1">Employees</h2>

                <input type="text" id="txtSearch" class="form-control w-25" placeholder="Search Employees..." />
            </div>

            <asp:GridView ID="GridEmployees" runat="server"
                CssClass="table table-bordered table-striped"
                AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="DOB" HeaderText="DOB" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Address" HeaderText="Address" />

                    <asp:TemplateField HeaderText="Tasks">
                        <ItemTemplate>
                            <asp:HyperLink runat="server"
                                Text="Tasks"
                                NavigateUrl='<%# "AddTasks.aspx?employeeId=" + Eval("EmployeeId") %>'
                                CssClass="btn btn-sm btn-outline-info">
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>

        <script>
            $(document).ready(function () {
                $("#txtSearch").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#<%= GridEmployees.ClientID %> tbody tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>

        <div class="modal fade" id="addEmployeeModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Add Employee</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body p-0">
                        <iframe src="AddEmployeeModal.aspx" style="width:100%; height:500px; border:none;"></iframe>

                    </div>

                </div>
            </div>
        </div>

        <script>
            $("#txtSearch").on('keydown', function (e) {
                if (e.key === 'Enter') { e.preventDefault(); }
            });

            var addEmpModalEl = document.getElementById('addEmployeeModal');
            if (addEmpModalEl) {
                addEmpModalEl.addEventListener('hidden.bs.modal', function () {
                    location.reload();
                });
            }
        </script>
        <script>
            window.addEventListener('message', function (event) {
                if (event.data === 'employeeAdded') {
                    var modalEl = document.getElementById('addEmployeeModal');
                    var modal = bootstrap.Modal.getInstance(modalEl);
                    if (!modal) {
                        modal = new bootstrap.Modal(modalEl);
                    }

                    modal.hide(); 

                    location.reload();
                }
            });
        </script>
    </form>
</body>
</html>
