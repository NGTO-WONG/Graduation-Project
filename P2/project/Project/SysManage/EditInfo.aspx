﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditInfo.aspx.cs" Inherits="Project.SysManage.EditInfo" %>
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
    <div class="main_right_content">
        <div class="main_body">

            <form runat="server" class="form-horizontal" id="form1" method="post">

                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">个人ID</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="ManagerName" runat="server" CssClass="form-control" placeholder="请填写" Enabled="false"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">昵称</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="Title" runat="server" CssClass="form-control" placeholder="请填写" required></asp:TextBox>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">电话</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="Tel" runat="server" CssClass="form-control" placeholder="请填写" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">住址</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="请填写" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">注册时间</label>
                    <div class="col-sm-3">
                        <asp:Literal ID="RegTime" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-2">
                        <asp:Button ID="btnSave" runat="server" Text="提交信息" class="" onclick="btnSave_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>