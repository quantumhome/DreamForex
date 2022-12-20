<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="forgotPwd.aspx.cs" Inherits="DreamForex.forgotPwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />

    <%--    <script type="text/javascript">
        $(document).ready(function () {
            $('#divMobile').hide();
            $('#divEmail').hide();
            $('#rbtnMode').change(function () {
                var rbtn = $('#rbtnMode input:checked').val();
                if (rbtn == 'E') {
                    $('#divEmail').show(1000);
                    $('#divMobile').hide();
                    //$('#divMobile').attr('disabled', 'disabled');
                    $("#divMobile").validate({ ignore: ":not(:visible)" });
                } else if (rbtn == 'M') {
                       $('#divMobile').show(1000);
                 $('#divEmail').hide();
                    //$('#divEmail').attr('disabled', 'disabled');
                    $("#divEmail").validate({ ignore: ":not(:visible)" });
                }
            });
        });

    </script>--%>
    <div class="row">
        <div class="col-sm-4"></div>
        <div class="col-md-4" style="background-color: lavenderblush;">
            <table>
                <tr style="vertical-align: central; padding: 20px">
                    <td style="padding: 20px">
                        <h3>Forgot Password</h3>
                    </td>
                    <td style="padding: 20px">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/login.jpg" Height="75" Width="75" />
                    </td>
                </tr>
            </table>
            <div class="form-group">
                <label for="txtUser">To Change Password, receive OTP in : </label>
                <asp:RadioButtonList ID="rbtnMode" runat="server" RepeatDirection="Horizontal" ClientIDMode="Static">
                    <asp:ListItem Value="E">Email Id</asp:ListItem>
                    <asp:ListItem Value="M">Mobile No.</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div id="divEmail">
                <div class="form-group">
                    <label for="txtEmail">Registered Email:</label>
                    <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div id="divMobile">
                <div class="form-group">
                    <label for="txtMobile">Registered Mobile :</label>
                    <asp:TextBox ID="txtMobile" runat="server" class="form-control" TextMode="Number" MaxLength="10"></asp:TextBox>
                </div>
            </div>
            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Submit" OnClick="Button1_Click" />
            <br />
            <br />
            <asp:Label ID="lblResult" runat="server" Style="font-size: large"></asp:Label>
            <br />
            <div class="form-group">
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                    <label for="txtOtp">Type in OTP :</label>
                    <asp:TextBox ID="txtOtp" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOtp" Display="Dynamic" ErrorMessage="Pl Type in the OTP" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:Button ID="btnVerify" class="btn btn-information" runat="server" Text="Verify OTP" OnClick="btnVerify_Click" />

                    <asp:HiddenField ID="hfLoginId" runat="server" />
                </asp:Panel>
                <br />
                <asp:Label ID="lblOtpResult" runat="server" Style="font-size: medium"></asp:Label>
                <br />
                <asp:Panel ID="pnChPwd" runat="server" Visible="False">
                    <div class="form-group">
                        <label for="txtPwd" class="control-label col-sm-4">Password:</label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Pl Type in Password" ControlToValidate="txtPwd" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtPwd" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtPwd1" class="control-label col-sm-4">Re-Type Password:</label>
                        <asp:TextBox ID="txtPwd1" runat="server" class="form-control" TextMode="Password" ValidationGroup="valUser"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords Do Not Match..." ControlToCompare="txtPwd" ControlToValidate="txtPwd1" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
                    </div>
                    <asp:Button ID="btnChPwd" runat="server" Text="Change Password" class="btn btn-primary" OnClick="btnChPwd_Click" />
                    <br />
                    <asp:Label ID="lblUpdated" runat="server" Style="font-size: medium"></asp:Label>
                    <br />
                    <asp:LinkButton ID="lbtnLogin" runat="server" CausesValidation="False" PostBackUrl="~/login.aspx" Visible="False">Login..</asp:LinkButton>
                </asp:Panel>


            </div>
        </div>
        <div class="col-sm-4"></div>
    </div>
</asp:Content>
