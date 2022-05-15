<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShuJuOper.aspx.cs" Inherits="Project.SysManage.ShuJuOper" %>

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
    <script type="text/javascript">
        /*const { param } = require("jquery");*/
        $(function () {
            var id = getQueryString('id');
            if (id) {
                InitData(id);
                $('#submit').hide();//隐藏新增
                $('#btnApproval').show();//显示审批
            }
            else {
                $('#submit').show();//显示新增按钮
                $('#btnApproval').hide();//隐藏审批
            }
            //#region 方法
            function InitData(id) {
                $.ajax({
                    type: "POST",
                    url: "ShuJuOper.aspx/GetItemList",
                    data: "{'Id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = JSON.parse(data.d);
                        if (json.code == 0) {
                            var html = "";
                            if (json.data) {
                                $('#initial').hide();
                                $.each(JSON.parse(json.data), function (index, item) {
                                    var ele = $('#templet2').children().clone().addClass('charge-list');
                                    if (index == 0) {
                                        ele.find('.padding_lr_0').html("申报金额");
                                    }
                                    ele.find("input[name='name']").val(item.detailName);
                                    ele.find("input[name='name']").attr("keyId", item.detailId);
                                    ele.find("input[name='value']").val(item.detailValue);
                                    ele.find("input[name='ApprovalMoney']").val(item.ApprovalMoney);

                                    //ele.find("select").val(item.state ||'未审计');
                                    $("#ibox").append(ele);
                                });
                            }
                        }
                    },
                    error: function (ex) {
                        console.log('异常：', ex);
                    }
                });
            }
            /**
             * 获取浏览器参数
             * @param name
             */
            function getQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }
            //#endregion
            //#region 事件
            //添加费用事件
            $("#btnInsert").on('click', function () {
                $("#ibox").append($('#templet').children().clone().addClass('charge-list'));
            });
            //保存事件
            $("#submit").on('click', function () {
                var xm = $('#xm').val();//申报项目
                var sj = $('#sj').val();//申报时间
                //申报费用
                var res = [];
                $('.charge-list').each(function (index, item) {
                    var obj = new Object();
                    obj.name = $(item).find('input')[0].value;
                    obj.value = $(item).find('input')[1].value;
                    obj.orderBy = index + 1;
                    res.push(obj);
                });
                var ren = $('#ren').val();//申报人
                var demo = $("#demo").val();//备注
                var state = $("#state").val();//初审审计
                var state2 = '';//$("#state2").val();//终审审计
                var params =
                {
                    xm,
                    sj,
                    res,
                    ren,
                    demo,
                    state,
                    state2
                };
                $.ajax({
                    type: "POST",
                    url: "ShuJuOper.aspx/SaveChange",
                    data: "{'strJson':'" + JSON.stringify(params) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = JSON.parse(data.d);
                        if (json.code == 0) {
                            alert('保存成功');
                            location.href = 'ShuJuManage.aspx';
                        }
                        else if (json.code == 1) {
                            alert('申报时间与已有预约冲突');
                            return false;
                        }
                        else {
                            alert('保存失败');
                        }
                    },
                    error: function (ex) {
                        console.log('异常：', ex);
                    }
                });
            });
            //终审审批
            $("#btnApproval").on('click', function () {
                var res = [];
                $('.charge-list').each(function (index, item) {
                    var obj = new Object();
                    obj.id = $(item).find("input[name='name']").attr("keyId");
                    obj.name = $(item).find("input[name='name']").val();
                    obj.value = $(item).find("input[name='value']").val();
                    /*obj.state = $(item).find("select").find("option:selected").val();*/
                    obj.appMoney = $(item).find("input[name='ApprovalMoney']").val();//审批金额
                    if (parseInt(obj.value) < parseInt(obj.appMoney)) {
                        alert('同意金额不能大于申请金额');
                        return false;
                    }
                    obj.orderBy = index + 1;
                    if (obj.name) {
                        res.push(obj);
                    }
                });
                $.ajax({
                    type: "POST",
                    url: "ShuJuOper.aspx/Update",
                    data: "{'strJson':'" + JSON.stringify(res) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var json = JSON.parse(data.d);
                        if (json.code == 0) {
                            alert('保存成功');
                            location.href = 'ShuJuManage.aspx';
                        }
                    },
                    error: function (ex) {
                        console.log('异常：', ex);
                    }
                });
            });
            //#endregion
        });
    </script>
</head>
<body>
    <div class="main_right_content">
        <div class="main_body">
            <form runat="server" class="form-horizontal" id="form1">
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">申报项目</label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="xm" runat="server" CssClass="form-control" Width="220px">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">申报时间</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="sj" runat="server" CssClass="form-control Wdate" Width="220px" placeholder="请填写" onfocus="blur()" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" required></asp:TextBox>
                    </div>
                </div>
                <div class="form-group charge-list" id="initial">
                    <label class="col-sm-2 control-label padding_lr_0">申报金额</label>
                    <div class="col-sm-2">
                        <%--<asp:TextBox ID="je" runat="server" CssClass="form-control" placeholder="请填写费用名称"></asp:TextBox>--%>
                        <input type="text" class="form-control" name="name" value="" placeholder="请填写费用名称" autocomplete="off" />
                    </div>
                    <div class="col-sm-2" style="">
                        <%--<asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="请填写费用金额"></asp:TextBox>--%>
                        <input type="number" class="form-control" name="name" value="" placeholder="请填写费用金额" autocomplete="off" />
                    </div>
                    <a href="javascript:void(0);" class="btn btn-primary" id="btnInsert">新增</a>
                </div>
                <div id="ibox"></div>
                <div class="form-group">
                    <label class="col-sm-2 control-label padding_lr_0">申报人</label>
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

                <div class="form-group" style="display: <%=mbGrade==3?"":"none"%>;">
                    <label class="col-sm-2 control-label padding_lr_0">初审审计</label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="state" runat="server" CssClass="form-control" Width="220px">
                            <asp:ListItem>未审计</asp:ListItem>
                            <asp:ListItem>同意</asp:ListItem>
                            <asp:ListItem>不同意</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group" style="display: none;">
                    <label class="col-sm-2 control-label padding_lr_0">同意金额</label>
                    <div class="col-sm-10">
                        <%-- <asp:DropDownList ID="state2" runat="server" CssClass="form-control" Width="220px">
                            <asp:ListItem>未审计</asp:ListItem>
                            <asp:ListItem>同意</asp:ListItem>
                            <asp:ListItem>不同意</asp:ListItem>
                        </asp:DropDownList>--%>
                        <input type="number" class="form-control" name="value" value="" placeholder="请填写同意金额" autocomplete="off" required />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-2">
                        <%--<asp:Button ID="btnSave" runat="server" Text="提交信息" class=""
                            OnClick="btnSave_Click" />--%>
                        <a href="javascript:void(0);" class="btn btn-primary" id="submit">提交信息</a>
                        <a href="javascript:void(0);" class="btn btn-primary" id="btnApproval" style="display: none;">提交信息</a>
                    </div>
                </div>
                <%--添加费用模板--%>
                <div id="templet" style="display: none;">
                    <div class="form-group">
                        <label class="col-sm-2 control-label padding_lr_0">&nbsp;</label>
                        <div class="col-sm-2">
                            <%--<asp:TextBox ID="je" runat="server" CssClass="form-control" placeholder="请填写费用名称"></asp:TextBox>--%>
                            <input type="text" class="form-control" name="name" value="" placeholder="请填写费用名称" autocomplete="off" required />
                        </div>
                        <div class="col-sm-2">
                            <%--<asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="请填写费用金额"></asp:TextBox>--%>
                            <input type="number" class="form-control" name="value" value="" placeholder="请填写费用金额" autocomplete="off" required />
                        </div>
                    </div>
                </div>
                <%--添加费用模板--%>
                <%--审批费用模板--%>
                <div id="templet2" style="display: none;">
                    <div class="form-group">
                        <label class="col-sm-2 control-label padding_lr_0">&nbsp;</label>
                        <div class="col-sm-2">
                            <%--<asp:TextBox ID="je" runat="server" CssClass="form-control" placeholder="请填写费用名称"></asp:TextBox>--%>
                            <input type="text" class="form-control" name="name" value="" placeholder="请填写费用名称" autocomplete="off" required />
                        </div>
                        <div class="col-sm-2">
                            <%--<asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="请填写费用金额"></asp:TextBox>--%>
                            <input type="number" class="form-control" name="value" value="" placeholder="请填写费用金额" autocomplete="off" required />
                        </div>
                        <label class="col-sm-1  control-label">同意金额</label>
                        <div class="col-sm-2">
                            <%--<select class="form-control" name="ApprovalStatus">
                                <option value="未审计">未审计</option>
                                <option value="同意">同意</option>
                                <option value="不同意">不同意</option>
                            </select>--%>
                            <input type="number" class="form-control" name="ApprovalMoney" value="" placeholder="请填写同意金额" autocomplete="off" required />
                        </div>
                    </div>
                </div>
                <%--审批费用模板--%>
            </form>
        </div>
    </div>
</body>
</html>
