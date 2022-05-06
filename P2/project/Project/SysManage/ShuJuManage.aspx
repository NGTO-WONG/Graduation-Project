<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShuJuManage.aspx.cs" Inherits="Project.SysManage.ShuJuManage" %>

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
    <script src="../script/jquery.jqprint-0.3.js"></script>
    <style>
        .modal-body input {
            margin: 5px;
        }
    </style>
    <script language="JavaScript" type="text/javascript">  
        $(function () {
            $('#myModal2').on('shown.bs.modal', function () {
                $('#myInput').focus()
            })
        });
        var idTmr;
        function getExplorer() {
            var explorer = window.navigator.userAgent;
            //ie  
            if (explorer.indexOf("MSIE") >= 0) {
                return 'ie';
            }
            //firefox  
            else if (explorer.indexOf("Firefox") >= 0) {
                return 'Firefox';
            }
            //Chrome  
            else if (explorer.indexOf("Chrome") >= 0) {
                return 'Chrome';
            }
            //Opera  
            else if (explorer.indexOf("Opera") >= 0) {
                return 'Opera';
            }
            //Safari  
            else if (explorer.indexOf("Safari") >= 0) {
                return 'Safari';
            }
        }
        function method5(tableid) {
            if (getExplorer() == 'ie') {
                var curTbl = document.getElementById(tableid);
                var oXL = new ActiveXObject("Excel.Application");
                var oWB = oXL.Workbooks.Add();
                var xlsheet = oWB.Worksheets(1);
                var sel = document.body.createTextRange();
                sel.moveToElementText(curTbl);
                sel.select();
                sel.execCommand("Copy");
                xlsheet.Paste();
                oXL.Visible = true;

                try {
                    var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
                } catch (e) {
                    print("Nested catch caught " + e);
                } finally {
                    oWB.SaveAs(fname);
                    oWB.Close(savechanges = false);
                    oXL.Quit();
                    oXL = null;
                    idTmr = window.setInterval("Cleanup();", 1);
                }
            }
            else {
                tableToExcel(tableid)
            }
        }
        function Cleanup() {
            window.clearInterval(idTmr);
            CollectGarbage();
        }
        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,',
                template = '<html><head><meta charset="UTF-8"></head><body><table>{table}</table></body></html>',
                base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
                format = function (s, c) {
                    return s.replace(/{(\w+)}/g,
                        function (m, p) { return c[p]; })
                }
            return function (table, name) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
                window.location.href = uri + base64(format(template, ctx))
            }
        })()
        /**
         * 加载数据
         * @param id
         */
        function LoadData(id) {
            debugger;
            $.ajax({
                type: "POST",
                url: "ShuJuManage.aspx/GetItemList",
                data: "{'strJson':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = JSON.parse(data.d);
                    debugger;
                    if (json.code == 0) {
                        var html = "";
                        if (json.data) {
                            var Total = 0, Actual = 0;
                            var html = '';
                            $.each(json.data, function (index, item) {
                                Total += parseInt(item.detailValue);
                                if (item.state == "同意") {
                                    Actual += parseInt(item.detailValue);
                                }
                                html += '<div class="row">';
                                html += '<div class="col-sm-6">';
                                html += '<input type="text" class="form-control" value="' + item.detailName + '" readonly>';
                                html += '</div>';
                                html += '<div class="col-sm-6">';
                                html += '<input type="text" class="form-control" value="' + item.detailValue + '" readonly>';
                                html += '</div>';
                                html += '</div>';
                            });
                            html += '<div class="row">';
                            html += '<label class="col-sm-2 control-label" style="margin-top: 14px;">申请总额</label>';
                            html += '<div class="col-sm-4">';
                            html += '<input type="text" class="form-control" value="' + Total + '" readonly>';
                            html += '</div>';
                            html += '<label class="col-sm-2 control-label" style="margin-top: 14px;">实际报销</label>';
                            html += '<div class="col-sm-4">';
                            html += '<input type="text" class="form-control" value="' + Actual + '" readonly>';
                            html += '</div>';
                            html += '</div>';
                            $('.modal-body').html(html);
                        }
                    }
                },
                error: function (ex) {
                    console.log('异常：', ex);
                }
            });
        }
    </script>
</head>
<body>
    <form runat="server" id="form1">
        <div class="main_body padding_lr_0">
            <div class="col-md-12 role_content_right">
                <div class="main_head">
                    <div class="pull-left padding_right_15">
                        <div class="title_box"><b>报销申请信息</b></div>
                    </div>
                    <div class="pull-left padding_left_15 ">
                        <asp:TextBox ID="txtKey" runat="server" CssClass="input_text" placeholder="可查找申报项目/申报人"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="" OnClick="btnSearch_Click" Text="搜索信息" />
                    </div>
                    <%--<div class="pull-right">
                        <button type="button" class="" onclick="method5('tableExcel')"> 下载个人报销明细 </button>
                    </div>--%>
                    <div class="clearfix"></div>
                </div>
                <table class="table table-bordered table-hover" id="tableExcel">
                    <thead>
                        <tr>
                            <th>申报项目</th>
                            <th>预约时间</th>
                            <th>申报金额</th>
                            <th>申报人</th>
                            <th>备注</th>
                            <%--<th>初审结果</th>--%>
                            <th>安排结果 失败/通过</th>
                            <%if (mbGrade == 1 || mbGrade == 3)
                                { %>
                            <th>操作</th>
                            <%} %>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><%#Eval("xm")%></td>
                                    <td><%#Eval("sj")%></td>
                                    <td><%#Eval("je")%></td>
                                    <td><%#Eval("ren")%></td>
                                    <td><%#Eval("demo")%></td>
                                    <%--<td><%#Eval("state")%></td>--%>
                                    <td><a href="javascript:void(0);" data-toggle="modal" data-target="#myModal" onclick="LoadData(<%#Eval("Id") %>)"><%#Eval("result")%></a></td>
                                    <%if (mbGrade == 1 || mbGrade == 3)
                                        { %>
                                    <td>
                                        <a href="ShuJuOper.aspx?id=<%#Eval("Id") %>"><span class="blue"><%#mbGrade==1?"终审":(mbGrade==2?"修改":"初审") %></span></a>&nbsp;
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="del"
                                    class="red" OnClientClick="JavaScript:return confirm('确定要删除吗？')">删除</asp:LinkButton>
                                    </td>
                                    <%} %>
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
                        <div class="pull-right line_34 padding_left_15">共 <%=PageCount%> 页，<%=RecordCount%> 条</div>
                        <div class="clearfix"></div>
                    </nav>
                </div>

            </div>
        </div>
        <!-- Button trigger modal -->

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">费用明细</h4>
                    </div>
                    <div class="modal-body">
                        <%--<div class="row">
                            <div class="col-sm-6">
                                <input type="text" class="form-control">
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" readonly">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <input type="text" class="form-control">
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-2 control-label" style="margin-top: 14px;">申请总额</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control">
                            </div>
                            <label class="col-sm-2 control-label" style="margin-top: 14px;">实际报销</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control">
                            </div>
                        </div>--%>
                    </div>
                    <div class="modal-footer" style="text-align: center;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
