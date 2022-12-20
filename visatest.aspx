<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="visatest.aspx.cs" Inherits="DreamForex.visatest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Visa</h3>
                <div>
                    <asp:Label ID="Label10" runat="server" Text="Visa Type :"></asp:Label>
                    <asp:DropDownList ID="ddlVisa" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsPurposeVisa" DataTextField="PROD_NAME" DataValueField="PROD_ID" ClientIDMode="Static" CausesValidation="True">
                        <asp:ListItem Text="Select Visa" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlVisa" Display="Dynamic" ErrorMessage="Pl select Visa Type" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label ID="Label11" runat="server" Text="Visa Country :"></asp:Label>
                    <asp:DropDownList ID="ddlCountry" class="btn btn-primary dropdown-toggle" runat="server" AppendDataBoundItems="True" DataSourceID="dsCountry" DataTextField="COUNTRY_NAME" DataValueField="COUNTRY_ID" ClientIDMode="Static" CausesValidation="True">
                        <asp:ListItem Text="Select Country" Value=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCountry" Display="Dynamic" ErrorMessage="Pl select Country" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label ID="Label12" runat="server" Text="Additional Message :"></asp:Label>

                    <asp:TextBox ID="txtMsg" runat="server" TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid values" ControlToValidate="txtMsg" SetFocusOnError="True" ValidationExpression="^[a-zA-Z0-9 ./,-]+$" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
                <div>
                     <asp:Button ID="Button3" runat="server" class="btn btn-danger" Text="Submit Request" OnClick="Button3_Click"  />

                     <br />
                     <br />
                     <asp:SqlDataSource ID="dsVisaInsert" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>" 
                         InsertCommand="INSERT INTO [TRN_VISA] ([BOOKING_NO], [DT_BOOKING],  [PROD_ID], [COUNTRY_ID]) VALUES (@BOOKING_NO, @DT_BOOKING,  @PROD_ID,  @COUNTRY_ID)" 
                       >
           
                         <InsertParameters>
                             <asp:Parameter Name="BOOKING_NO" Type="String" />
                             <asp:Parameter Name="DT_BOOKING" Type="DateTime" />
                             <asp:Parameter Name="PROD_ID" Type="Int32" />
                             <asp:Parameter Name="COUNTRY_ID" Type="Int32" />
                             <asp:Parameter Name="PROD_ID" Type="Int32" />
                         </InsertParameters>
                       
                     </asp:SqlDataSource>

                </div>
</asp:Content>
