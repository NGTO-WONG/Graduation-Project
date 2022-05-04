<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Project.SysManage.Login" %>
<!DOCTYPE html>
<html class="login_html">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../style/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../style/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../style/style.css" />
    <script type="text/javascript" src="../script/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="../script/bootstrap.min.js"></script>
    <style type="text/css">
        body{background:#65a0ec url(../images/ad.jpg) center top repeat-x !important;}
        .login_num_left input, .login_right input {
            width: 96%;
            background: none;
        }
        input.required {
            color: #000;
        }
    </style>
</head>
<body class="login_body">
    <div id="login_body">
        <div class="login_content">
            <div class="login_title" style="color:#ffff; font-weight:bold;"><i class="icon-ok"></i> <%=get_grade == 1 ? "管理员" : (get_grade == 2 ? "员工" : "会计")%>登录</div>
            <form runat="server" class="login_form" id="form1">
                <!--用户名-->
                <div class="login_input" style="width:300px;">
                    <div class="login_rs">
                        <div class="login_right">
                            <input type="text" runat="server" id="username" name="username" class="login_name_input required" placeholder="请输入用户ID" required />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!--密码-->
                <div class="login_input" style="width:300px;">
                    <div class="login_rs">
                        <div class="login_right">
                            <input type="password" runat="server" id="userpwd" name="userpwd" class="login_name_input required" placeholder="请输入登录密码" required />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!--角色-->
                <div class="login_input" style="width:300px;display:none;">
                    <div class="login_rs">
                    <div class="login_right">
                        <asp:DropDownList ID="grade" runat="server" CssClass="form-control" Enabled="false">
                                <asp:ListItem Value="1">管理员</asp:ListItem>
                                <asp:ListItem Value="2">员工</asp:ListItem>
                                <%--<asp:ListItem Value="3">会计</asp:ListItem>--%>
                                </asp:DropDownList>
                    </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!--登录-->
                <div class="login_input1" style="width:300px;">
                    <asp:Button ID="btnLogin" runat="server" Text="登录系统" onclick="btnLogin_Click" />
                </div>
                <div class="center red" id="msg">
                    <asp:Literal ID="ltlMess" runat="server"></asp:Literal>
                </div>
            </form>
        </div>
    </div>
</body>
</html>