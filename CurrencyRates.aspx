<%@ Page Title="Currency Rate" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CurrencyRates.aspx.cs" Inherits="DreamForex._CurrRates" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">

    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
           <script type="text/javascript">
               $(function () {
                   $("[id*=GridView1]").DataTable(
                       {
                           bLengthChange: true,
                           lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                        /*   pageLength:10,*/
                           bFilter: true,
                           bSort: true,
                           bPaginate: false
                       });
               });
           </script>
    <%--    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>--%>
    <div class="row">
        <div class="col-md-12">
            <h2>Currency Rates - Live</h2>
            <asp:Button ID="btnSubmit" runat="server" Text="Click to Get Current Rates" class="btn btn-primary btn-lg" OnClick="Button1_Click" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="dsLiveRate" ClientIDMode="Static" BorderColor="#337AB7" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Sl. No.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CURR_CODE" HeaderText="Currency Code" SortExpression="CURR_CODE" />
                    <asp:BoundField DataField="CURR_NAME" HeaderText="Currency Name" SortExpression="CURR_NAME" />
                    <asp:BoundField DataField="CURR_RATE_INR" HeaderText="Rate in Rs." SortExpression="CURR_RATE_INR" />
                    <asp:BoundField DataField="DT_UPD" HeaderText="Date As On" SortExpression="DT_UPD" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
              <%--  <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />--%>
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="dsCurrency" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                DeleteCommand="DELETE FROM [MST_CURRENCY] WHERE [CURR_ID] = @CURR_ID"
                InsertCommand="INSERT INTO [MST_CURRENCY] ([CURR_NAME], [CURR_CODE], [COUNTRY_ID]) VALUES (@CURR_NAME, @CURR_CODE, @COUNTRY_ID)"
                SelectCommand="SELECT * FROM [MST_CURRENCY] ORDER BY [CURR_CODE]"
                UpdateCommand="UPDATE [MST_CURRENCY] SET [CURR_NAME] = @CURR_NAME, [CURR_CODE] = @CURR_CODE, [COUNTRY_ID] = @COUNTRY_ID WHERE [CURR_ID] = @CURR_ID">
                <DeleteParameters>
                    <asp:Parameter Name="CURR_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CURR_NAME" Type="String" />
                    <asp:Parameter Name="CURR_CODE" Type="String" />
                    <asp:Parameter Name="COUNTRY_ID" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CURR_NAME" Type="String" />
                    <asp:Parameter Name="CURR_CODE" Type="String" />
                    <asp:Parameter Name="COUNTRY_ID" Type="Int32" />
                    <asp:Parameter Name="CURR_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="dsLiveRate" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" DeleteCommand="DELETE FROM [LIVE_CURR_RATE] WHERE [ID] = @ID"
                InsertCommand="insertLiveRate" InsertCommandType="StoredProcedure"
                SelectCommand="SELECT LIVE_CURR_RATE.CURR_CODE, MST_CURRENCY.CURR_NAME, LIVE_CURR_RATE.CURR_RATE_INR, LIVE_CURR_RATE.DT_UPD FROM LIVE_CURR_RATE LEFT OUTER JOIN MST_CURRENCY ON LIVE_CURR_RATE.CURR_CODE = MST_CURRENCY.CURR_CODE WHERE (MST_CURRENCY.ACTIVE = 1)"
                UpdateCommand="UPDATE [LIVE_CURR_RATE] SET [CURR_CODE] = @CURR_CODE, [CURR_RATE] = @CURR_RATE WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CURR_CODE" Type="String" />
                    <asp:Parameter Name="CURR_RATE" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CURR_CODE" Type="String" />
                    <asp:Parameter Name="CURR_RATE" Type="Double" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:Label ID="lblResult" runat="server"></asp:Label>
        </div>

    </div>

</asp:Content>
