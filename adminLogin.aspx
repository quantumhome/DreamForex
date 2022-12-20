<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="adminLogin.aspx.cs" Inherits="DreamForex.adminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br /><br />
    <div class="row">
        <div class="col-sm-4"></div>
        <div class="col-md-4" style="background-color:  #D6D1CB; ">
            <table >
                <tr style="vertical-align:central;padding:20px">
                    <td style="padding: 20px">
                        <h2>Admin Login</h2>
                    </td>
                    <td style="padding: 20px">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/admin.png" Height="75" Width="75" />
                    </td>
                </tr>
            </table>
            <div class="form-group">
                <label for="txtUser">username:</label>
                <asp:TextBox ID="txtUser" class="form-control" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="pwd">Password:</label>
                <asp:TextBox ID="pwd" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <br /> 
            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Submit" OnClick="Button1_Click" />


            <asp:SqlDataSource ID="dsLogin" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" 
                SelectCommand="adminLogin" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter  Name="OFF_USER_NAME"  ControlID="txtUser" Type="String" />
                    <asp:ControlParameter Name="pwd"  ControlID="pwd" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br /> <br /> <br />
            <div id="result" class="form-group" runat="server">
            <asp:Label ID="lblResult" runat="server" style="font-size: medium"></asp:Label>
        </div>

        </div>
        <div class="col-sm-4"></div>
    </div>
</asp:Content>
