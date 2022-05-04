<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TongJi.aspx.cs" Inherits="Project.SysManage.TongJi" %>
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
    <script language="JavaScript" type="text/javascript">  
        var idTmr;  
        function  getExplorer() {  
            var explorer = window.navigator.userAgent ;  
            //ie  
            if (explorer.indexOf("MSIE") >= 0) {  
                return 'ie';  
            }  
            //firefox  
            else if (explorer.indexOf("Firefox") >= 0) {  
                return 'Firefox';  
            }  
            //Chrome  
            else if(explorer.indexOf("Chrome") >= 0){  
                return 'Chrome';  
            }  
            //Opera  
            else if(explorer.indexOf("Opera") >= 0){  
                return 'Opera';  
            }  
            //Safari  
            else if(explorer.indexOf("Safari") >= 0){  
                return 'Safari';  
            }  
        }  
        function method5(tableid) {  
            if(getExplorer()=='ie')  
            {  
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
            else
            {  
                tableToExcel(tableid)  
            }
        }  
        function Cleanup() {  
            window.clearInterval(idTmr);  
            CollectGarbage();  
        }  
        var tableToExcel = (function() {  
            var uri = 'data:application/vnd.ms-excel;base64,',  
                    template = '<html><head><meta charset="UTF-8"></head><body><table>{table}</table></body></html>',  
                    base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },  
                    format = function(s, c) {  
                        return s.replace(/{(\w+)}/g,  
                                function(m, p) { return c[p]; }) }  
            return function(table, name) {  
                if (!table.nodeType) table = document.getElementById(table)  
                var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}  
                window.location.href = uri + base64(format(template, ctx))  
            }  
        })()  
    </script>
    <script src="../script/date/WdatePicker.js"></script>
</head>
<body>
<form runat="server" id="form1">
        <div class="main_body padding_lr_0">
            <div class="col-md-12 role_content_right">
                <div class="main_head">
                    <div class="pull-left padding_right_15">
                        <div class="title_box"><b>报销账目的汇总</b></div>
                    </div>
                    <div class="pull-left padding_left_15 ">
                        时间段：
                        <asp:TextBox ID="txtTime1" runat="server" CssClass="input_text Wdate" onfocus="blur()" onclick="WdatePicker()"></asp:TextBox>
                        到
                        <asp:TextBox ID="txtTime2" runat="server" CssClass="input_text Wdate" onfocus="blur()" onclick="WdatePicker()"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="" OnClick="btnSearch_Click" Text="搜索信息" />
                    </div>
                    <div class="pull-right">
                        <button type="button" class="" onclick="method5('tableExcel')"> 导出汇总结果 </button>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <table class="table table-bordered table-hover" id="tableExcel">
                    <thead>
                        <tr>
                            <th>项目名称</th>
                            <th>申报次数</th>
                            <th>申报总金额</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptList" runat="server">
                        <ItemTemplate>
                        <tr>
                            <td><%#Eval("xm")%></td>
                            <td><%#Eval("num")%></td>
                            <td><%#Eval("price")%></td>
                        </tr>
                        </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

            </div>
        </div>
</form>
</body>
</html>