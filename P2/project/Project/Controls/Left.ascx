<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Left.ascx.cs" Inherits="Project.Controls.Left" %>
<div class="col-md-3" style="border-right:#ccc solid 1px;">

<div class="col-sm-12">
    <div class="col-sm-12 nav-tit">审计项目行业</div>
    <div class="col-sm-12 padding_lr_0">
        <asp:Repeater ID="rptListFenLei" runat="server">
        <ItemTemplate>
            <div class="col-sm-6 padding_lr_0" style="padding:10px 0;border:#ddd solid 1px; text-align:center;">
                <a class="green" href="/ProductList.aspx?fenleiId=<%#Eval("Id") %>"><%#Eval("FenLeiName")%></a>
            </div>
        </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<div class="col-md-12 padding_top_10">
    <div class="col-md-12 nav-tit">最新审计项目</div>
        <asp:Repeater ID="rptListPro" runat="server">
        <ItemTemplate>
            <div class="col-md-12 padding_top_10" style="padding:6px 0;">
            <a href="ProductShow.aspx?id=<%#Eval("Id") %>">
                <div class="col-md-12 text-left">
                    <%#Eval("ProductName")%>
                </div>
            </a>
            </div>
        </ItemTemplate>
        </asp:Repeater>
</div>

</div>