<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="buySell.aspx.cs" Inherits="DreamForex.buySell" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        /*        td {
            line-height: 60px;
            text-align: center;
        }*/
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#ddlPurpose').change(function (e) {
                var product = e.currentTarget.id;
                var j_ddlCurr = $('#ddlCurr');
                var j_fxAmt = $('#txtFxAmt');
                if (j_ddlCurr.val() == '') {
                    alert("Pl select Currency");
                    j_ddlCurr.focus();
                    $('#ddlPurpose').val('');
                } else if (!$.isNumeric(j_fxAmt.val()) || j_fxAmt.val() == 0) {
                    alert(" Pl. fill up Forex Amount ");
                    $('#ddlPurpose').val('');
                    j_fxAmt.focus();
                }
                else {
                    var currCode = $('#ddlCurr').val();
                    var purpose = $('#ddlPurpose').val();
                    var fxQty = $('#txtFxAmt').val();
                    var url = 'RegistrationService.asmx/GetLiveRate';
                    $.ajax({
                        url: url,
                        method: 'post',
                        data: { pCurrCode: currCode, prodId: purpose, fxQty: fxQty },
                        dataType: 'json',
                        success: function (data) {
                            var lblAmt = $('#lblAmount');
                            var lblRateValue = $('#lblRateValue');
                            lblRateValue.text(data.rateToClient);
                            var finalRate = data.totAmount;
                            lblAmt.text('Amount in INR - Rs.' + finalRate) + '/-';
                            $('#hfTotAmt').val(finalRate);
                        },
                        error: function (err) {
                            alert("Error : " + err);
                        }
                    });
                }
            });

            $('#ddlCurr').change(function (e) {
                $('#ddlPurpose').val('');
                var lblAmt = $('#lblAmount');
                var lblRateValue = $('#lblRateValue');
                var txtFxAmt = $('#txtFxAmt');
                lblAmt.text("");
                lblRateValue.text("");
                txtFxAmt.val('');
            });

            $('#ddlCurrS').change(function (e) {
                $('#ddlProdS').val('');
                var lblAmtS = $('#lblAmtS');
                var lblRateSellValue = $('#lblRateSellValue');
                var txtFxQtyS = $('#txtFxQtyS');
                lblAmtS.text("");
                lblRateSellValue.text("");
                txtFxQtyS.text("");

            });
            $('#ddlProdS').change(function (e) {
                var product = e.currentTarget.id;
                var j_ddlCurr = $('#ddlCurrS');
                var j_fxAmt = $('#txtFxQtyS');
                if (j_ddlCurr.val() == '') {
                    alert("Pl select Currency");
                    j_ddlCurr.focus();
                    $('#ddlProdS').val('');
                } else if (!$.isNumeric(j_fxAmt.val()) || j_fxAmt.val() == 0) {
                    alert(" Pl. fill up Forex Amount ");
                    $('#ddlProdS').val('');
                    j_fxAmt.focus();
                }
                else {
                    var currCode = $('#ddlCurrS').val();
                    var purpose = $('#ddlProdS').val();;
                    var fxQty = $('#txtFxQtyS').val();
                    var url = 'RegistrationService.asmx/GetLiveRate';
                    $.ajax({
                        url: url,
                        method: 'post',
                        data: { pCurrCode: currCode, prodId: purpose, fxQty: fxQty },
                        dataType: 'json',
                        success: function (data) {
                            var lblAmt = $('#lblAmtS');
                            var lblRateSellValue = $('#lblRateSellValue');
                            lblRateSellValue.text(data.rateToClient);
                            var finalRate = data.totAmount;
                            lblAmt.text('Amount in INR - Rs.' + finalRate) + '/-';
                        },
                        error: function (err) {
                            alert("Error : " + err);
                        }
                    });
                }
            });

           
        });


    </script>
    <script type="text/javascript" language="javascript">
        function ToggleToSell() {
            $('#achormenu2').click();
            //var lblAmtS = $('#lblAmtS');
            //var lblRateSellValue = $('#lblRateSellValue');
            //var txtFxAmtS = $('#txtFxQtyS');
            //var j_ddlCurrS = $('#ddlCurrS');
            //var ddlProdS = $('#ddlProdS');
            //lblAmtS.text("");
            //lblRateSellValue.text("");
            //txtFxAmtS.val('');
            //j_ddlCurrS.val('');
            //ddlProdS.val('');
        }
        function ToggleToBuy() {
            var lblAmt = $('#lblAmount');
            var lblRateValue = $('#lblRateValue');
            var txtFxAmt = $('#txtFxAmt');
            var j_ddlCurr = $('#ddlCurr');
            var ddlPurpose = $('#ddlPurpose');
            lblAmt.text("");
            lblRateValue.text("");
            txtFxAmt.val("");
            j_ddlCurr.val('');
            ddlPurpose.val('');

        }
        function Validate() {
            var isValid = false;
            isValid = Page_ClientValidate('buyGrp');
            if (isValid) {
                isValid = Page_ClientValidate('buyGrp');
            }
            return isValid;
        }
    </script>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT CURR_CODE, CURR_CODE + ' - ' + CURR_NAME AS Curr, MAX_QTY FROM MST_CURRENCY WHERE (ACTIVE = 1) ORDER BY CURR_CODE + ' - ' + CURR_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPurpose" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [PROD_ID], [PROD_NAME] FROM [MST_PRODUCT] WHERE ([PURPOSE] = @PURPOSE)">
        <SelectParameters>
            <asp:Parameter DefaultValue="BUY" Name="PURPOSE" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="dsPurposeSell" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [PROD_ID], [PROD_NAME] FROM [MST_PRODUCT] WHERE ([PURPOSE] = @PURPOSE)">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELL" Name="PURPOSE" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPurposeVisa" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [PROD_ID], [PROD_NAME] FROM [MST_PRODUCT] WHERE ([PURPOSE] = @PURPOSE)">
        <SelectParameters>
            <asp:Parameter DefaultValue="VISA" Name="PURPOSE" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="dsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_COUNTRY] ORDER BY [COUNTRY_NAME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsInsBuy" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" InsertCommand="">
        <DeleteParameters>
            <asp:Parameter Name="BUY_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="BUY_ID" Type="Int32" />
            <asp:Parameter Name="ORDER_NO" Type="String" />
            <asp:Parameter Name="DT_TRANS" Type="DateTime" />
            <asp:Parameter Name="LOGIN_ID" Type="Int32" />
            <asp:Parameter Name="CURR_CODE" Type="String" />
            <asp:Parameter Name="FX_QTY" Type="Int32" />
            <asp:Parameter Name="PROD_ID" Type="Int32" />
            <asp:Parameter Name="ONLINE_TRANS_ID" Type="Object" />
            <asp:Parameter Name="AMT_ONLINE" Type="Double" />
            <asp:Parameter Name="RATE_TO_CLIENT" Type="Double" />
            <asp:Parameter Name="CURRENT_RATE" Type="Double" />
            <asp:Parameter Name="COMM_COMPANY" Type="Double" />
            <asp:Parameter Name="COMM_DREAM" Type="Double" />
            <asp:Parameter Name="AMOUNT_TOTAL" Type="Double" />
            <asp:Parameter Name="AMOUNT_COMPANY" Type="Double" />
            <asp:Parameter Name="AMOUNT_DREAM" Type="Double" />
            <asp:Parameter Name="INVOICE_ID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

    <div class="container" style="border: solid; border-width: 1px; border-color: lightgray">
        <h2>Forex Enquiries</h2>

       <ul id="menu" class="nav nav-tabs" >
            <li class="active"><a data-toggle="tab" href="#menu1">Buy Forex</a></li>
            <li><a id="achormenu2" data-toggle="tab" href="#menu2">Sell Forex</a></li>
            <li><a data-toggle="tab" href="#menu3">Visa</a></li>
        </ul>
        
<%--        <asp:Menu ID="menu" class="nav nav-tabs"   Orientation="Horizontal" runat="server">
            <Items>
                <asp:MenuItem Text="Buy Forex" cssClass="active" NavigateUrl="#menu1" runat="server" Selected="true" Enabled="true"></asp:MenuItem>
                <asp:MenuItem Text="Sell Forex" NavigateUrl="#menu2" runat="server"   Enabled="true"></asp:MenuItem>
                <asp:MenuItem Text="Visa" NavigateUrl="#menu3" runat="server"  Enabled="true" ></asp:MenuItem>
            </Items>
        </asp:Menu>--%>
         <%--<ul id="menu" runat="server" class="nav nav-tabs" >
            <li class="active">
              <asp:LinkButton  ID="menuBuy"  runat="server" data-toggle="tab" OnClick="BuyMenu_Click"> Buy Forex</asp:LinkButton>
            </li>
            <li> <asp:LinkButton  ID="menuSell" runat="server" data-toggle="tab" OnClick="SellMenu_Click" >Sell Forex</asp:LinkButton></li>
            <li><a data-toggle="tab" runat="server" href="#menu3" OnClick="VisaMenu_Click">Visa</a></li>
        </ul>--%>
        
        <div class="tab-content">
            <div id="menu1" class="tab-pane fade in active">
                <h3>Buy Forex</h3>

                <table cellpadding="5" style="background-color: azure">
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Select Currency : "></asp:Label>
                            <asp:DropDownList ID="ddlCurr" AutoPostBack="true" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="Curr" DataValueField="CURR_CODE" ClientIDMode="Static" OnSelectedIndexChanged="ddlCurr_SelectedIndexChanged">
                                <asp:ListItem Text="Select Currency" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqFielddlCurrency"  runat="server" ControlToValidate="ddlCurr" Display="Dynamic" ErrorMessage="Select Currency" ForeColor="Red" SetFocusOnError="True" ValidationGroup="buyGrp"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Forex Quantity: "></asp:Label>
                            <%--<asp:HiddenField ID="maxCurrencyValue" Value="0" runat="server" />--%>
                            <asp:TextBox ID="txtmaxCurrencyValue" runat="server" MaxLength="5" ClientIDMode="Static" Visible="false"></asp:TextBox>
                            <asp:TextBox ID="txtFxAmt" runat="server" MaxLength="5" ClientIDMode="Static" Width="70px"></asp:TextBox>
                            <asp:CompareValidator ID="cmpFielddlFxAmt" runat="server" ErrorMessage="Forex Quantity limit exceed" Display="Dynamic"  ControlToValidate="txtFxAmt" ControlToCompare="txtmaxCurrencyValue" Operator="LessThanEqual" Type="Double" ForeColor="Red" EnableClientScript="True" SetFocusOnError="True" CausesValidation="True" ValidationGroup="buyGrp"></asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="reqFielddlFxAmt"  runat="server" ControlToValidate="txtFxAmt" Display="Dynamic" ErrorMessage="Enter Forex Quantity" ForeColor="Red" SetFocusOnError="True" ValidationGroup="buyGrp"></asp:RequiredFieldValidator>
                            <%--<asp:RangeValidator ID="rangeValidator" ControlToValidate="txtFxAmt" runat="server"></asp:RangeValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Select Product :"></asp:Label>
                            <asp:DropDownList ID="ddlPurpose" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsPurpose" DataTextField="PROD_NAME" DataValueField="PROD_ID" ClientIDMode="Static" CausesValidation="True">
                                <asp:ListItem Text="Select Mode" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqFielddlddlPurpose"  runat="server" ControlToValidate="ddlPurpose" Display="Dynamic" ErrorMessage="Select Mode" ForeColor="Red" SetFocusOnError="True" ValidationGroup="buyGrp"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="lblRate" runat="server" Text="Rate :"></asp:Label>

                            <asp:Label ID="lblRateValue" runat="server" ClientIDMode="Static" Style="font-size: medium; color: #339933"></asp:Label>
                            <br />
                       <%--  (<asp:Label ID="lblClientComm" runat="server" ClientIDMode="Static" Style="font-size: x-small"></asp:Label>
                            &nbsp;
                            <asp:Label ID="lblDreamComm" runat="server" ClientIDMode="Static" Style="font-size: x-small"></asp:Label>
                            &nbsp;)--%>

                        </td>
                          
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:Label ID="lblAmount" runat="server" ClientIDMode="Static" Style="font-size: medium; color: #339933"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                        <asp:GridView ID="grdBuy1" runat="server" ClientIDMode="Static" CellPadding="4" ForeColor="#333333">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                             <asp:GridView ID="grdBuy" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" >
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="Booking Number" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblBookingNumber" runat="server" Text='<%# Bind("BOOKING_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency Code">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCurrencyCode" runat="server" Text='<%# Bind("Currency_Code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Forex Quantity"  >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblForexQuantity" runat="server" Text='<%# Bind("Forex_Quantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Id" Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblProductId" runat="server" Text='<%# Bind("Product_Id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblRate" runat="server" Text='<%# Bind("Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency Rate"  Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCurrentRate" runat="server" Text='<%# Bind("Current_Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="COMM COMPANY" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCOMMCOMPANY" runat="server" Text='<%# Bind("COMM_COMPANY") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="COMM DREAM" >
                                <ItemTemplate>
                                      <asp:Label ID="grdLblCOMM_DREAM" runat="server" Text='<%# Bind("COMM_DREAM") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="AMOUNT TOTAL" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTTOTAL" runat="server" Text='<%# Bind("AMOUNT_TOTAL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="AMOUNT Company"  Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTCompany" runat="server" Text='<%# Bind("AMOUNT_Company") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="AMOUNT Dream"  Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTDream" runat="server" Text='<%# Bind("AMOUNT_Dream") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />
                    </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                          <td style="text-align: right">
                              <asp:Button ID="btnAddMore" runat="server" class="btn btn-primary" Text="Add More"  OnClientClick="if(Validate()==false){return false;}" OnClick="btnAddMore_Click" />
                        </td>
                        <td style="text-align: left">
                            <asp:Button ID="btnBuyNow" runat="server" class="btn btn-primary" Text="Buy Now" Enabled="false" OnClick="btnBuyNow_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:Button ID="Button2" runat="server" class="btn btn-danger" Text="Live Exchange Rates" PostBackUrl="~/CurrencyRates.aspx" />
                            <br />
                            <%--                            <asp:HiddenField ID="hfBuyId" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="hfRate" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="hfClientRate" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="hfDreamRate" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="hfTotAmt" runat="server" ClientIDMode="Static" />--%>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </div>

            <div id="menu2" class="tab-pane fade">
                <h3>Sell Forex</h3>
                <table cellpadding="5" style="background-color: azure">
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Select Currency : "></asp:Label>
                            <asp:DropDownList ID="ddlCurrS" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="Curr" DataValueField="CURR_CODE" ClientIDMode="Static">
                                <asp:ListItem Text="Select Currency" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvddlCurrS"  runat="server" ControlToValidate="ddlCurrS" Display="Dynamic" ErrorMessage="Select Currency" ForeColor="Red" SetFocusOnError="True" ValidationGroup="sellGrp"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Forex Quantity : "></asp:Label>
                            <asp:TextBox ID="txtFxQtyS" runat="server" MaxLength="6" ClientIDMode="Static" Width="70px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxtFxQtyS"  runat="server" ControlToValidate="txtFxQtyS" Display="Dynamic" ErrorMessage="Enter Forex Quantity" ForeColor="Red" SetFocusOnError="True" ValidationGroup="sellGrp"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Select Product : "></asp:Label>
                            <asp:DropDownList ID="ddlProdS" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsPurposeSell" DataTextField="PROD_NAME" DataValueField="PROD_ID" ClientIDMode="Static" CausesValidation="True">
                                <asp:ListItem Text="Select Product" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvddlProdS"  runat="server" ControlToValidate="ddlProdS" Display="Dynamic" ErrorMessage="Select Product" ForeColor="Red" SetFocusOnError="True" ValidationGroup="sellGrp"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label7" runat="server" ClientIDMode="Static" Style="font-size: medium; color: #FF0000"></asp:Label>
                            <asp:Label ID="lblRateSell" runat="server" Text="Rate : "></asp:Label>
                            <asp:Label ID="lblRateSellValue" runat="server" ClientIDMode="Static" Style="font-size: medium; color: #339933"></asp:Label>
                            <br />
                           <%-- (

                            <asp:Label ID="Label8" runat="server" ClientIDMode="Static" Style="font-size: x-small"></asp:Label>
                            &nbsp;
                            <asp:Label ID="Label9" runat="server" ClientIDMode="Static" Style="font-size: x-small"></asp:Label>
                            &nbsp;)</td>--%>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:Label ID="lblAmtS" runat="server" ClientIDMode="Static" Style="font-size: medium; color: #339933"></asp:Label>
                        </td>
                    </tr>
                        <tr>
                        <td colspan="2" style="text-align: center">
                          <asp:GridView ID="grdSell" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" >
                          <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        <Columns>
                            <asp:TemplateField HeaderText="Booking Number" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblBookingNumber" runat="server" Text='<%# Bind("BOOKING_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency Code">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCurrencyCode" runat="server" Text='<%# Bind("Currency_Code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Forex Quantity"  >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblForexQuantity" runat="server" Text='<%# Bind("Forex_Quantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Id" Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblProductId" runat="server" Text='<%# Bind("Product_Id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblRate" runat="server" Text='<%# Bind("Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency Rate"  Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCurrentRate" runat="server" Text='<%# Bind("Current_Rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="COMM COMPANY" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblCOMMCOMPANY" runat="server" Text='<%# Bind("COMM_COMPANY") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="COMM DREAM" >
                                <ItemTemplate>
                                      <asp:Label ID="grdLblCOMM_DREAM" runat="server" Text='<%# Bind("COMM_DREAM") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="AMOUNT TOTAL" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTTOTAL" runat="server" Text='<%# Bind("AMOUNT_TOTAL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="AMOUNT Company"  Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTCompany" runat="server" Text='<%# Bind("AMOUNT_Company") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="AMOUNT Dream"  Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="grdLblAMOUNTDream" runat="server" Text='<%# Bind("AMOUNT_Dream") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                        <SortedAscendingCellStyle BackColor="#FDF5AC" />
                        <SortedAscendingHeaderStyle BackColor="#4D0000" />
                        <SortedDescendingCellStyle BackColor="#FCF6C0" />
                        <SortedDescendingHeaderStyle BackColor="#820000" />
                    </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">
                              <asp:Button ID="btnAddMoreSell" runat="server" class="btn btn-primary" Text="Add More" ValidationGroup="sellGrp" OnClientClick="ToggleToSell();" OnClick="btnAddMoreSell_Click" />
                        </td>
                         <td style="text-align: left">
                            <asp:Button ID="btnSell" runat="server" class="btn btn-primary" Text="Sell Now" Enabled="false"  OnClick="btnSell_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:Button ID="Button4" runat="server" class="btn btn-danger" Text="Live Exchange Rates" PostBackUrl="~/CurrencyRates.aspx" />
                            <br />
                            <%--                            <asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="HiddenField2" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="HiddenField3" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="HiddenField4" runat="server" ClientIDMode="Static" />
                            <asp:HiddenField ID="HiddenField5" runat="server" ClientIDMode="Static" />--%>
                        </td>
                    </tr>
                </table>

            </div>

            <div id="menu3" class="tab-pane fade">
                <h3>Visa</h3>
                 <div>
                    <asp:Label ID="Label10" runat="server" Text="Visa Type :"></asp:Label>
                    <asp:DropDownList ID="ddlVisa" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsPurposeVisa" DataTextField="PROD_NAME" DataValueField="PROD_ID" ClientIDMode="Static" CausesValidation="True">
                        <asp:ListItem Text="Select Visa" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  runat="server" ControlToValidate="ddlVisa" Display="Dynamic" ErrorMessage="Pl select Visa Type" ForeColor="Red" SetFocusOnError="True" ValidationGroup="visaGrp"></asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label ID="Label11" runat="server" Text="Visa Country :"></asp:Label>
                    <asp:DropDownList ID="ddlCountry" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsCountry" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID" ClientIDMode="Static" CausesValidation="True">
                        <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCountry" Display="Dynamic" ErrorMessage="Pl select Country" ForeColor="Red" SetFocusOnError="True" ValidationGroup="visaGrp"></asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label ID="Label12" runat="server" Text="Additional Message :"></asp:Label>

                    <asp:TextBox ID="txtMsg" runat="server" TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid values" ControlToValidate="txtMsg" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9 ./,-]+$" Display="Dynamic" ForeColor="Red" ValidationGroup="visaGrp"></asp:RegularExpressionValidator>
                </div>
                <div>
                     <asp:Button ID="btnVisa" runat="server" class="btn btn-danger" Text="Submit Request" OnClick="btnVisa_Click"  ValidationGroup="visaGrp" />

                </div>

            </div>
        </div>
    </div>


</asp:Content>
