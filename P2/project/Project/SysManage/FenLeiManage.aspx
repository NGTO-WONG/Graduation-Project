<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FenLeiManage.aspx.cs" Inherits="Project.SysManage.FenLeiManage" %>
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
            <div class="col-md-12 role_content_right" style="width:500px;">
                <div class="main_head">
                    <div class="pull-left padding_right_15">
                        <div class="title_box"><b>项目信息</b></div>
                    </div>
                    <div class="pull-left padding_left_15 ">
                        <asp:TextBox ID="txtKey" runat="server" CssClass="input_text" placeholder="查找名称"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="" OnClick="btnSearch_Click" Text="搜索信息" />
                    </div>
                    <div class="pull-right">
                        <span class="" onclick="location = 'FenLeiOper.aspx';">新增</span>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>项目名称</th>
                            <th class="text-right">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptList" runat="server" onitemcommand="rptList_ItemCommand">
                        <ItemTemplate>
                        <tr>
                            <td><%#Eval("FenLeiName")%></td>
                            <td class="text-right">
                                <a href="FenLeiOper.aspx?id=<%#Eval("Id") %>"class="">编辑</a>&nbsp;
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
                        <ul class="pagination pull-left" id="pagingHtml">
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