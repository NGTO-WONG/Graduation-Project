<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerManage.aspx.cs" Inherits="Project.SysManage.ManagerManage" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../style/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../style/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../style/style.css" />
    <script type="text/javascript" src="../script/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="../script/bootstrap.min.js"></script>
    <script type="text/javascript" src="../script/system.js"></script>

    
    <script type="text/javascript" src="../script/jquery.validate.min.js"></script>
    <script type="text/javascript" src="../layer/layer.js"></script>

</head>
<body>
<form runat="server" id="form1">
        <div class="main_body padding_lr_0">
            <div class="col-md-12 role_content_right">
                <div class="main_head">
                    <div class="pull-left padding_right_15">
                        <div class="title_box"><b><%=get_grade == 1 ? "管理员" : (get_grade == 2 ? "员工" : "会计")%>信息</b></div>
                    </div>
                    <div class="pull-left padding_left_15 ">
                        <asp:TextBox ID="txtKey" runat="server" CssClass="input_text" placeholder="查找名称"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="" OnClick="btnSearch_Click" Text="搜索信息" />
                    </div>
                    <div class="pull-right">
                        <span class="" onclick="location = 'ManagerOper.aspx?grade=<%=get_grade %>';">添加</span>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <table class="table table_span table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>用户权限</th>
                            <th>个人ID</th>
                            <th>登录密码</th>
                            <th>昵称</th>
                            <th>电话</th>
                            <th>住址</th>
                            <th>注册时间</th>
                            <%--<th>发言状态</th>--%>
                            <th class="text-right">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
                        <ItemTemplate>
                        <tr>
                            <td><%#Eval("Grade").ToString() == "1" ? "管理员" : (Eval("Grade").ToString() == "2" ? "员工" : "会计")%></td>
                            <td><%#Eval("ManagerName")%></td>
                            <td><%#Eval("ManagerPwd")%></td>
                            <td><%#Eval("Title")%></td>
                            <td><%#Eval("Tel")%></td>
                            <td><%#Eval("Email")%></td>
                            <td><%#Eval("RegTime")%></td>
                            <%--<td><%#Eval("state")%></td>--%>
                            <td class="text-right">
                                <a href="ManagerOper.aspx?grade=<%#get_grade %>&id=<%#Eval("Id") %>"><span class="blue">修改</span></a>&nbsp;
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="del"
                                     class="red" OnClientClick="JavaScript:return confirm('确定要删除吗？')">删除</asp:LinkButton>
                            </td>
                        </tr>
                        </ItemTemplate>
                        </asp:Repeater>
                        <asp:Literal ID="ltlNull" runat="server"></asp:Literal>
                    </tbody>
                </table>
                

                <!--分页-->
                <div class="page_bg">
                    <nav>
                        <ul class="pagination pull-left">
                            <%=Project.PagingHelper.getPageStr(CurrentPage, PageCount, "")%>
                        </ul>
                        <div class="pull-left line_34 padding_left_15">共 <%=PageCount%> 页，<%=RecordCount%> 条</div>
                        <div class="clearfix"></div>
                    </nav>
                </div>

            </div>
        </div>
</form>
</body>
</html>