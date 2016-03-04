<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");
	String authCode = (String)(request.getSession()).getAttribute("AUTH_CODE");

	Set<String> nameSet = (Set)request.getSession().getAttribute("NameSet");
	Set<String> sellerSet = (Set)request.getSession().getAttribute("SellerSet");
	Set<String> tantoSet = (Set)request.getSession().getAttribute("TantoSet");
  Long orderCostPrice = (Long)request.getAttribute("orderCostPrice");
  Long sellCostPrice = (Long)request.getAttribute("sellCostPrice");
  Long sellPrice = (Long)request.getAttribute("sellPrice");
  Long profit = (Long)request.getAttribute("profit");

	String msg = (String)request.getSession().getAttribute("MSG");
	request.getSession().setAttribute("MSG", "");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<script type="text/javascript">
<!--
	function callServer(obj,arg) {
		obj.target='_self';
		obj.type.value=arg;
		if (arg==2) {
			if (!confirm('削除してよろしいですか？')) {
				return;
			}
		}
		if (arg==5) {
			if (!confirm('在庫締めを行います\nよろしいですか？')) {
				return;
			}
		}
		obj.action='EditInventory';
		obj.submit();
	}

	function createOrderSheet(obj) {
		obj.target='_self';
		obj.action='LoadExcelOrderSheet';
		obj.submit();
	}

	function createJpInvoice(obj) {
		obj.target='_self';
		obj.action='LoadExcelJpInvoice';
		obj.submit();
	}

	function createProformaInvoice(obj) {
		obj.target='_self';
		obj.action='LoadExcelProformaInvoice';
		obj.submit();
	}

	function createExcel(obj) {
		obj.target='_self';
		obj.action='LoadExcelInv';
		obj.submit();
	}

	function seachForSellInv(obj) {
		obj.target='_self';
		obj.action='SeachInventoryList?SEARCH_TYPE=1';
		obj.submit();
	}

	function seachForInvCount(obj) {
		obj.target='_self';
		obj.action='SeachInventoryList?SEARCH_TYPE=2';
		obj.submit();
	}

	function seachForCloseInv(obj) {
		obj.target='_self';
		obj.action='SeachInventoryList?SEARCH_TYPE=3';
		obj.submit();
	}

	function sortList(obj,sortType) {
    obj.sort.value=sortType;
		obj.target='_self';
		obj.action='GetInventoryList';
		obj.submit();
	}

	function search(obj) {
		obj.target='_self';
		obj.action='SeachInventoryList';
		obj.submit();
	}

	function regInv(obj) {
		obj.target='reginv';
		obj.action='RegistInventory.jsp';
		obj.submit();
	}


-->
</script>
<title>在庫一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="EditInventory"  method="POST">
<div><h1>在庫一覧</h1></div>
<div id="msg"><%= CommonUtil.nullConv(msg) %></div>
<div id="cond">検索条件</div>
<div align="left">
<table border="0">
<tr>
	<td>型式</td>

	<td>
		<select name="NAME">
				<option value="">選択</option>
				<%= CommonUtil.buildOptions(nameSet) %>
		</select>
	</td>


	<td>仕入先</td>
	<td>
		<select name="SELLER">
				<option value="">選択</option>
				<%= CommonUtil.buildOptions(sellerSet) %>
		</select>
	</td>

	<td>担当者</td>

	<td>
		<select name="TANTO">
				<option value="">選択</option>
				<%= CommonUtil.buildOptions(tantoSet) %>
		</select>
	</td>

	<td><input type="button" name="srch" value="検索" onclick="search(this.form);"></td>
<%
// 管理者権限・一般権限のみ表示
if (Const.AUTH_ADMIN.equals(authCode) || Const.AUTH_NORMAL.equals(authCode)) {
%>
	<td><input type="button" name="sellInv" value="販売用在庫検索" onclick="seachForSellInv(this.form);"></td>
	<td><input type="button" name="sellInvOut" value="販売用在庫出力" onclick="location.href='LoadExcelForSellInv'"></td>
<%
}
%>
<%
// 管理者権限・経理権限のみ表示のみ表示
if (Const.AUTH_ADMIN.equals(authCode) || Const.AUTH_ACCT.equals(authCode)) {
%>
	<td><input type="button" name="invCount" value="棚卸在庫検索" onclick="seachForInvCount(this.form);"></td>
	<td><input type="button" name="invCountOut" value="棚卸在庫出力" onclick="location.href='LoadExcelForInvCount'"></td>
<%
}
%>
	<td>
		<select name="WEB_DISP" onchange="search(this.form);">
			<option value="">WEB表示</option>
			<option value="0">無</option>
			<option value="1">有</option>
		</select>
	<td>
</tr>
</table>
</div>
<div align="right">
<input type="button" name="reginv" value="在庫登録" onclick="regInv(this.form);">
<input type="button" name="sort1" value="分類で並び替え" onclick="sortList(this.form,1);">
<input type="button" name="sort0" value="メーカーで並び替え" onclick="sortList(this.form,6);">
<input type="button" name="sort2" value="登録日で並び替え" onclick="sortList(this.form,2);">
<input type="button" name="sort1" value="WEB表示日時で並び替え" onclick="sortList(this.form,7);">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
out.println("<div id=\"count\">件数:" + listInventoryRecord.size() + "</div>");
}
%>
<div>
<input type="hidden" name="type">
<input type="hidden" name="sort">
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<input type="button" name="detail" value="在庫詳細" onclick="callServer(this.form,4);">
<input type="button" name="update" value="在庫更新" onclick="callServer(this.form,0);">
<input type="button" name="updatepic" value="写真更新" onclick="callServer(this.form,3);">
<%
// 管理者権限のみ表示
if (Const.AUTH_ADMIN.equals(authCode)) {
%>
<input type="button" name="delete" value="在庫削除" onclick="callServer(this.form,2);">
<input type="button" name="close" value="在庫締め" onclick="callServer(this.form,5);">
<%
}
%>
<%
// 事務以外表示
if (!Const.AUTH_OFFICE.equals(authCode)) {
%>
<input type="button" name="createos" value="注文書出力" onclick="createOrderSheet(this.form);">
<input type="button" name="createji" value="請求書出力" onclick="createJpInvoice(this.form);">
<input type="button" name="createji" value="Proforma Invoice出力" onclick="createProformaInvoice(this.form);">
<%
}
%>
<%
// 一般と事務以外表示
if (!Const.AUTH_NORMAL.equals(authCode) && !Const.AUTH_OFFICE.equals(authCode)) {
%>
<input type="button" name="createex" value="EXCEL出力" onclick="createExcel(this.form);">
<%
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" class="t-line">
<tr>
<th class="th">選択</td>
<th class="th">出力</td>
<th class="th">No</td>
<th class="th">WEB表示</td>
<!--<th class="th">WEB表示日時</td>-->
<th class="th">分類</td>
<th class="th">メーカー</td>
<th class="th">型式</td>
<th class="th">号機</td>
<!--<th class="th">年式</td>-->
<th class="th">表示価格</td>
<th class="th">登録日</td>
<th class="th">仕入担当</td>
<%
// 事務以外は表示
if (!Const.AUTH_OFFICE.equals(authCode)) {
%>
<th class="th">発注日</td>
<th class="th">仕入先</td>
<th class="th">仕入原価</td>
<th class="th">仕入支払日</td>
<th class="th">販売先</td>
<th class="th">販売原価</td>
<!--<th class="th">販売価格</td>-->
<!--<th class="th">利益</td>-->
<th class="th">売上入金日</td>
<th class="th">売上月</td>
<%
}
%>
</tr>
<%
if (listInventoryRecord != null) {
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
int cnt = 1;
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap class=\"td\"><input type=\"radio\" name=\"EDITID\" value=\""+ inventoryRecord.getDATE() +"\"></td>";
		record = record + "<td nowrap class=\"td\"><input type=\"checkbox\" name=\"REPID\" value=\""+ inventoryRecord.getDATE() +"\"></td>";
		record = record + "<td nowrap class=\"td\">" + cnt + "</td>";
		record = record + "<td nowrap class=\"td\">" + CodeUtil.getIsDisp(inventoryRecord.getWEB_DISP()) + "</td>";
//		record = record + "<td nowrap class=\"td\">" + CommonUtil.nullConv(inventoryRecord.getWEB_DISP_DATE()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + CodeUtil.getTypeJa(inventoryRecord.getTYPE()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getMANUFACTURER() + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getNAME() + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getSERIALNO() + "</td>";
//		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getYEAR() + "</td>";
		record = record + "<td nowrap style=\"text-align:right;\" class=\"td\">" + CommonUtil.moneyFormat(inventoryRecord.getPRICE()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + sdf.format(date) + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getACCOUNT() + "</td>";
// 事務以外は表示
if (!Const.AUTH_OFFICE.equals(authCode)) {
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getORDER_DATE() + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getSELLER() + "</td>";
		record = record + "<td nowrap style=\"text-align:right;\" class=\"td\">" + CommonUtil.moneyFormat(inventoryRecord.getORDER_COST_PRICE()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getORDER_PAY_DATE() + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getBUYER() + "</td>";
		record = record + "<td nowrap style=\"text-align:right;\" class=\"td\">" + CommonUtil.moneyFormat(inventoryRecord.getSELL_COST_PRICE()) + "</td>";
//		record = record + "<td nowrap style=\"text-align:right;\" class=\"td\">" + CommonUtil.moneyFormat(inventoryRecord.getSELL_PRICE()) + "</td>";
//		record = record + "<td nowrap style=\"text-align:right;\" class=\"td\">" + CommonUtil.moneyFormat(inventoryRecord.getPROFIT()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getSELL_PAY_DATE() + "</td>";
		record = record + "<td nowrap class=\"td\">" + inventoryRecord.getSELL_MONTH() + "</td>";
}
	  record = record + "</tr>";
	  out.println(record);
		cnt++;
	}
}

String record = "<tr>";
record = record + "<td>Total</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
//record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
//record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
// 事務以外は表示
if (!Const.AUTH_OFFICE.equals(authCode)) {
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(orderCostPrice) + "</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(sellCostPrice) + "</td>";
//record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(sellPrice) + "</td>";
//record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(profit) + "</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
}
record = record + "</tr>";
out.println(record);

 %>
</table>
</div>
<div>
<input type="button" name="detail2" value="在庫詳細" onclick="callServer(this.form,4);">
<input type="button" name="update2" value="在庫更新" onclick="callServer(this.form,0);">
<input type="button" name="updatepic2" value="写真更新" onclick="callServer(this.form,3);">
<%
// 管理者権限のみ表示
if (Const.AUTH_ADMIN.equals(authCode)) {
%>
<input type="button" name="delete2" value="在庫削除" onclick="callServer(this.form,2);">
<input type="button" name="close2" value="在庫締め" onclick="callServer(this.form,5);">
<%
}
%>
<%
// 事務以外表示
if (!Const.AUTH_OFFICE.equals(authCode)) {
%>
<input type="button" name="createos" value="注文書出力" onclick="createOrderSheet(this.form);">
<input type="button" name="createji" value="請求書出力" onclick="createJpInvoice(this.form);">
<input type="button" name="createji" value="Proforma Invoice出力" onclick="createProformaInvoice(this.form);">
<%
}
%>
<%
// 一般以外表示
if (!Const.AUTH_NORMAL.equals(authCode) && !Const.AUTH_OFFICE.equals(authCode)) {
%>
<input type="button" name="createex" value="EXCEL出力" onclick="createExcel(this.form);">
<%
}
%>
</div>
</form>
</div>
</body>
</html>