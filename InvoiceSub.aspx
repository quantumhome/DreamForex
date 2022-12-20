<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="InvoiceSub.aspx.cs" Inherits="DreamForex.InvoiceSub" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <table class="table table-bordered table-responsive">
            <thead>
                <tr>
                    <th>Currency</th>
                    <th>Product</th>
                    <th>Current Rate</th>
                    <th>Fx Amount</th>
                    <th>INR Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <asp:SqlDataSource ID="dsCurrency" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT DISTINCT LIVE_CURR_RATE.CURR_CODE, LIVE_CURR_RATE.CURR_CODE + ' : ' + MST_CURRENCY.CURR_NAME AS Expr1 FROM MST_CURRENCY RIGHT OUTER JOIN LIVE_CURR_RATE ON MST_CURRENCY.CURR_CODE = LIVE_CURR_RATE.CURR_CODE ORDER BY LIVE_CURR_RATE.CURR_CODE"></asp:SqlDataSource>
                        <asp:DropDownList ID="ddlCurrency" runat="server" AppendDataBoundItems="True" DataSourceID="dsCurrency" DataTextField="Expr1" DataValueField="CURR_CODE">
                            <asp:ListItem Text="Select Currency" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:SqlDataSource ID="dsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT PROD_ID, PURPOSE + ' : ' + PROD_NAME AS Expr1 FROM MST_PRODUCT"></asp:SqlDataSource>
                        <asp:DropDownList ID="ddlProduct" runat="server" AppendDataBoundItems="True" DataSourceID="dsProduct" DataTextField="Expr1" DataValueField="PROD_ID" AutoPostBack="True" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                            <asp:ListItem Text="Select Product" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:SqlDataSource ID="dsRate" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="getRate" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCurrency" Name="currCode" PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="ddlProduct" Name="prodId" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="lblCurrRate" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFxAmount" runat="server" Width="75px" AutoPostBack="True" OnTextChanged="txtFxAmount_TextChanged" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFxAmount" Display="Dynamic" ErrorMessage="Pl fill up Amount" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:Label ID="lblInrAmount" runat="server"></asp:Label>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
