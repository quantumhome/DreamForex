<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="DreamForex.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <div class="row">
        <div class="col-sm-4"></div>
        <div class="col-md-4" style="background-color: antiquewhite; ">
            <table >
                <tr style="vertical-align:central;padding:20px">
                    <td style="padding: 20px">
                        <h2>Login</h2>
                    </td>
                    <td style="padding: 20px">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/login.jpg" Height="75" Width="75" />
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
            <div>
                <asp:Label ID="Label1" runat="server" Text="Not Yet Registered ?"></asp:Label>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" PostBackUrl="~/Register_1.aspx">Register Now</asp:LinkButton>
                <br />
                <br />
            </div>
            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Submit" OnClick="Button1_Click" />
            <br />
            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" ForeColor="Red" PostBackUrl="~/forgotPwd.aspx">Forgot Password</asp:LinkButton>
            <br /> <br />
            <asp:Label ID="lblResult" runat="server" style="font-size: medium"></asp:Label>
            <br />
            <br />
        </div>
        <div class="col-sm-4"></div>
    </div>
</asp:Content>
