<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="DreamForex.AdminHome1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "users";
            $('#dvTab a[href="#' + tabId + '"]').tab('show');
            $("#dvTab a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });
    </script>
    <br />
    
    <div id="dvTab">
        <ul class="nav nav-tabs">
            <li><a data-toggle="tab" href="#users" ><div class="btn btn-primary">Create/Edit Users</div></a></li>
            <li><a data-toggle="tab" href="#book"><div class="btn btn-primary">Booking Status</div></a></li>
        </ul>

        <div class="tab-content">
            <div id="users" class="tab-pane fade ">
                <h3>Manage Users</h3>
                <div class="form-horizontal col-sm-6" style="border: thin solid #00CC66; background-color: #F2FFF2; padding-top: 15px">
                    <asp:SqlDataSource ID="dsOffUsers" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                        InsertCommand="registerOfficeUser" InsertCommandType="StoredProcedure"
                        UpdateCommand="updateOfficeUser" UpdateCommandType="StoredProcedure" OnInserted="dsOffUsers_Inserted"
                        SelectCommand="select * from mst_office_user">
                        <InsertParameters>
                            <asp:Parameter Name="OFF_USER_NAME" Type="String" />
                            <asp:Parameter Name="OFF_NAME" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                            <asp:Parameter Name="MOBILENO" Type="String" />
                            <asp:Parameter Name="EMAILID" Type="String" />
                            <asp:Parameter Name="result" Type="String" Direction="Output" Size="4" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="OFF_USER_NAME" Type="String" />
                            <asp:Parameter Name="OFF_NAME" Type="String" />
                            <asp:Parameter Name="Password" Type="String" />
                            <asp:Parameter Name="MOBILENO" Type="String" />
                            <asp:Parameter Name="EMAIL" Type="String" />
                            <asp:Parameter Name="OFF_ID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="txtLogin">Enter login name :</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtLogin" class="form-control" placeholder="Enter login name" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLogin" Display="Dynamic" ErrorMessage="Pl. enter login name" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="txtPwd">Password:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtPwd" class="form-control" placeholder="Enter password" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPwd" Display="Dynamic" ErrorMessage="Pl. enter password" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="pwd1">Confirm Password:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtPwd1" class="form-control" placeholder="Enter password again" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPwd1" Display="Dynamic" ErrorMessage="Pl. enter password" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPwd" ControlToValidate="txtPwd1" Display="Dynamic" ErrorMessage="Passwords Do Not Match" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:CompareValidator>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="txtName">Enter Name of user :</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtName" class="form-control" placeholder="Enter Name of user" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Pl entr Name of the User" ControlToValidate="txtName" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="txtMobile">Mobile Number :</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtMobile" class="form-control" placeholder="Mobile Number" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Pl enter Mobile No." ControlToValidate="txtMobile" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Pl enter Valid Mobile No" ControlToValidate="txtMobile" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{10}" ValidationGroup="users"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="txtEmail">Email:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtEmail" class="form-control" placeholder="Enter email" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Pl enter Email" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationGroup="users"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Pl enter Valid Email" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="users"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-4">
                            <asp:Button ID="btnSubmit" class="btn btn-primary" runat="server" Text="Submit" ValidationGroup="users" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                    <asp:Panel ID="PanelUserSuccess" runat="server" Visible="False">
                        <div class="alert alert-success">
                            <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="PanelUserFail" runat="server" Visible="False">
                        <div class="alert alert-danger">
                            &nbsp;<asp:Label ID="lblFail" runat="server" Text=""></asp:Label>
                        </div>
                    </asp:Panel>
                </div>
                <div class=" col-sm-6">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="OFF_ID" DataSourceID="dsOffUsers" CellPadding="4" ForeColor="#333333" OnRowUpdating="GridView1_RowUpdating">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="gvEdit"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" ValidationGroup="gvEdit"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OFF_ID" HeaderText="OFF_ID" InsertVisible="False" ReadOnly="True" SortExpression="OFF_ID" Visible="False" />
                            <asp:TemplateField HeaderText="Name" SortExpression="OFF_NAME">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("OFF_NAME") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Pl type in Name" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("OFF_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Login name" SortExpression="OFF_USER_NAME">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("OFF_USER_NAME") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Pl type in Login name" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("OFF_USER_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text="Password : "></asp:Label>
                                    <asp:TextBox ID="txtPwd" runat="server" MaxLength="15" TextMode="Password"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="LabelPwd" runat="server" Text="Confirm Password : "></asp:Label>
                                    <asp:TextBox ID="txtPwd1" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtPwd" ControlToValidate="txtPwd1" Display="Dynamic" ErrorMessage="Passwords Do Not Match" ForeColor="Red" SetFocusOnError="True" ValidationGroup="gvEdit"></asp:CompareValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile No." SortExpression="MOBILENO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Pl type in Mobile No." ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Not a Valid Mobile No." ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[789]\d{9}"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" SortExpression="EMAIL">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("EMAIL") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Pl type in Email" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Not a Valid Email" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("EMAIL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Updated On" SortExpression="DT_UPD">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("DT_UPD", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("DT_UPD", "{0:dd-MMM-yyyy}") %>'></asp:Label>
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
                </div>
            </div>

            <div id="book" class="tab-pane fade active">
                <h3>Booking Status</h3>
                <div class="form-horizontal" style="border: thin solid #00CC66; background-color: aliceblue; padding-top: 15px">
                    <div class="row">
                        <div class="col-md-12">
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
                                SelectCommand="AdminBuy" SelectCommandType="StoredProcedure" UpdateCommand="UpdateAdminBuy" UpdateCommandType="StoredProcedure" >
                                <UpdateParameters>
                                    <asp:Parameter Name="AMOUNT_TOTAL_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="AMOUNT_COMPANY_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="RATE_TO_CLIENT_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="BUY_SUB_ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsSell" runat="server" ConnectionString="<%$ ConnectionStrings:FOREXConnectionString %>"
                                SelectCommand="AdminSell" SelectCommandType="StoredProcedure" UpdateCommand="UpdateAdminSell" UpdateCommandType="StoredProcedure" >
                                 <UpdateParameters>
                                    <asp:Parameter Name="AMOUNT_TOTAL_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="AMOUNT_COMPANY_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="RATE_TO_CLIENT_INVOICE" Type="Decimal" />
                                    <asp:Parameter Name="SELL_SUB_ID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                           
                            <br /><br />
                            <div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                              <ContentTemplate>
                      <%--         <asp:GridView ID="gvBuy" runat="server" ClientIDMode="Static" CellPadding="4" ForeColor="#333333"  AutoGenerateColumns="False" DataSourceID="dsBuy" Visible="False"  OnRowUpdating="gvBuy_RowUpdating">--%>
                              <asp:GridView ID="gvBuy" runat="server" ClientIDMode="Static" CellPadding="4" ForeColor="#333333"  AutoGenerateColumns="False" DataSourceID="dsBuy" Visible="False" OnRowUpdating="gvBuy_RowUpdating" OnRowEditing="OnBuyRowEditing" OnRowDataBound="gvBuy_RowDataBound">
                                <EmptyDataTemplate>
                                    <br />
                                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="Sorry, No Data Found.."></asp:Label>
                                    <br />
                                </EmptyDataTemplate>

                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="BUY_ID" HeaderText="BUY_ID" InsertVisible="False" ReadOnly="True" SortExpression="BUY_ID" />
                                 <%-- <asp:CommandField ShowEditButton="True" ShowCancelButton="true" ButtonType="Link"  />--%>
                                     <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton Id="lnkBtnEditBuy" Text="Edit" runat="server" CommandName="Edit" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton Text="Update" runat="server" OnClick="OnUpdateBuy" />
                                            <asp:LinkButton Text="Cancel" runat="server" OnClick="OnCancelBuy" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                     <%-- <asp:TemplateField HeaderText="Edit/Update" SortExpression="Edit">
                                        <ItemTemplate>
                                           <asp:LinkButton Text="Edit" ID="lnkGrdBuy" runat="server" OnCommand="lnkGrdBuy_Command" />
                                        </ItemTemplate>
                                       
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Booking No" SortExpression="BOOKING_NO">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBookingNumber" runat="server" Text='<%# Bind("BOOKING_NO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnBuyLoginId" runat="server" CommandArgument='<%# Eval("LOGIN_ID") %>' OnClick="lbtnBuyLoginId_Click" Text='<%# Eval("BOOKING_NO") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DT_BOOKING" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Booking Date"  InsertVisible="False" ReadOnly="True" SortExpression="DT_BOOKING" />
                                    <asp:BoundField DataField="LOGIN_ID" HeaderText="LOGIN_ID" InsertVisible="False" ReadOnly="True" SortExpression="LOGIN_ID" Visible="False" />
                                    <asp:BoundField DataField="MEM_NAME" HeaderText="Name" InsertVisible="False" ReadOnly="True"  SortExpression="MEM_NAME" />
                                    <asp:TemplateField HeaderText="Mobile/eMail" SortExpression="MOBILENO">
                                       <%-- <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:TextBox>
                                        </EditItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("EMAILID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="EMAILID" HeaderText="EMAILID" SortExpression="EMAILID" Visible="False" />
                                    <asp:BoundField DataField="CURR_CODE" InsertVisible="False" ReadOnly="True"  HeaderText="Currency" SortExpression="CURR_CODE" />
                                    <%--<asp:BoundField DataField="FX_QTY" InsertVisible="False" ReadOnly="True"  HeaderText="Forex Qty" SortExpression="FX_QTY" />--%>
                                   <asp:TemplateField HeaderText="FX_QTY"  SortExpression="FX_QTY">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFX_QTY" runat="server" Text='<%# Bind("FX_QTY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Pay Mode" InsertVisible="False" ReadOnly="True"  HeaderText="Pay Mode" SortExpression="Pay Mode" />
                                
                                     <asp:TemplateField HeaderText="RATE TO CLIENT" SortExpression="Rate to Client">
                                       <EditItemTemplate>
                                            <asp:TextBox ID="txtRTCInvoice" runat="server" Text='<%# Bind("RATE_TO_CLIENT_INVOICE") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRTCInvoice" runat="server" Text='<%# Bind("RATE_TO_CLIENT_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                       </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount Invoice"  SortExpression="AMOUNT_TOTAL">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_TOTAL_INVOICE" runat="server" Text='<%# Bind("AMOUNT_TOTAL_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Total Amount"  SortExpression="AMOUNT_TOTAL">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_TOTAL" runat="server" Text='<%# Bind("AMOUNT_TOTAL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Company Commision Amount"  SortExpression="Company Commision">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_COMPANY_INVOICE" runat="server" Text='<%# Bind("AMOUNT_COMPANY_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="AMOUNT_DREAM" Visible="false" >
                                      <ItemTemplate>
                                      <asp:Label ID="grdLblAMOUNT_DREAM" runat="server" Text='<%# Bind("AMOUNT_DREAM") %>'></asp:Label>
                                      </ItemTemplate>
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Buy Sub Id"  SortExpression="BUY_SUB_ID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBUY_SUB_ID" runat="server" Text='<%# Bind("BUY_SUB_ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Invoice ID"  SortExpression="INVOICE_ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblINVOICE_ID" runat="server" Text='<%# Bind("INVOICE_ID") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("DT_INVOICE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DT_INVOICE" InsertVisible="False" ReadOnly="True"  HeaderText="DT_INVOICE" SortExpression="DT_INVOICE" Visible="False" />
                                    <%-- <asp:BoundField DataField="ONLINE_TRANS_ID" InsertVisible="False" ReadOnly="True"  HeaderText="Online Trans ID" SortExpression="ONLINE_TRANS_ID" />
                                    <asp:BoundField DataField="AMT_ONLINE" InsertVisible="False" ReadOnly="True"  HeaderText="Online Amount" SortExpression="AMT_ONLINE" />--%>
                                </Columns>
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
                                </ContentTemplate>
                             </asp:UpdatePanel> 
                            </div>
                            <br />
                            <div>
                             <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                              <ContentTemplate>
                               <asp:GridView ID="gvSell" runat="server" ClientIDMode="Static" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False" DataSourceID="dsSell" Visible="False" OnRowUpdating="gvSell_RowUpdating" OnRowEditing="OnSellRowEditing" OnRowDataBound="gvSell_RowDataBound">
                                <EmptyDataTemplate>
                                    <br />
                                    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="Sorry, No Data Found.."></asp:Label>
                                    <br />
                                </EmptyDataTemplate>

                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="SELL_ID" HeaderText="Sell ID" InsertVisible="False" ReadOnly="True" SortExpression="SELL_ID" />
                                      <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton Id="lnkBtnEditSell" Text="Edit" runat="server" CommandName="Edit" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton Text="Update" runat="server" OnClick="OnUpdateSell" />
                                            <asp:LinkButton Text="Cancel" runat="server" OnClick="OnCancelSell" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                   <%-- <asp:TemplateField HeaderText="Booking No">
                                        <ItemTemplate>
                                            <asp:LinkButton Id="lnkBOOKING_NO" Text='<%# Bind("BOOKING_NO") %>' runat="server" CommandName="BOOKING_NO" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                     <asp:TemplateField HeaderText="Booking No" SortExpression="BOOKING_NO">
                                        <ItemTemplate>
                                            <asp:Label ID="lnkBOOKING_NO" runat="server" Text='<%# Bind("BOOKING_NO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnSellLoginId" runat="server" CommandArgument='<%# Eval("LOGIN_ID") %>' OnClick="lbtnSellLoginId_Click" Text='<%# Eval("BOOKING_NO") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:BoundField DataField="DT_BOOKING" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Booking Date"  InsertVisible="False" ReadOnly="True" SortExpression="DT_BOOKING" />
                                    <asp:BoundField DataField="LOGIN_ID" HeaderText="LOGIN_ID" InsertVisible="False" ReadOnly="True" SortExpression="LOGIN_ID" Visible="False" />
                                    <asp:BoundField DataField="MEM_NAME" HeaderText="Name" InsertVisible="False" ReadOnly="True"  SortExpression="MEM_NAME" />
                                    <asp:TemplateField HeaderText="Mobile/eMail" SortExpression="MOBILENO">
                                       <%-- <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:TextBox>
                                        </EditItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("MOBILENO") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("EMAILID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="EMAILID" HeaderText="EMAILID" SortExpression="EMAILID" Visible="False" />
                                    <asp:BoundField DataField="CURR_CODE" InsertVisible="False" ReadOnly="True"  HeaderText="Currency" SortExpression="CURR_CODE" />
                                    <%--<asp:BoundField DataField="FX_QTY" InsertVisible="False" ReadOnly="True"  HeaderText="Forex Qty" SortExpression="FX_QTY" />--%>
                                   <asp:TemplateField HeaderText="FX_QTY"  SortExpression="FX_QTY">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFX_QTY" runat="server" Text='<%# Bind("FX_QTY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Pay Mode" InsertVisible="False" ReadOnly="True"  HeaderText="Pay Mode" SortExpression="Pay Mode" />
                                   
                                    <%--<asp:BoundField DataField="RATE_TO_CLIENT_INVOICE" HeaderText="Rate to Client" SortExpression="RATE_TO_CLIENT" />--%>
                                     <asp:TemplateField HeaderText="RATE TO CLIENT" SortExpression="Rate to Client">
                                       <EditItemTemplate>
                                            <asp:TextBox ID="txtRTCInvoice" runat="server" Text='<%# Bind("RATE_TO_CLIENT_INVOICE") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRTCInvoice" runat="server" Text='<%# Bind("RATE_TO_CLIENT_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                       </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount Invoice"  SortExpression="AMOUNT_TOTAL">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_TOTAL_INVOICE" runat="server" Text='<%# Bind("AMOUNT_TOTAL_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Total Amount"  SortExpression="AMOUNT_TOTAL">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_TOTAL" runat="server" Text='<%# Bind("AMOUNT_TOTAL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Company Commision Amount"  SortExpression="Company Commision">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAMOUNT_COMPANY_INVOICE" runat="server" Text='<%# Bind("AMOUNT_COMPANY_INVOICE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="AMOUNT_DREAM" Visible="false" >
                                      <ItemTemplate>
                                      <asp:Label ID="grdLblAMOUNT_DREAM" runat="server" Text='<%# Bind("AMOUNT_DREAM") %>'></asp:Label>
                                      </ItemTemplate>
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Sell Sub Id"  SortExpression="SELL_SUB_ID" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSELL_SUB_ID" runat="server" Text='<%# Bind("SELL_SUB_ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Invoice ID"  SortExpression="INVOICE_ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblINVOICE_ID" runat="server" Text='<%# Bind("INVOICE_ID") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("DT_INVOICE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DT_INVOICE" InsertVisible="False" ReadOnly="True"  HeaderText="DT_INVOICE" SortExpression="DT_INVOICE" Visible="False" />
                                </Columns>
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
                              </ContentTemplate>
                             </asp:UpdatePanel> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <asp:HiddenField ID="hfTab" runat="server" />
    </div>
            
</asp:Content>
