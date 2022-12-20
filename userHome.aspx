<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="userHome.aspx.cs" Inherits="DreamForex.userHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblUserMessage"  runat="server" ClientIDMode="Static" Style="font-size: medium; color: #339933"></asp:Label>
    <h3>Booking Status</h3>
    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="dsProd1" DataTextField="PURPOSE" DataValueField="PURPOSE" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Text="Select Product" Value=""></asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="dsProd1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" 
        SelectCommand="SELECT distinct([PURPOSE]) FROM [MST_PRODUCT] ORDER BY [PURPOSE]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsBuy" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="ClientBuy" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="p_table" PropertyName="SelectedValue" Type="String" />
            <asp:SessionParameter Name="loginId" SessionField="loginId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br /><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BUYSELL_ID" DataSourceID="dsBuy" ForeColor="#333333" Visible="False">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
           <%-- <asp:BoundField DataField="LOGIN_ID" HeaderText="LOGIN_ID" SortExpression="LOGIN_ID" />
            <asp:BoundField DataField="BUYSELL_ID" HeaderText="BUY/Sell ID" InsertVisible="False" ReadOnly="True" SortExpression="BUYSELL_ID" />--%>
            <asp:BoundField DataField="BOOKING_NO" HeaderText="BOOKING_NO" SortExpression="BOOKING_NO" />
            <asp:BoundField DataField="DT_BOOKING" HeaderText="DT_BOOKING" SortExpression="DT_BOOKING" />
            <asp:BoundField DataField="MEM_NAME" HeaderText="MEM_NAME" SortExpression="MEM_NAME" />
            <asp:BoundField DataField="MOBILENO" HeaderText="MOBILENO" SortExpression="MOBILENO" />
            <asp:BoundField DataField="EMAILID" HeaderText="EMAILID" SortExpression="EMAILID" />
            <asp:BoundField DataField="CURR_CODE" HeaderText="CURR_CODE" SortExpression="CURR_CODE" />
            <asp:BoundField DataField="FX_QTY" HeaderText="FX_QTY" SortExpression="FX_QTY" />
            <asp:BoundField DataField="PROD_ID" HeaderText="PROD_ID" SortExpression="PROD_ID" Visible="false" />
             <asp:BoundField DataField="PROD_NAME" HeaderText="PROD_ID" SortExpression="PROD_ID" />
          <%--  <asp:BoundField DataField="ONLINE_TRANS_ID" HeaderText="ONLINE_TRANS_ID" SortExpression="ONLINE_TRANS_ID" />
            <asp:BoundField DataField="AMT_ONLINE" HeaderText="AMT_ONLINE" SortExpression="AMT_ONLINE" />--%>
            <asp:BoundField DataField="RATE_TO_CLIENT" HeaderText="RATE" SortExpression="RATE_TO_CLIENT" />
            <%--<asp:BoundField DataField="CURRENT_RATE" HeaderText="CURRENT_RATE" SortExpression="CURRENT_RATE" />--%>
           <%-- <asp:BoundField DataField="COMM_COMPANY" HeaderText="COMM_COMPANY" SortExpression="COMM_COMPANY" />
            <asp:BoundField DataField="COMM_DREAM" HeaderText="COMM_DREAM" SortExpression="COMM_DREAM" />--%>
            <asp:BoundField DataField="AMOUNT_TOTAL" HeaderText="AMOUNT_TOTAL" SortExpression="AMOUNT_TOTAL" />
           <%-- <asp:BoundField DataField="AMOUNT_COMPANY" HeaderText="AMOUNT_COMPANY" SortExpression="AMOUNT_COMPANY" />
            <asp:BoundField DataField="AMOUNT_DREAM" HeaderText="AMOUNT_DREAM" SortExpression="AMOUNT_DREAM" />--%>
           <%-- <asp:BoundField DataField="INVOICE_ID" HeaderText="INVOICE_ID" SortExpression="INVOICE_ID" />
            <asp:BoundField DataField="DT_INVOICE" HeaderText="DT_INVOICE" SortExpression="DT_INVOICE" />--%>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <EmptyDataTemplate>
            <br />
            <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Sorry, No Data Found.."></asp:Label>
            <br />
        </EmptyDataTemplate>
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
    <br />

</asp:Content>
