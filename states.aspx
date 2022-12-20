<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="states.aspx.cs" Inherits="DreamForex.states" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
       td,th{
    padding:6px;
}
   </style>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
  
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <br />
    <br />
    <div class="row">
        <div class="col-md-4">
            <h3>State - Cities</h3>
            <ajaxToolkit:ComboBox ID="cmbState" runat="server" AppendDataBoundItems="True" AutoCompleteMode="SuggestAppend" AutoPostBack="True" DataSourceID="dsState" DataTextField="STATE_NAME" DataValueField="STATE_ID" MaxLength="0" Style="display: inline;" OnSelectedIndexChanged="cmbState_SelectedIndexChanged">
                <asp:ListItem Text="Select State" Value="" Selected="True"></asp:ListItem>
            </ajaxToolkit:ComboBox>
            <br />
            <asp:SqlDataSource ID="dsState" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT * FROM [MST_STATE] ORDER BY [STATE_NAME]"></asp:SqlDataSource>
            <br />
            <ajaxToolkit:ComboBox ID="cmbCity" runat="server" AppendDataBoundItems="True" AutoCompleteMode="SuggestAppend" AutoPostBack="True" DataSourceID="dsCity" DataTextField="CITY_NAME" DataValueField="CITY_ID" MaxLength="0" Style="display: inline;">
                <asp:ListItem Text="Select City" Value="" Selected="True"></asp:ListItem>
            </ajaxToolkit:ComboBox>
            <br />
            <asp:SqlDataSource ID="dsCity" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" SelectCommand="SELECT [CITY_ID], [CITY_NAME] FROM [MST_CITY] WHERE ([STATE_ID] = @STATE_ID) ORDER BY [CITY_NAME]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cmbState" Name="STATE_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>

         <script type="text/javascript">
    $(function () {
        $("[id*=GridView1]").DataTable(
        {
            bLengthChange: true,
            lengthMenu: [[5, 10, -1], [5, 10, "All"]],
            bFilter: true,
            bSort: true,
            bPaginate: true
        });
    });
         </script>
        <div class="col-md-6">
             <h3>Country - Currency Codes</h3>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" 
                 SelectCommand="SELECT MST_COUNTRY.COUNTRY_NAME, MST_CURRENCY.CURR_CODE, MST_CURRENCY.CURR_NAME FROM MST_COUNTRY LEFT OUTER JOIN MST_CURRENCY ON MST_COUNTRY.COUNTRY_ID = MST_CURRENCY.COUNTRY_ID ORDER BY MST_COUNTRY.COUNTRY_NAME"></asp:SqlDataSource>
             <br />
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ClientIDMode="Static" CellPadding="4" ForeColor="#333333" GridLines="None">
                 <AlternatingRowStyle BackColor="White" />
                 <Columns>
                     <asp:TemplateField HeaderText="Sl. No.">
                         <ItemTemplate>
                             <%#Container.DataItemIndex+1 %>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" />
                     </asp:TemplateField>
                     <asp:CommandField ShowSelectButton="True" />
                     <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Country" SortExpression="COUNTRY_NAME" />
                     <asp:BoundField DataField="CURR_CODE" HeaderText="Currency Code" SortExpression="CURR_CODE" />
                     <asp:BoundField DataField="CURR_NAME" HeaderText="Currency Name" SortExpression="CURR_NAME" />
                 </Columns>
                 <EditRowStyle BackColor="#7C6F57" />
                 <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                 <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                 <RowStyle BackColor="#E3EAEB" />
                 <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                 <SortedAscendingCellStyle BackColor="#F8FAFA" />
                 <SortedAscendingHeaderStyle BackColor="#246B61" />
                 <SortedDescendingCellStyle BackColor="#D4DFE1" />
                 <SortedDescendingHeaderStyle BackColor="#15524A" />
             </asp:GridView>

            
        </div>
        <div class="col-md-2">
        </div>

    </div>
</asp:Content>
