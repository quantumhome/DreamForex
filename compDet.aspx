<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="compDet.aspx.cs" Inherits="DreamForex.compDet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" DeleteCommand="DELETE FROM [MST_COMPANY] WHERE [COMP_ID] = @COMP_ID" InsertCommand="INSERT INTO [MST_COMPANY] ([COMP_NAME], [COMP_ADDRESS_1], [COMP_ADDRESS_2], [STATE_ID], [CITY_ID], [PIN], [EMAIL], [PHONE], [COMP_WEBSITE], [GSTIN], [CIN], [RBI_LIC_NO]) VALUES (@COMP_NAME, @COMP_ADDRESS_1, @COMP_ADDRESS_2, @STATE_ID, @CITY_ID, @PIN, @EMAIL, @PHONE, @COMP_WEBSITE, @GSTIN, @CIN, @RBI_LIC_NO)" SelectCommand="SELECT * FROM [MST_COMPANY]" UpdateCommand="UPDATE [MST_COMPANY] SET [COMP_NAME] = @COMP_NAME, [COMP_ADDRESS_1] = @COMP_ADDRESS_1, [COMP_ADDRESS_2] = @COMP_ADDRESS_2, [STATE_ID] = @STATE_ID, [CITY_ID] = @CITY_ID, [PIN] = @PIN, [EMAIL] = @EMAIL, [PHONE] = @PHONE, [COMP_WEBSITE] = @COMP_WEBSITE, [GSTIN] = @GSTIN, [CIN] = @CIN, [RBI_LIC_NO] = @RBI_LIC_NO WHERE [COMP_ID] = @COMP_ID">
        <DeleteParameters>
            <asp:Parameter Name="COMP_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="COMP_NAME" Type="String" />
            <asp:Parameter Name="COMP_ADDRESS_1" Type="String" />
            <asp:Parameter Name="COMP_ADDRESS_2" Type="String" />
            <asp:Parameter Name="STATE_ID" Type="Int32" />
            <asp:Parameter Name="CITY_ID" Type="Int32" />
            <asp:Parameter Name="PIN" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="PHONE" Type="String" />
            <asp:Parameter Name="COMP_WEBSITE" Type="String" />
            <asp:Parameter Name="GSTIN" Type="String" />
            <asp:Parameter Name="CIN" Type="String" />
            <asp:Parameter Name="RBI_LIC_NO" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="COMP_NAME" Type="String" />
            <asp:Parameter Name="COMP_ADDRESS_1" Type="String" />
            <asp:Parameter Name="COMP_ADDRESS_2" Type="String" />
            <asp:Parameter Name="STATE_ID" Type="Int32" />
            <asp:Parameter Name="CITY_ID" Type="Int32" />
            <asp:Parameter Name="PIN" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="PHONE" Type="String" />
            <asp:Parameter Name="COMP_WEBSITE" Type="String" />
            <asp:Parameter Name="GSTIN" Type="String" />
            <asp:Parameter Name="CIN" Type="String" />
            <asp:Parameter Name="RBI_LIC_NO" Type="String" />
            <asp:Parameter Name="COMP_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="5" DataKeyNames="COMP_ID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="Horizontal" HeaderText="Company Details">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <EmptyDataTemplate>
            No Data Found...<br />
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Add New</asp:LinkButton>
        </EmptyDataTemplate>
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="COMP_ID" HeaderText="COMP_ID" InsertVisible="False" ReadOnly="True" SortExpression="COMP_ID" />
            <asp:BoundField DataField="COMP_NAME" HeaderText="COMP_NAME" SortExpression="COMP_NAME" />
            <asp:BoundField DataField="COMP_ADDRESS_1" HeaderText="COMP_ADDRESS_1" SortExpression="COMP_ADDRESS_1" />
            <asp:BoundField DataField="COMP_ADDRESS_2" HeaderText="COMP_ADDRESS_2" SortExpression="COMP_ADDRESS_2" />
            <asp:BoundField DataField="STATE_ID" HeaderText="STATE_ID" SortExpression="STATE_ID" />
            <asp:BoundField DataField="CITY_ID" HeaderText="CITY_ID" SortExpression="CITY_ID" />
            <asp:BoundField DataField="PIN" HeaderText="PIN" SortExpression="PIN" />
            <asp:BoundField DataField="EMAIL" HeaderText="EMAIL" SortExpression="EMAIL" />
            <asp:BoundField DataField="PHONE" HeaderText="PHONE" SortExpression="PHONE" />
            <asp:BoundField DataField="COMP_WEBSITE" HeaderText="COMP_WEBSITE" SortExpression="COMP_WEBSITE" />
            <asp:BoundField DataField="GSTIN" HeaderText="GSTIN" SortExpression="GSTIN" />
            <asp:BoundField DataField="CIN" HeaderText="CIN" SortExpression="CIN" />
            <asp:BoundField DataField="RBI_LIC_NO" HeaderText="RBI_LIC_NO" SortExpression="RBI_LIC_NO" />
            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:DetailsView>
</asp:Content>
