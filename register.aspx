<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="DreamForex.register" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .error {
            background-color: #d9534f;
            font-weight: 300;
            font-size: 12px;
            padding: 3px 6px 3px 6px;
            color: #fff;
            text-align: center;
            white-space: nowrap;
        }
    </style>
    <script type="text/javascript">
     $(document).ready(function () {
         
         $("#fupPan,#fupPassport").change(function (e) {
            // alert(e.target.id);
                // Get uploaded file extension
                var extension = $(this).val().split('.').pop().toLowerCase();
                // Create array with the files extensions that we wish to upload
                var validFileExtensions = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
         //Check file extension in the array.if -1 that means the file extension is not in the list. 
                if ($.inArray(extension, validFileExtensions) == -1) {
                    alert("Sorry!! Upload only jpg, jpeg, png, gif, bmp file");
                    if (e.target.id == 'fupPan') {
                        $('#spnDocMsgPan').text("Sorry!! Upload only jpg, jpeg, png, gif, bmp file").show();
                    }
                    else {
                        $('#spnDocMsgPP').text("Sorry!! Upload only jpg, jpeg, png, gif, bmp file").show();
                    }
                    // Clear fileuload control selected file
                    $(this).replaceWith($(this).val('').clone(true));
                    //Disable Submit Button
                //    $('#btnSubmit').prop('disabled', true);
                }
                else {
                    // Check and restrict the file size to 32 KB.
                    if ($(this).get(0).files[0].size > (1024*1024)) {
                        alert("Sorry!! Max allowed file size is 1 Mb");
                        if (e.target.id == 'fupPan') {
                            $('#spnDocMsgPan').text("Sorry!! Max allowed file size is 1Mb").show();
                        }
                        else {
                            $('#spnDocMsgPP').text("Sorry!! Max allowed file size is 1Mb").show();

                        }
                     // Clear fileuload control selected file
                        $(this).replaceWith($(this).val('').clone(true));
                        //Disable Submit Button
                    //    $('#btnSubmit').prop('disabled', true);
                    }
                    else {
                        //Clear and Hide message span
                        $('#spnDocMsg').text('').hide();
                        //Enable Submit Button
                    //    $('#btnSubmit').prop('disabled', false);
                    }
                }
            });
        });
    </script>
    <table>
        <tr style="vertical-align: central; padding: 20px">
            <td style="padding: 20px">
                <h2>User Registration</h2>
            </td>
            <td style="padding: 20px">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/user.png" Height="75" Width="75" />
            </td>
        </tr>
    </table>

    <div class="row">
        <div class="col-md-4" style="background-color: antiquewhite;">
            <div class="form-group">
                <label for="email">username:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLogin" Display="Dynamic" ErrorMessage="Please fill up username" ForeColor="Red" SetFocusOnError="True" ValidationGroup="avl"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtLogin" runat="server" class="form-control"></asp:TextBox>
                <asp:Button ID="btnAvail" class="btn btn-danger" runat="server" Text="Check Availability" OnClick="btnAvail_Click" ValidationGroup="avl" />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
            <div class="form-group">
                <label for="pwd">Password:</label>
                <asp:TextBox ID="txtPwd" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="pwd">Re-Type Password:</label>
                <asp:TextBox ID="txtPwd1" runat="server" class="form-control" TextMode="Password" ValidationGroup="valUser"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords Do Not Match..." ControlToCompare="txtPwd" ControlToValidate="txtPwd1" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:CompareValidator>
            </div>

            <div class="form-group">
                <label for="pwd">Mobile No:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMobile" Display="Dynamic" ErrorMessage="Please fill up Mobile No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtMobile" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="pwd">Email:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Please fill up Email" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtEmail" runat="server" class="form-control" TextMode="Email" ValidateRequestMode="Enabled"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="email">Member Name :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="Please fill up Member name" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtName" runat="server" class="form-control"></asp:TextBox>
            </div>
            <br />
<%--            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                DeleteCommand="DELETE FROM [MST_USER] WHERE [LOGIN_ID] = @LOGIN_ID"
                InsertCommand="insertUser" InsertCommandType="StoredProcedure"
                SelectCommand="SELECT * FROM [MST_USER]"
                UpdateCommand="UPDATE [MST_USER] SET [LOGIN_NAME] = @LOGIN_NAME, [PWDHASH] = @PWDHASH, [SALT] = @SALT, [MOBILENO] = @MOBILENO, [EMAILID] = @EMAILID WHERE [LOGIN_ID] = @LOGIN_ID" OnInserted="SqlDataSource1_Inserted">
                <DeleteParameters>
                    <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="pLogin" Type="String" />
                    <asp:Parameter Name="pPassword" Type="String" />
                    <asp:Parameter Name="MOBILENO" Type="String" />
                    <asp:Parameter Name="EMAILID" Type="String" />
                    <asp:Parameter Name="retValue" Type="Int32" Direction="InputOutput" />
                    <asp:Parameter Name="id" Type="Int32" Direction="InputOutput" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="LOGIN_NAME" Type="String" />
                    <asp:Parameter Name="PWDHASH" Type="Object" />
                    <asp:Parameter Name="SALT" Type="Object" />
                    <asp:Parameter Name="MOBILENO" Type="String" />
                    <asp:Parameter Name="EMAILID" Type="String" />
                    <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>--%>
            <br />
        </div>

       <h4> 
           <asp:Label ID="lblResult1" runat="server" Text=""></asp:Label>

       </h4>
        <div class="col-sm-4" style="background-color: antiquewhite;">


            <div class="form-group">
                <label for="email">Gender:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rblGender" Display="Dynamic" ErrorMessage="Please select Gender" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="M">Male</asp:ListItem>
                    <asp:ListItem Value="F">Female</asp:ListItem>
                    <asp:ListItem Value="O">Others</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="form-group">
                <label for="email">Address:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rblGender" Display="Dynamic" ErrorMessage="Please Type in Address" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtAdd1" runat="server" class="form-control"></asp:TextBox>
                <asp:TextBox ID="txtAdd2" runat="server" class="form-control"></asp:TextBox>
                <br />
                <asp:Label ID="Label1" runat="server" Text="State : "></asp:Label>
                <asp:DropDownList ID="ddlState" runat="server" AppendDataBoundItems="True" DataSourceID="dsStates" DataTextField="STATE_NAME" DataValueField="STATE_ID" AutoPostBack="True">
                    <asp:ListItem Text="Select State" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlState" Display="Dynamic" ErrorMessage="Pl. select State" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text="City : "></asp:Label>
                <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True" DataSourceID="dsCity" DataTextField="CITY_NAME" DataValueField="CITY_ID">
                    <asp:ListItem Text="Select City" Value=""></asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="PIN : "></asp:Label>
                <asp:TextBox ID="txtPin" runat="server"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlCity" Display="Dynamic" ErrorMessage="Pl. select City" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <br />
                <asp:SqlDataSource ID="dsStates" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_STATE] ORDER BY [STATE_NAME]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="dsCity" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [CITY_ID], [CITY_NAME] FROM [MST_CITY] WHERE ([STATE_ID] = @STATE_ID) ORDER BY [CITY_NAME]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlState" Name="STATE_ID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="form-group">
                <asp:Label ID="Label8" runat="server" Text="Country : "></asp:Label>
                <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" DataSourceID="dsCountry" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID">
                    <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="ddlCountry" Display="Dynamic" ErrorMessage="Pl Select Country" SetFocusOnError="True">red</asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_COUNTRY] ORDER BY [COUNTRY_NAME]"></asp:SqlDataSource>
            </div>

        </div>

        <div class="col-sm-4" style="background-color: antiquewhite;">
            <div class="form-group">
                <label for="email">PAN No. :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtPan" Display="Dynamic" ErrorMessage="Please fill up PAN No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtPan" runat="server" class="form-control"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="Select PAN Document to Upload (jpg, png, gif, bmp) upto 1MB" style="font-size: small"></asp:Label>
                <br />
                <asp:FileUpload ID="fupPan" runat="server" ClientIDMode="Static" />
                <span id="spnDocMsgPan" class="error" style="display: none;"></span>
                <br />
            </div>
            <div class="form-group">
                <label for="email">Passport No. :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtPassport" Display="Dynamic" ErrorMessage="Please fill up Passport No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtPassport" runat="server" class="form-control"></asp:TextBox>
                <br />
                <asp:Label ID="Label7" runat="server" Text="Select Passport Document to Upload (jpg, png, gif, bmp) upto 1MB" style="font-size: small"></asp:Label>
                <br />
                <asp:FileUpload ID="fupPassport" runat="server" ClientIDMode="Static" />
               <span id="spnDocMsgPP" class="error" style="display: none;"></span>
            </div>
            <div>
                <br />
                <asp:Button ID="btnMember" runat="server" Text="Update Member Details" class="btn btn-primary" OnClick="btnMember_Click" />
  

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                    DeleteCommand="DELETE FROM [MST_USER_MEMBER] WHERE [MEMBER_ID] = @MEMBER_ID"
                    InsertCommand="insertUser" InsertCommandType="StoredProcedure"
                    SelectCommand="SELECT * FROM [MST_USER_MEMBER]"
                    UpdateCommand="UPDATE [MST_USER_MEMBER] SET [LOGIN_ID] = @LOGIN_ID, [MEM_NAME] = @MEM_NAME, [MEM_GENDER] = @MEM_GENDER, [MEM_MOBILE] = @MEM_MOBILE, [MEM_EMAIL] = @MEM_EMAIL, [MEM_ADD1] = @MEM_ADD1, [MEM_ADD2] = @MEM_ADD2, [STATE_ID] = @STATE_ID, [CITY_ID] = @CITY_ID, [PIN] = @PIN, [PAN_NO] = @PAN_NO, [PAN_FILE_NAME] = @PAN_FILE_NAME, [PASSPORT_NO] = @PASSPORT_NO, [PASSPORT_FILE_NAME] = @PASSPORT_FILE_NAME, [COUNTRY_ID] = @COUNTRY_ID, [DT_REGN] = @DT_REGN WHERE [MEMBER_ID] = @MEMBER_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="MEMBER_ID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="pLogin" Type="String" />
                        <asp:Parameter Name="pPassword" Type="String" />
                        <asp:Parameter Name="MEM_NAME" Type="String" />
                        <asp:Parameter Name="MEM_GENDER" Type="String" />
                        <asp:Parameter Name="mobileNo" Type="String" />
                        <asp:Parameter Name="emailId" Type="String" />
                        <asp:Parameter Name="MEM_ADD1" Type="String" />
                        <asp:Parameter Name="MEM_ADD2" Type="String" />
                        <asp:Parameter Name="STATE_ID" Type="Int32" />
                        <asp:Parameter Name="CITY_ID" Type="Int32" />
                        <asp:Parameter Name="PIN" Type="String" />
                        <asp:Parameter Name="PAN_NO" Type="String" />
                        <asp:Parameter Name="PAN_FILE_NAME" Type="String" />
                        <asp:Parameter Name="PASSPORT_NO" Type="String" />
                        <asp:Parameter Name="PASSPORT_FILE_NAME" Type="String" />
                        <asp:Parameter Name="COUNTRY_ID" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="LOGIN_ID" Type="Int32" />
                        <asp:Parameter Name="MEM_NAME" Type="String" />
                        <asp:Parameter Name="MEM_GENDER" Type="String" />
                        <asp:Parameter Name="MEM_MOBILE" Type="String" />
                        <asp:Parameter Name="MEM_EMAIL" Type="String" />
                        <asp:Parameter Name="MEM_ADD1" Type="String" />
                        <asp:Parameter Name="MEM_ADD2" Type="String" />
                        <asp:Parameter Name="STATE_ID" Type="Int32" />
                        <asp:Parameter Name="CITY_ID" Type="Int32" />
                        <asp:Parameter Name="PIN" Type="String" />
                        <asp:Parameter Name="PAN_NO" Type="String" />
                        <asp:Parameter Name="PAN_FILE_NAME" Type="String" />
                        <asp:Parameter Name="PASSPORT_NO" Type="String" />
                        <asp:Parameter Name="PASSPORT_FILE_NAME" Type="String" />
                        <asp:Parameter Name="COUNTRY_ID" Type="Int32" />
                        <asp:Parameter Name="DT_REGN" Type="DateTime" />
                        <asp:Parameter Name="MEMBER_ID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <br />
            </div>
        </div>

    </div>
</asp:Content>
