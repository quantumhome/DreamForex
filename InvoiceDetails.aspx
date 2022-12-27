<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvoiceDetails.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="DreamForex.InvoiceDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <style type="text/css">
        .modalBg {
            background-color: gray;
            opacity: 0.8;
        }
        .auto-style1 {
            height: 40px;
        }
        .auto-style2 {
            height: 40px;
            text-align: right;
        }
        .auto-style3 {
            font-size: medium;
        }
         .disp
        { font:Calibri; font-size:larger
          
        }
    </style>
      <asp:SqlDataSource ID="dsUser2" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        DeleteCommand="DELETE FROM [MST_USER_MEMBER] WHERE [MEMBER_ID] = @MEMBER_ID"
        InsertCommand="INSERT INTO [MST_USER_MEMBER] ([LOGIN_ID], [MEM_NAME], [MEM_GENDER], [MEM_MOBILE], [MEM_EMAIL], [MEM_ADD1], [MEM_ADD2], [STATE_ID], [CITY_ID], [PIN], [PAN_NO], [PAN_FILE_NAME], [PASSPORT_NO], [PASSPORT_FILE_NAME], [COUNTRY_ID], [DT_REGN]) VALUES (@LOGIN_ID, @MEM_NAME, @MEM_GENDER, @MEM_MOBILE, @MEM_EMAIL, @MEM_ADD1, @MEM_ADD2, @STATE_ID, @CITY_ID, @PIN, @PAN_NO, @PAN_FILE_NAME, @PASSPORT_NO, @PASSPORT_FILE_NAME, @COUNTRY_ID, getdate())"
        SelectCommand="SELECT MST_USER_MEMBER.MEMBER_ID, MST_USER_MEMBER.LOGIN_ID, MST_USER_MEMBER.MEM_NAME, MST_USER_MEMBER.MEM_GENDER, MST_USER_MEMBER.MEM_MOBILE, MST_USER_MEMBER.MEM_EMAIL, MST_USER_MEMBER.MEM_ADD1, MST_USER_MEMBER.MEM_ADD2, MST_USER_MEMBER.STATE_ID, MST_USER_MEMBER.PIN, MST_USER_MEMBER.PAN_NO, MST_USER_MEMBER.PAN_FILE_NAME, MST_USER_MEMBER.PASSPORT_NO, MST_USER_MEMBER.PASSPORT_FILE_NAME, MST_USER_MEMBER.DT_REGN, MST_STATE.STATE_NAME, MST_COUNTRY.COUNTRY_NAME, MST_CITY.CITY_NAME FROM MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID RIGHT OUTER JOIN MST_USER_MEMBER ON MST_CITY.CITY_ID = MST_USER_MEMBER.CITY_ID LEFT OUTER JOIN MST_COUNTRY ON MST_USER_MEMBER.COUNTRY_ID = MST_COUNTRY.COUNTRY_ID WHERE (MST_USER_MEMBER.LOGIN_ID = @LOGIN_ID)"
        UpdateCommand="UPDATE [MST_USER_MEMBER] SET [LOGIN_ID] = @LOGIN_ID, [MEM_NAME] = @MEM_NAME, [MEM_GENDER] = @MEM_GENDER, [MEM_MOBILE] = @MEM_MOBILE, [MEM_EMAIL] = @MEM_EMAIL, [MEM_ADD1] = @MEM_ADD1, [MEM_ADD2] = @MEM_ADD2, [STATE_ID] = @STATE_ID, [CITY_ID] = @CITY_ID, [PIN] = @PIN, [PAN_NO] = @PAN_NO, [PAN_FILE_NAME] = @PAN_FILE_NAME, [PASSPORT_NO] = @PASSPORT_NO, [PASSPORT_FILE_NAME] = @PASSPORT_FILE_NAME, [COUNTRY_ID] = @COUNTRY_ID, [DT_REGN] = getdate() WHERE [MEMBER_ID] = @MEMBER_ID">
        <DeleteParameters>
            <asp:Parameter Name="MEMBER_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
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
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
        </SelectParameters>
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
            <asp:Parameter Name="MEMBER_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
     <div >
         &nbsp;
         &nbsp;
         &nbsp;
         &nbsp;
         &nbsp;
         &nbsp;
         &nbsp;
         &nbsp;
        <asp:Panel ID="panelForm" runat="server"  >
      <%--  <asp:Label ID="lblNewMemberName" runat="server" Text="New Member Details" Style="font-size: medium; color: #000066"></asp:Label>--%>
        <div class="col-sm-4" style="background-color: antiquewhite;">
            <div class="form-group">
                <label for="name">Name:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="name" Display="Dynamic" ErrorMessage="Please Type in Address" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="name" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="mobile">Mobile No:</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="mobile" Display="Dynamic" ErrorMessage="Please Type in Address" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="mobile" runat="server" class="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="email">Email :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="email" Display="Dynamic" ErrorMessage="Please Type in Address" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="email" runat="server" class="form-control"></asp:TextBox>
            </div>

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
                <div class="form-group">
                    <asp:Label ID="Label8" runat="server" Text="Country : "></asp:Label>
                    <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" DataSourceID="dsCountry" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID">
                        <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="ddlCountry" Display="Dynamic" ErrorMessage="Pl Select Country" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_COUNTRY] ORDER BY [COUNTRY_NAME]"></asp:SqlDataSource>
                </div>

                <asp:Label ID="lblddlState" runat="server" Text="State : "></asp:Label>
                <asp:DropDownList ID="ddlState" runat="server" AppendDataBoundItems="True" DataSourceID="dsStates" DataTextField="STATE_NAME" DataValueField="STATE_ID" AutoPostBack="True">
                    <asp:ListItem Text="Select State" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlState" Display="Dynamic" ErrorMessage="Pl. select State" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="City : "></asp:Label>
                <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True" DataSourceID="dsCity" DataTextField="CITY_NAME" DataValueField="CITY_ID">
                    <asp:ListItem Text="Select City" Value=""></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:SqlDataSource ID="dsStates" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_STATE] ORDER BY [STATE_NAME]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="dsCity" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [CITY_ID], [CITY_NAME] FROM [MST_CITY] WHERE ([STATE_ID] = @STATE_ID) ORDER BY [CITY_NAME]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlState" Name="STATE_ID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

        </div>

        <div class="col-sm-4" style="background-color: antiquewhite;">
            <div class="form-group">
                <label for="txtPin">PIN :</label>
                <asp:TextBox ID="txtPin" runat="server"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlCity" Display="Dynamic" ErrorMessage="Pl. select City" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <br />
                <label for="email">PAN No. :</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtPan" Display="Dynamic" ErrorMessage="Please fill up PAN No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtPan" runat="server" class="form-control"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="Select PAN Document to Upload (jpg, png, gif, bmp) upto 1MB" Style="font-size: small"></asp:Label>
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
                <asp:Label ID="Label7" runat="server" Text="Select Passport Document to Upload (jpg, png, gif, bmp) upto 1MB" Style="font-size: small"></asp:Label>
                <br />
                <asp:FileUpload ID="fupPassport" runat="server" ClientIDMode="Static" />
                <span id="spnDocMsgPP" class="error" style="display: none;"></span>
            </div>
            <div>
                <br />
                <asp:Button ID="btnMember" runat="server" Text="Update Member Details" class="btn btn-primary" OnClick="btnMember_Click" />

                <asp:Label ID="lblResult" runat="server" Style="font-size: medium"></asp:Label>
                <br />
            </div>
        </div>
    </asp:Panel>
     </div>
</asp:Content>
