<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainFrame.aspx.cs" Inherits="Project.SysManage.MainFrame" %>
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
    <script type="text/javascript" src="../layer/layer.js"></script>
    <style type="text/css">
        .header_bar {
            position: fixed;
        }
    </style>
</head>
<body>
    <!--头部-->
    <div class="header_bar">
        <div class="header_bar_left">
            <%--<div class="main_right" style="color:#ffff; font-weight:bold;"> 网上财务报销预约系统</div>--%>
        </div>
        <div class="header_bar_right">
            <ul>
                <li class="member">[
                <%
                    if (mbGrade == 1)
                        Response.Write("管理员");
                    else if (mbGrade == 2)
                        Response.Write("员工");
                    else if (mbGrade == 3)
                        Response.Write("会计");
                %>
                ：<asp:Literal ID="ltlLoginName" runat="server"></asp:Literal>
                    ]
                </li>
                <li class="quit"><a href="Logout.aspx">[安全退出]</a></li>
            </ul>
        </div>
    </div>
    <div style="height:70px;"></div>

    <!--左侧-->
    <div class="main_left">
        <div class="main_left_overflow">
            <%if (mbGrade == 1)
            { %>
                <div class="main_nav">
                    <span class="">员工信息管理</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <%--<li><a href="ManagerManage.aspx?grade=1" target="myiframe">管理员管理</a></li>--%>
                        <%--<li><a href="ManagerManage.aspx?grade=3" target="myiframe">会计信息管理</a></li>--%>
                        <li><a href="ManagerManage.aspx?grade=2" target="myiframe">员工信息管理</a></li>
                    </ul>
                </div>

                <div class="main_nav">
                    <span class="">系统资源</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="FenLeiOper.aspx" target="myiframe">添加申报资源</a></li>
                        <li><a href="FenLeiManage.aspx" target="myiframe">申报资源管理</a></li>
                    </ul>
                </div>

                <div class="main_nav">
                    <span class="">财务处管理</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="ShuJuManage.aspx" target="myiframe">报销账目审查</a></li>
                    </ul>
                </div>

               <%-- <div class="main_nav">
                    <span class="">年度计划审核</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="JiHuaManage.aspx" target="myiframe">年度计划审核</a></li>
                    </ul>
                </div>--%>
                <%--<div class="main_nav">
                    <span class="">统计报表</span><i class="icon-angle-right icon_right"></i>
                </div>--%>
            <%--%--hqmodif--%--%>
                <div class="child_nav">
                    <ul>
                        <%--<li><a href="tongji.aspx" target="myiframe">月度、年度报销账目</a></li>--%>
                    </ul>
                </div>

            <%}
              else if (mbGrade == 2)
              { %>
                <div class="main_nav">
                    <span class="">个人财务报销管理</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="ShuJuOper.aspx" target="myiframe">财务报销申报</a></li>
                        <li><a href="ShuJuManage.aspx" target="myiframe">查看财务处安排</a></li>
                    </ul>
                </div>

            <%}
              else if (mbGrade == 3)
              { %>
                <div class="main_nav">
                    <span class="">员工报销账目审计</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="ShuJuManage.aspx" target="myiframe">员工报销账目审计</a></li>
                    </ul>
                </div>

                <%--<div class="main_nav">
                    <span class="">年度报销计划制定</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="JiHuaOper.aspx" target="myiframe">提交计划</a></li>
                        <li><a href="JiHuaManage.aspx" target="myiframe">管理计划</a></li>
                    </ul>
                </div>--%>

                <div class="main_nav">
                    <span class="">统计报表</span><i class="icon-angle-right icon_right"></i>
                </div>
                <div class="child_nav">
                    <ul>
                        <li><a href="tongji.aspx" target="myiframe">月度、年度报销账目</a></li>
                    </ul>
                </div>
            <%} %>

            <div class="main_nav">
                <span class="">系统管理</span><i class="icon-angle-right icon_right"></i>
            </div>
            <div class="child_nav">
                <ul>
                    <li><a href="EditInfo.aspx" target="myiframe">个人信息管理</a></li>
                    <li><a href="EditPwd.aspx" target="myiframe">修改密码</a></li>
                </ul>
            </div>

            
        </div>
    </div>

    <!--右侧-->
    <div class="main_right">
        <div class="main_right_220">
            <div class="main_right_content">
                <iframe class="" id="myiframe" name="myiframe" width="100%" height="100%" src="right.html" scrolling="auto" onload="changeFrameHeight()" frameborder="0" seamless></iframe>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function changeFrameHeight() {
            var ifm = document.getElementById("myiframe");
            ifm.height = document.documentElement.clientHeight - 120;
        }
        window.onresize = function () {
            changeFrameHeight();
        }
    </script>
</body>
</html>