<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvoiceSellDetails.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="DreamForex.InvoiceSellDetails" %>

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
      <div class=" alert alert-success">
        <asp:Label ID="lblUserDet" runat="server" Text=""></asp:Label>
    </div>
     <div>
        <asp:Button ID="Button1" class="btn btn-basic" runat="server" Text="<< Back" PostBackUrl="~/InvoiceSell_Pre.aspx" />
    </div>
     <asp:SqlDataSource ID="dsUser1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        SelectCommand="SELECT [MEM_NAME], [MOBILENO], [EMAILID] FROM [MST_USER] WHERE ([LOGIN_ID] = @LOGIN_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="dsMember" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT MEMBER_ID FROM MST_USER_MEMBER WHERE (LOGIN_ID = @LOGIN_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="dsCompany" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        SelectCommand="SELECT MST_COMPANY.*, MST_CITY.CITY_NAME, MST_STATE.STATE_NAME FROM MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID RIGHT OUTER JOIN MST_COMPANY ON MST_CITY.CITY_ID = MST_COMPANY.CITY_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMemberId" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT MST_USER_MEMBER.MEMBER_ID, MST_USER_MEMBER.LOGIN_ID, MST_USER_MEMBER.MEM_NAME, MST_USER_MEMBER.MEM_GENDER, MST_USER_MEMBER.MEM_MOBILE, MST_USER_MEMBER.MEM_EMAIL, MST_USER_MEMBER.MEM_ADD1, MST_USER_MEMBER.MEM_ADD2, MST_USER_MEMBER.STATE_ID, MST_USER_MEMBER.CITY_ID, MST_USER_MEMBER.PIN, MST_USER_MEMBER.PAN_NO, MST_USER_MEMBER.PAN_FILE_NAME, MST_USER_MEMBER.PASSPORT_NO, MST_USER_MEMBER.PASSPORT_FILE_NAME, MST_USER_MEMBER.COUNTRY_ID, MST_USER_MEMBER.DT_REGN, MST_CITY.CITY_NAME, MST_STATE.STATE_NAME, MST_COUNTRY.COUNTRY_NAME FROM MST_COUNTRY RIGHT OUTER JOIN MST_USER_MEMBER ON MST_COUNTRY.COUNTRY_ID = MST_USER_MEMBER.COUNTRY_ID LEFT OUTER JOIN MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID ON MST_USER_MEMBER.CITY_ID = MST_CITY.CITY_ID WHERE (MST_USER_MEMBER.MEMBER_ID = @MEMBER_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="MEMBER_ID" SessionField="MEMBER_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   <asp:LinkButton ID="lbtnDummy" runat="server"></asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        PopupControlID="panelPopup"
        TargetControlID="lbtnDummy"
        CancelControlID="btnClose"
        BackgroundCssClass="modalBg"  >
    </ajaxToolkit:ModalPopupExtender>
    
    <asp:SqlDataSource ID="dsBookingSell" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        SelectCommand="SELECT * FROM [TRN_SELL] SELL JOIN [TRN_SELL_SUB] SELL_SUB ON SELL.SELL_ID = SELL_SUB.SELL_ID WHERE ([BOOKING_NO] = @BOOKING_NO)">
        <SelectParameters>
            <asp:SessionParameter Name="BOOKING_NO" SessionField="iBookingNo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="dsHsn" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [HSN]"></asp:SqlDataSource>
    
      <asp:SqlDataSource ID="dsUser2" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        DeleteCommand="DELETE FROM [MST_USER_MEMBER] WHERE [MEMBER_ID] = @MEMBER_ID"
        InsertCommand="INSERT INTO [MST_USER_MEMBER] ([LOGIN_ID], [MEM_NAME], [MEM_GENDER], [MEM_MOBILE], [MEM_EMAIL], [MEM_ADD1], [MEM_ADD2], [STATE_ID], [CITY_ID], [PIN], [PAN_NO], [PAN_FILE_NAME], [PASSPORT_NO], [PASSPORT_FILE_NAME], [COUNTRY_ID], [DT_REGN]) VALUES (@LOGIN_ID, @MEM_NAME, @MEM_GENDER, @MEM_MOBILE, @MEM_EMAIL, @MEM_ADD1, @MEM_ADD2, @STATE_ID, @CITY_ID, @PIN, @PAN_NO, @PAN_FILE_NAME, @PASSPORT_NO, @PASSPORT_FILE_NAME, @COUNTRY_ID, getdate())"
        SelectCommand="SELECT MST_USER_MEMBER.MEMBER_ID, MST_USER_MEMBER.LOGIN_ID, MST_USER_MEMBER.MEM_NAME, MST_USER_MEMBER.MEM_GENDER, MST_USER_MEMBER.MEM_MOBILE, MST_USER_MEMBER.MEM_EMAIL, MST_USER_MEMBER.MEM_ADD1, MST_USER_MEMBER.MEM_ADD2, MST_USER_MEMBER.STATE_ID, MST_USER_MEMBER.CITY_ID, MST_USER_MEMBER.COUNTRY_ID, MST_USER_MEMBER.PIN, MST_USER_MEMBER.PAN_NO, MST_USER_MEMBER.PAN_FILE_NAME, MST_USER_MEMBER.PASSPORT_NO, MST_USER_MEMBER.PASSPORT_FILE_NAME, MST_USER_MEMBER.DT_REGN, MST_STATE.STATE_NAME, MST_COUNTRY.COUNTRY_NAME, MST_CITY.CITY_NAME FROM MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID RIGHT OUTER JOIN MST_USER_MEMBER ON MST_CITY.CITY_ID = MST_USER_MEMBER.CITY_ID LEFT OUTER JOIN MST_COUNTRY ON MST_USER_MEMBER.COUNTRY_ID = MST_COUNTRY.COUNTRY_ID WHERE (MST_USER_MEMBER.LOGIN_ID = @LOGIN_ID)"
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
     <asp:SqlDataSource ID="ds_Invoice" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
       InsertCommand="InsertInvoice" InsertCommandType="StoredProcedure"
      
        SelectCommand="SELECT TOP (1000) [INVOICE_ID],
         [INVOICE_SERIAL_NO]
      ,[DT_INVOICE]
      ,[BOOKING_NO]
      ,[DT_BOOKING]
      ,[BOOKING_FLAG]
      ,[LOGIN_ID]
      ,[AMOUNT_TOTAL]
      ,[CGST]
      ,[SGST]
      ,[IGST]
      ,[HSNID]
  FROM [FOREX].[dbo].[INVOICE] ORDER BY [INVOICE_SERIAL_NO] DESC">
      
        <InsertParameters>
            <asp:Parameter Name="INVOICE_SERIAL_NO" Type="Int32" />
            <asp:Parameter Name="DT_INVOICE" Type="DateTime" />
            <asp:Parameter Name="BOOKING_NO" Type="String" />
            <asp:Parameter Name="BOOKING_FLAG" Type="String" />
            <asp:Parameter Name="LOGIN_ID" Type="Int32" />
            <asp:Parameter Name="PROCEED_TO" Type="String" />
            <asp:Parameter Name="AMOUNT_TOTAL" Type="Double" />
            <asp:Parameter Name="CGST" Type="Double" />
            <asp:Parameter Name="SGST" Type="Double" />
            <asp:Parameter Name="IGST" Type="Double" />
            <asp:Parameter Name="HSNID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
        </SelectParameters>
       
    </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsInvoiceVsBooking" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT TOP (1000) [INVOICE_ID],
       [INVOICE_SERIAL_NO]
      ,[DT_INVOICE]
      ,[BOOKING_NO]
      ,[DT_BOOKING]
      ,[BOOKING_FLAG]
      ,[LOGIN_ID]
      ,[AMOUNT_TOTAL]
      ,[CGST]
      ,[SGST]
      ,[IGST]
      ,[HSNID]
  FROM [FOREX].[dbo].[INVOICE]  WHERE LOGIN_ID = @LOGIN_ID AND BOOKING_NO=@BOOKING_NO ORDER BY [INVOICE_SERIAL_NO] DESC">
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
             <asp:SessionParameter Name="BOOKING_NO" SessionField="iBookingNo" Type="String" />
        </SelectParameters>
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
             <div class="form-group">
                  <label for="Invoice">Invoice No. :</label>
                  <asp:RequiredFieldValidator ID="rfvInvoiceSerialNumber" runat="server" ControlToValidate="txtInvoiceSerialNumber" Display="Dynamic" ErrorMessage="Please fill the Invoice Serial Number" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtInvoiceSerialNumber" runat="server" class="form-control"></asp:TextBox>
                <br />
             </div>
             <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Proceed To : "></asp:Label>
                   <asp:DropDownList ID="ddlProceedTo" runat="server" AppendDataBoundItems="True" DataSourceID="dsCountry" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID">
                        <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlProceedTo" Display="Dynamic" ErrorMessage="Please Select Country" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
              </div>
            <div>
                <br />
                <asp:Button ID="btnMember" runat="server" Text="Update Member Details & Generate Invoice" class="btn btn-primary" OnClick="btnMember_Click" />
                <asp:Label ID="lblResult" runat="server" Style="font-size: medium"></asp:Label>
                <br />
            </div>
        </div>
    </asp:Panel>
         <asp:Panel ID="panelPopup" runat="server"
        Style="background-color: #F9F9F9; padding: 15px"  Width="1000px" CssClass="popup" Height="800px" ScrollBars="Vertical" >
      <%--  <div class="invHeader">
            <asp:Label ID="mLblResult" runat="server" Text="" Style="font-size: large"></asp:Label>
            <table>
                <tr>
                    <td style="text-align: left; width: 33%">
                        <asp:Label ID="lblGstin" runat="server" Text=""></asp:Label><br />
                        <asp:Label ID="lblCin" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="text-align: center; width: 33%;">
                        <asp:Label ID="Label5" runat="server" Text="TAX INVOICE (CASH MEMO)"></asp:Label>
                    </td>
                    <td style="text-align: right; width: 33%">
                        <asp:Label ID="Label36" runat="server" Text="RBI License Number :"></asp:Label>
                        <br />
                        <asp:Label ID="lblRbi" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center">
                        <asp:Label ID="lblCompanyname" runat="server" Text="" Style="font-size: x-large"></asp:Label><br />
                        <asp:Label ID="lblAdd1" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblAdd2" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblStCity" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblCoState" runat="server"></asp:Label>
                        <asp:Label ID="lblPin" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblPhno" runat="server" Text=""></asp:Label><br />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <asp:Label ID="Label37" runat="server" Text="Serial No. : "></asp:Label>
                        <asp:TextBox ID="txtSlNo" runat="server"></asp:TextBox>
                    </td>
                    <td style="text-align: center">
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                        <asp:Label ID="lblState" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <asp:Label ID="Label14" runat="server" Text="Date : "></asp:Label>
                        <asp:TextBox ID="txtInvDt" runat="server" TextMode="DateTime"></asp:TextBox>
                        <ajaxToolkit:CalendarExtender ID="txtInvDt_CalendarExtender" runat="server" BehaviorID="txtInvDt_CalendarExtender" Format="dd-MMM-yyyy" TargetControlID="txtInvDt" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="Label15" runat="server" Text="Pax/Party Name : "></asp:Label>
                        <asp:TextBox ID="iTxtname" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="Label16" runat="server" Text="Address : "></asp:Label>
                        <asp:TextBox ID="iTxtAdd1" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
                        &nbsp;
            <asp:TextBox ID="iTxtAdd2" runat="server" Width="300px"></asp:TextBox>
                        ,
               <asp:Label ID="Label21" runat="server" Text="City : "></asp:Label>
                        <asp:Label ID="iLblCity" runat="server"></asp:Label>
                        &nbsp;,
         <asp:Label ID="Label20" runat="server" Text="State : "></asp:Label>
                        <asp:Label ID="iLblState" runat="server"></asp:Label>
                    
                        ,
                        <asp:Label ID="Label25" runat="server" Text="PIN : "></asp:Label>
                        <asp:TextBox ID="iTxtPin" runat="server" MaxLength="6" Width="100px"></asp:TextBox>
                    
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="Label17" runat="server" Text="Mobile : "></asp:Label>
                        <asp:TextBox ID="iTxtMobile" runat="server" MaxLength="10"></asp:TextBox>
                        &nbsp;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label18" runat="server" Text="Email : "></asp:Label>
                        <asp:TextBox ID="iTxtEmail" runat="server" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">

                        <asp:Label ID="Label19" runat="server" Text="GSTIN/UIN : "></asp:Label>
                        <asp:TextBox ID="iTxtGstinUin" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
                        &nbsp;,
            <asp:Label ID="Label22" runat="server" Text="Nationality : "></asp:Label>
                        <asp:Label ID="lblCountry" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">

                        <asp:Label ID="Label23" runat="server" Text="Proceed To : "></asp:Label>
                        <asp:TextBox ID="iTxtProceedTo" runat="server" MaxLength="50" Width="300px"></asp:TextBox>
                        &nbsp;,
            <asp:Label ID="Label24" runat="server" Text="Passport No. : "></asp:Label>
                        <asp:TextBox ID="iTxtPP" runat="server" Width="300px"></asp:TextBox>

                        ,
                        <asp:Label ID="Label26" runat="server" Text="PAN : "></asp:Label>
                        <asp:TextBox ID="iTxtPan" runat="server" MaxLength="50"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Currency Sold : "></asp:Label>
                        <asp:TextBox ID="iTxtCurrcode" runat="server" BackColor="#FFF2F2" ReadOnly="True"></asp:TextBox>
                     </td>
                    <td colspan="2">
                        <asp:SqlDataSource ID="dsHsn" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [HSN]"></asp:SqlDataSource>
                        <asp:Label ID="Label27" runat="server" Text="HSN CODE : "></asp:Label>
                        <asp:Label ID="iLblHsn" runat="server"></asp:Label>

                     <td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label28" runat="server" Text="FX AMOUNT : "></asp:Label>
                        <asp:TextBox ID="iTxtFxAmt" runat="server" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>

                    </td>
                    <td>
                        <asp:Label ID="Label29" runat="server" Text="Fx Exchange Rate : "></asp:Label>
                        <asp:TextBox ID="iTxtRate" runat="server" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>

                    </td>
                    <td>
                        <asp:Label ID="Label34" runat="server" Text="Value : "></asp:Label>
                        <asp:Label ID="iLblValue" runat="server"></asp:Label>

                    </td>
                </tr>
               <tr>
                   <td></td>
                   <td class="text-right">
                       <asp:Label ID="iLblCgst" runat="server"></asp:Label>
                   </td>
                    <td >
                        <asp:TextBox ID="iTxtCgst" runat="server" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        &nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="iLblSgst" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="iTxtSgst" runat="server" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>
                        &nbsp;</td>
                    <td class="text-right">
                        <asp:Label ID="iLblIgst" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="iTxtIgst" runat="server" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td class="text-right">
                        <asp:Label ID="Label35" runat="server" CssClass="auto-style3" Text="Total : "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="iTxtTotal" runat="server" CssClass="auto-style3" ReadOnly="True" BackColor="#FFF2F2"></asp:TextBox>
                    </td>
                </tr>

            </table>
        </div>--%>
      <div id="Div1" runat="server" style="max-height: 800px; ">
        <table width="100%"  cellpadding="5" cellspacing="0" border="0px" >
            <tr>
                <td style="width: 150px; height: 1px" align="left">
                    &nbsp;
                </td>
                <td style="width: 250px; height: 1px" align="left">
                    &nbsp;
                </td>
                <td style="width: 200px; height: 1px" align="left">
                    &nbsp;
                </td>
                <td style="width: 150px; height: 1px" align="right">
                    &nbsp;
                </td>
                <td style="width: 250px; height: 1px" align="right">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="Label58" runat="server" Text="TAX INVOICE (CASH MEMO) " 
                        CssClass="disp" Font-Bold="False" Font-Size="X-Large"></asp:Label>
                </td>

            </tr>
            
            <tr>
                <td align="left">
                    <asp:Label ID="Label4" runat="server" Text="GSTIN : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblGSTIN" runat="server"  CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td colspan="2" align="center">
                    <asp:Label ID="Label5" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label14" runat="server" Text="RBI Licence Number : "  CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label15" runat="server" Text="CIN : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblCIN" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td colspan="2" align="center">
                    <asp:Label ID="Label16" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblRBI" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="lblCompName" runat="server" CssClass="disp" Font-Bold="True"
                        Font-Size="XX-Large"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="lblCompAdd1" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="lblCompAdd2" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="lblSno" runat="server" Text="S.No : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblInvoiceNo" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblCompEmail" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblCompState" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblInvoiceDt" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    &nbsp;
                </td>
                <td  align="left">
                    &nbsp;
                </td>
                <td  align="left">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label18" runat="server" Text="Pax Name / Party Name : " CssClass="disp"></asp:Label>
                </td>
                <td colspan="4" align="left">
                    <asp:Label ID="lblPartyName" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label19" runat="server" Text="Address : " CssClass="disp"></asp:Label>
                </td>
                <td  align="left">
                    <asp:Label ID="lblPartyAddress" runat="server" Text="Party Address 1 & 2" 
                        CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td  align="left">
                    <asp:Label ID="Label2" runat="server" Text="" 
                        CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td  align="left">
                    <asp:Label ID="Label12" runat="server" Text="Proceed To :" 
                        CssClass="disp" ></asp:Label>
                </td>
                <td  align="left">
                    <asp:Label ID="lblProceedToReport" runat="server" Text="" 
                        CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label9" runat="server" Text="Mobile : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPartyMobile" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label11" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblState" runat="server" Text="State : "  CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPartyState" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label10" runat="server" Text="GSTIN/UIN : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPartyGSTIN" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label13" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label20" runat="server" Text="Nationality :" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPartyNation" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                 <%--   <asp:Label ID="Label12" runat="server" Text="Proceed to : " CssClass="disp"></asp:Label>--%>
                </td>
                <td align="left">
                    <%--<asp:Label ID="lblProceed" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>--%>
                </td>
                <td align="left">
                    <asp:Label ID="Label21" runat="server" Text=" " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label22" runat="server" Text="Passport No :" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPassportNo" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td  align="left">
                    &nbsp;
                </td>
                <td  align="left">
                    &nbsp;
                </td>
                <td  align="left">
                    &nbsp;
                </td>
                <td align="right">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="5" align="left">
               
                    <table id="currencyTable" runat="server" width="900px" cellpadding="2" cellspacing="0" border="1">
                        <tr>
                            <td align="center">
                                <asp:Label ID="Label23" runat="server" Text="CURRENCY" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label24" runat="server" Text="HSN CODE" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label25" runat="server" Text="AMOUNT" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label26" runat="server" Text="RATE" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="Label27" runat="server" Text="RUPEE EQUIVALENT" CssClass="disp"
                                    Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                      
                        <tr id="currencyRow" runat="server">
                            <td align="center">
                                <asp:Label ID="lblCurr" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblHSN" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblFXNo" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:Label ID="lblRate" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:Label ID="LblAmount" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                            </td>
                        </tr>


                       
                        <%--<tr>
                            <td align="center">
                                &nbsp;
                            </td>
                            <td align="center">
                                &nbsp;
                            </td>
                            <td align="center">
                                &nbsp;
                            </td>
                            <td align="center">
                                &nbsp;
                            </td>
                            <td align="center">
                                &nbsp;
                            </td>
                        </tr>--%>
                    
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label28" runat="server" Text="DENOMINATION " CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="right">
                    <asp:Label ID="Label29" runat="server" Text="TAXABLE VALUE" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label30" runat="server" Text="CGST 9%" CssClass="disp"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="lblAmtCGST" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label31" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label32" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label33" runat="server" Text="SGST 9%" CssClass="disp"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="lblAmtSGST" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label34" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label35" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label36" runat="server" Text="IGST 18%" CssClass="disp"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="lblAmtIGST" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label37" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label38" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label39" runat="server" Text="TOTAL" CssClass="disp"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="lblAmtTotal" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label40" runat="server" Text="Total Invoice Value in Words" CssClass="disp"></asp:Label>
                </td>
                <td colspan="4" align="left">
                    <asp:Label ID="lblAmtWords" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="5" align="left">
                    <asp:Label ID="Label41" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label43" runat="server" Text="PAYMENT DETAILS:" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label44" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="lblCompName1" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label47" runat="server" Text="Cash No/Cash" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label48" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label51" runat="server" Text="Date : " CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label49" runat="server" Text="(Signature of Authorised Official)"
                        CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label45" runat="server" Text="Bank" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPayBank" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="Label50" runat="server" Text="Name" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="lblOffName" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label46" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label52" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label53" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="Label54" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label55" runat="server" Text="Customer Signature" CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="Label56" runat="server" Text="" CssClass="disp"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="Label57" runat="server" Text="Designation" CssClass="disp"></asp:Label>
                </td>
                <td colspan="2" align="left">
                    <asp:Label ID="lblOffDesig" runat="server" Text="" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
            </tr>
            <tr>
                <td  align="left">
                   <asp:Button ID="btnClose" Class="btn btn-danger" runat="server" OnClick="btnCancel_Click" Text="Close" />
                </td>
                <td align="left">
                    &nbsp;
                </td>
                <td align="left">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
            </tr>

            <tr>
                <td  align="left">
                  
                </td>
                <td align="left">
                    &nbsp;
                </td>
                <td align="left">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
                <td  align="right">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
        <div class="footer">
            <br />
            
            <asp:SqlDataSource ID="dsIcity" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [CITY_ID], [CITY_NAME] FROM [MST_CITY] ORDER BY [CITY_NAME]"></asp:SqlDataSource>
            <br />
            <br />
        </div>
    </asp:Panel>
     </div>
</asp:Content>
