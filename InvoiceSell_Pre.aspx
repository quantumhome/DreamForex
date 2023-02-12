<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="InvoiceSell_Pre.aspx.cs" Inherits="DreamForex.InvoiceSell_Pre" %>

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
        <asp:Button ID="Button1" class="btn btn-basic" runat="server" Text="<< Back" PostBackUrl="~/AdminHome.aspx" />
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
    <asp:SqlDataSource ID="dsInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT TOP (1000) [INVOICE_ID],
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
  FROM [FOREX].[dbo].[INVOICE]  WHERE LOGIN_ID = @LOGIN_ID AND BOOKING_NO=@BOOKING_NO ORDER BY [INVOICE_SERIAL_NO]" >
        <SelectParameters>
            <asp:SessionParameter Name="LOGIN_ID" SessionField="iLoginId" Type="Int32" />
             <asp:SessionParameter Name="BOOKING_NO" SessionField="iBookingNo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
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
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MEMBER_ID" DataSourceID="dsUser2" ForeColor="#333333" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField HeaderText="Invoice" ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnGenInv" class="btn btn-info " runat="server" CommandName="select"> <small>Invoice Details</small></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Certificate Details" ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="lblCertificateInv" class="btn btn-info " runat="server" CommandName="select"> <small>Certificate Details</small></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
           <%-- <asp:CommandField ShowEditButton="True" />--%>
            <asp:BoundField DataField="MEMBER_ID" HeaderText="MEMBER_ID" InsertVisible="False" ReadOnly="True" SortExpression="MEMBER_ID" Visible="False" />
            <asp:BoundField DataField="LOGIN_ID" HeaderText="LOGIN_ID" SortExpression="LOGIN_ID" Visible="False" />
            <asp:BoundField DataField="MEM_NAME" HeaderText="Name" SortExpression="MEM_NAME" />
            <asp:BoundField DataField="MEM_GENDER" HeaderText="Gender" SortExpression="MEM_GENDER" />
            <asp:TemplateField HeaderText="Contact" SortExpression="MEM_MOBILE">
                <EditItemTemplate>
                    <asp:TextBox ID="txtMEM_MOBILE" runat="server" Text='<%# Bind("MEM_MOBILE") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblMEM_MOBILE" runat="server" Text='<%# Bind("MEM_MOBILE") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblMEM_EMAIL" runat="server" Text='<%# Eval("MEM_EMAIL") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MEM_EMAIL" HeaderText="MEM_EMAIL" SortExpression="MEM_EMAIL" Visible="False" />
            <asp:TemplateField HeaderText="Address" SortExpression="MEM_ADD1">
                <EditItemTemplate>
                    <asp:TextBox ID="txtMEM_ADD1" runat="server" Text='<%# Bind("MEM_ADD1") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblMEMADD1" runat="server" Text='<%# Bind("MEM_ADD1") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblMEM_ADD2" runat="server" Text='<%# Eval("MEM_ADD2") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MEM_ADD2" HeaderText="MEM_ADD2" SortExpression="MEM_ADD2" Visible="False" />
            <asp:TemplateField HeaderText="City/State" SortExpression="STATE_ID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("STATE_ID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCITY_NAME" runat="server" Text='<%# Bind("CITY_NAME") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblSTATE_NAME" runat="server" Text='<%# Eval("STATE_NAME") %>'></asp:Label>
                    &nbsp;-
                    <asp:Label ID="lblPIN" runat="server" Text='<%# Eval("PIN") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lblCOUNTRY_NAME" runat="server" Text='<%# Eval("COUNTRY_NAME") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CITY_ID" HeaderText="CITY_ID" SortExpression="CITY_ID" Visible="False" />
            <asp:BoundField DataField="PIN" HeaderText="PIN" SortExpression="PIN" Visible="False" />
            <asp:BoundField DataField="PAN_NO" HeaderText="PAN No." SortExpression="PAN_NO" />
            <asp:BoundField DataField="PAN_FILE_NAME" HeaderText="PAN_FILE_NAME" SortExpression="PAN_FILE_NAME" Visible="False" />
            <asp:BoundField DataField="PASSPORT_NO" HeaderText="Passport No." SortExpression="PASSPORT_NO" />
            <asp:BoundField DataField="PASSPORT_FILE_NAME" HeaderText="PASSPORT_FILE_NAME" SortExpression="PASSPORT_FILE_NAME" Visible="False" />
            <asp:BoundField DataField="COUNTRY_ID" HeaderText="COUNTRY_ID" SortExpression="COUNTRY_ID" Visible="False" />
            <asp:BoundField DataField="DT_REGN" HeaderText="DT_REGN" SortExpression="DT_REGN" Visible="False" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <EmptyDataTemplate>
            <br />
            <asp:Label ID="lblNoMemberFound" runat="server" Style="color: #CC0000" Text="No Member Found "></asp:Label>
            <br />
        </EmptyDataTemplate>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="dsCompany" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        SelectCommand="SELECT MST_COMPANY.*, MST_CITY.CITY_NAME, MST_STATE.STATE_NAME FROM MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID RIGHT OUTER JOIN MST_COMPANY ON MST_CITY.CITY_ID = MST_COMPANY.CITY_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMemberId" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT MST_USER_MEMBER.MEMBER_ID, MST_USER_MEMBER.LOGIN_ID, MST_USER_MEMBER.MEM_NAME, MST_USER_MEMBER.MEM_GENDER, MST_USER_MEMBER.MEM_MOBILE, MST_USER_MEMBER.MEM_EMAIL, MST_USER_MEMBER.MEM_ADD1, MST_USER_MEMBER.MEM_ADD2, MST_USER_MEMBER.STATE_ID, MST_USER_MEMBER.CITY_ID, MST_USER_MEMBER.PIN, MST_USER_MEMBER.PAN_NO, MST_USER_MEMBER.PAN_FILE_NAME, MST_USER_MEMBER.PASSPORT_NO, MST_USER_MEMBER.PASSPORT_FILE_NAME, MST_USER_MEMBER.COUNTRY_ID, MST_USER_MEMBER.DT_REGN, MST_CITY.CITY_NAME, MST_STATE.STATE_NAME, MST_COUNTRY.COUNTRY_NAME FROM MST_COUNTRY RIGHT OUTER JOIN MST_USER_MEMBER ON MST_COUNTRY.COUNTRY_ID = MST_USER_MEMBER.COUNTRY_ID LEFT OUTER JOIN MST_STATE INNER JOIN MST_CITY ON MST_STATE.STATE_ID = MST_CITY.STATE_ID ON MST_USER_MEMBER.CITY_ID = MST_CITY.CITY_ID WHERE (MST_USER_MEMBER.MEMBER_ID = @MEMBER_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView2" Name="MEMBER_ID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:LinkButton ID="lbtnAddNewMember" class="btn btn-warning" Visible="false" runat="server" OnClick="lbtnAddNewMember_Click">Add New Member</asp:LinkButton>
    <br />

    <!-- Modal -->
    <asp:LinkButton ID="lbtnDummy" runat="server"></asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        PopupControlID="panelPopup"
        TargetControlID="lbtnDummy"
        CancelControlID="btnClose"
        BackgroundCssClass="modalBg"  >
    </ajaxToolkit:ModalPopupExtender>
    
    <asp:SqlDataSource ID="dsBookingSell" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
        SelectCommand="SELECT * FROM [TRN_SELL] SELL JOIN [TRN_SELL_SUB] SELL_SUB ON SELL.SELL_ID = SELL.SELL_ID WHERE ([BOOKING_NO] = @BOOKING_NO)">
        <SelectParameters>
            <asp:SessionParameter Name="BOOKING_NO" SessionField="iBookingNo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="dsHsn" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [HSN]"></asp:SqlDataSource>
    
    <asp:Panel ID="panelPopup" runat="server"
        Style="background-color: #F9F9F9; padding: 15px"  Width="1000px" CssClass="popup" Height="800px" ScrollBars="Vertical" >
    
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
                <td colspan="4" align="left">
                    <asp:Label ID="lblPartyAddress" runat="server" Text="Party Address 1 & 2" 
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
                    <asp:Label ID="Label11" runat="server" Text="State : " CssClass="disp"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblPartyState" runat="server" CssClass="disp" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblStateCode" runat="server" Text="" CssClass="disp"></asp:Label>
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
                   <asp:Button ID="btnClose" Class="btn btn-danger" runat="server" Text="Close" />
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
</asp:Content>
