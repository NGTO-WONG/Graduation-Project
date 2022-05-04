<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Project.Index" %>
<%@ Register src="Controls/Head.ascx" tagname="Head" tagprefix="uc1" %>
<%@ Register src="Controls/Foot.ascx" tagname="Foot" tagprefix="uc2" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="style/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="style/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="style/style.css" />
    <script type="text/javascript" src="script/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="script/bootstrap.min.js"></script>
    <script type="text/javascript" src="script/system.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
</head>
<body>
<form id="Form1" runat="server">
<uc1:Head ID="Head1" runat="server" />

<div class="main_body padding_lr_0" style="width:1150px;">
        <div class="col-sm-12 nav-tit"><i class="icon-home"></i> 请选择登录端口</div>
        
        <div class="col-sm-4 padding_top_10 text-center" style="height:300px;">
            <a href="/SysManage/Login.aspx?grade=2" class="btn btn-default" style="font-size:30px;padding:50px 30px;">
                <i class="icon-user"></i><br />
                员工登录
            </a>
        </div>

        <%--<div class="col-sm-4 padding_top_10 text-center" style="height:300px;">
            <a href="/SysManage/Login.aspx?grade=3" class="btn btn-default" style="font-size:30px;padding:50px 30px;">
                <i class="icon-user"></i><br />
                会计登录
            </a>
        </div>--%>

        <div class="col-sm-4 padding_top_10 text-center" style="height:300px;">
            <a href="/SysManage/Login.aspx?grade=1" class="btn btn-default" style="font-size:30px;padding:50px 30px;">
                <i class="icon-user"></i><br />
                管理员登录
            </a>
        </di>


<uc2:Foot ID="Foot1" runat="server" />
</div>
</form>
</body>
</html>