<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditPwd.aspx.cs" Inherits="Project.SysManage.EditPwd" %>
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
        <div class="main_body ">

            <form runat="server" class="form-horizontal" id="form1" method="post">
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">登录账号</label>
                    <div class="col-sm-2">
                        <asp:Literal ID="ltlLoginName" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">原密码</label>
                    <div class="col-sm-2">
                        <input type="password" runat="server" id="OldPwd" name="OldPwd" class="form-control" placeholder="请填写原密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">新密码</label>
                    <div class="col-sm-2">
                        <input type="password" runat="server" id="NewPwd" name="NewPwd" class="form-control" placeholder="请填写新密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">确认密码</label>
                    <div class="col-sm-2">
                        <input type="password" runat="server" id="reNewPwd" name="reNewPwd" class="form-control" placeholder="请填写确认密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-2">
                        <asp:Button ID="btnSave" runat="server" Text="确定修改" class="btn btn-success" 
                            onclick="btnSave_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>





    <script type="text/javascript">

        $(function () {
            //验证表单
            $("#form1").validate({
                rules: {
                    OldPwd: { required: true },
                    NewPwd: { required: true, minlength: 3, maxlength: 20 },
                    reNewPwd: { required: true, equalTo: '#NewPwd' }
                },
                messages: {
                    OldPwd: '*' ,
                    NewPwd: { required: '*', minlength: '长度在3--20位', maxlength: '长度在3--20位', },
                    reNewPwd: { required: '*', equalTo: '两次密码输入不一致' }
                }
            });

            //提交
            $("#btnSave").click(function () {
                var result = $("#form1").valid();
                return result;
            });

        });
    </script>

</body>
</html>