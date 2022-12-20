<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register_1.aspx.cs" Inherits="DreamForex.Register_1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtLogin').keyup(function () {
                var userName = $(this).val();
                if (userName.length >= 3) {
                $.ajax({
                    url: 'RegistrationService.asmx/UserNameExists',
                    method: 'post',
                    data: { userName: userName },
                    dataType: 'json',
                    success: function (data) {
                        var divElement = $('#lblResult');
                        if (data.UserNameInUse) {
                            divElement.text(data.UserName + ' already in use');
                            divElement.css('color', 'red');
                        }
                        else {
                            divElement.text(data.UserName + ' available')
                            divElement.css('color', 'green');
                        }
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        });
});    </script>
     <style type="text/css">
        .modalBackground {
            background-color: lightgray;
            opacity: 0.4;
        }
    </style>
   <br />
    <h3>User Registration</h3>
    <div class="row">
        <div class="col-md-6" style="background-color:  floralwhite;">
            <div class="form-group">
                <br />
                <label for="txtLogin" class="control-label col-sm-4">username:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLogin" Display="Dynamic" ErrorMessage="Please fill up username" ForeColor="Red" SetFocusOnError="True" ValidationGroup="avl"></asp:RequiredFieldValidator>
                <asp:Label ID="lblResult" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:TextBox ID="txtLogin" runat="server" class="form-control" ClientIDMode="Static"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="form-group">
                <label for="txtName" class="control-label col-sm-4">Member Name :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="Please fill up Member name" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtName" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtMobile" class="control-label col-sm-4">Mobile No:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMobile" Display="Dynamic" ErrorMessage="Please fill up Mobile No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Pl enter a valid mobile no." Display="Dynamic" SetFocusOnError="True" ControlToValidate="txtMobile" ForeColor="Red" ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                <asp:TextBox ID="txtMobile" runat="server" class="form-control" MaxLength="10"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtEmail" class="control-label col-sm-4">Email:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Please fill up Email" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtEmail" runat="server" class="form-control" TextMode="Email" ValidateRequestMode="Enabled"></asp:TextBox>
            </div>

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
            <div class="form-group">
                <table>
                    <tr>
                        <td style="height: 48px">
                            <label for="rblOtp">Recieve OTP on :</label>

                        </td>
                        <td style="height: 48px">
                            <asp:RadioButtonList ID="rblOtp" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="M">Mobile</asp:ListItem>
                                <asp:ListItem Value="E">Email</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rblOtp" Display="Dynamic" ErrorMessage="Please select OTP Mode" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>

                        </td>
                        <td style="height: 48px">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" class="btn btn-primary" OnClick="btnMember_Click" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="lbtnOtp" runat="server" Visible="False" OnClick="lbtnOtp_Click" CausesValidation="False">Resend OTP</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblOtp" runat="server" style="padding:5px" BorderColor="Red" BorderStyle="Solid" BorderWidth="2px"></asp:Label>
            </div>
            <asp:Panel ID="Panel1" runat="server" Visible="False">
                <div class="form-group">
                    <asp:Label ID="lblOtp1" class="control-label col-sm-4" runat="server" Text="Type in Your OTP"></asp:Label>
                    <asp:TextBox ID="txtOtp" runat="server" class="form-control" TextMode="Password" ValidationGroup="valUser"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtOtp" Display="Dynamic" ErrorMessage="Pl type in the OTP your received" ForeColor="Red" SetFocusOnError="True" ValidationGroup="ver"></asp:RequiredFieldValidator>
                </div>
                <asp:HiddenField ID="hfUserId" runat="server" />
                <asp:Button ID="btnVerify" runat="server" Text="Verify OTP" class="btn btn-primary" OnClick="btnVerify_Click" ValidationGroup="ver" />

            </asp:Panel>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" DeleteCommand="DELETE FROM [MST_USER] WHERE [LOGIN_ID] = @LOGIN_ID"
                InsertCommand="registerUser" InsertCommandType="StoredProcedure" OnInserted="SqlDataSource1_Inserted">
                <DeleteParameters>
                    <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="username" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="MEM_NAME" Type="String" />
                    <asp:Parameter Name="MOBILENO" Type="String" />
                    <asp:Parameter Name="EMAILID" Type="String" />
                    <asp:Parameter Name="otpmode" Type="String" />
                    <asp:Parameter Name="OTP" Type="String" />
                    <asp:Parameter Name="userId" Type="Int32" Direction="Output" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="LOGIN_NAME" Type="String" />
                    <asp:Parameter Name="MEM_NAME" Type="String" />
                    <asp:Parameter Name="PWDHASH" Type="Object" />
                    <asp:Parameter Name="SALT" Type="Object" />
                    <asp:Parameter Name="MOBILENO" Type="String" />
                    <asp:Parameter Name="EMAILID" Type="String" />
                    <asp:Parameter Name="OTP_MODE" Type="String" />
                    <asp:Parameter Name="OTP" Type="String" />
                    <asp:Parameter Name="DT_OTP" Type="DateTime" />
                    <asp:Parameter Name="VERIFIED" Type="Boolean" />
                    <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" 
                SelectCommand="checkOtp" SelectCommandType="StoredProcedure"
                UpdateCommand="updateOtp"  UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfUserId" Name="loginId" PropertyName="Value" Type="Int32" />
                    <asp:ControlParameter ControlID="txtOtp" Name="OTP" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="result" Type="Int32" Direction="Output" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="OTP" Type="String" />
                    <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Panel ID="PanelModal" runat="server">
                <br />
                <asp:Label ID="lblVerify" class="label label-success" runat="server" style="font-size: large"></asp:Label>
                <br />
                <br />
                <asp:LinkButton ID="lbtnClose" class="label label-info" runat="server" CausesValidation="False" PostBackUrl="~/login.aspx" OnClick="lbtnClose_Click">Login</asp:LinkButton>
                <asp:Label ID="Label1" class="label label-info" runat="server" Text="to Monitor your orders.."></asp:Label>
                <br />
                <asp:Button ID="btnShow" runat="server" Text="Button" style="display:none" />
            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender ID="PanelModal_ModalPopupExtender" 
                PopupControlID="PanelModal" runat="server" BehaviorID="PanelModal_ModalPopupExtender"  
                BackgroundCssClass="modalBackground" 

                TargetControlID="btnShow">
            </ajaxToolkit:ModalPopupExtender>
            <br />
        </div>
    </div>
</asp:Content>
