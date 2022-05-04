<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JiHuaOper.aspx.cs" Inherits="Project.SysManage.JiHuaOper" %>
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
    <script src="../script/date/WdatePicker.js"></script>
</head>
<body>
    <div class="main_right_content">
        <div class="main_body">
            <form runat="server" class="form-horizontal" id="form1" method="post">
                
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">项目名称</label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="xm" runat="server" CssClass="form-control" Width="220px">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">制定时间</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="sj" runat="server" CssClass="form-control Wdate" Width="220px" placeholder="请填写" onfocus="blur()" onclick="WdatePicker()" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">计划金额</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="je" runat="server" CssClass="form-control" Width="220px" placeholder="请填写" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">制定人</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="ren" runat="server" CssClass="form-control" Width="220px" placeholder="请填写" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">备注</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="demo" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="6" Width="360px" placeholder="请填写"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group" style="display:<%=mbGrade==3?"none":""%>;">
                    <label class="col-sm-2 control-label padding_lr_0">审核状态</label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="state" runat="server" CssClass="form-control" Width="220px">
                            <asp:ListItem>未审核</asp:ListItem>
                            <asp:ListItem>同意</asp:ListItem>
                            <asp:ListItem>不同意</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-2">
                        <asp:Button ID="btnSave" runat="server" Text="提交信息" class="" 
                            onclick="btnSave_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>