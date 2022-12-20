<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminBookDet.aspx.cs" Inherits="DreamForex.AdminBookDet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
    <br />
    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="Label1" runat="server" Style="font-size: small" Text="Admin "></asp:Label>
            <br />
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="dsProd1" DataTextField="PURPOSE" DataValueField="PURPOSE" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem Text="Select Product" Value=""></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="dsProd" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                SelectCommand="SELECT PROD_ID, PURPOSE + ' - ' + PROD_NAME AS Prod FROM MST_PRODUCT ORDER BY PROD_ID"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsProd1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT distinct([PURPOSE]) FROM [MST_PRODUCT] ORDER BY [PURPOSE]"></asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="dsBuy" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                SelectCommand="AdminBuy" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsSell" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                SelectCommand=""></asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView1" runat="server" ClientIDMode="Static" CellPadding="4" ForeColor="#333333">
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
        </div>
    </div>

</asp:Content>
