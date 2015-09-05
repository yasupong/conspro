<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 認証チェック
	String account = request.getParameter("ACCOUNT");
	if (account == null || account.length() == 0) {
		response.sendRedirect("LoginErr.jsp");
	}

	if (!account.equals(request.getSession().getAttribute("ACCOUNT"))) {
		response.sendRedirect("LoginErr.jsp");
	}
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
		if (arg==6) {
			if (!confirm('締め戻しを行います\nよろしいですか？')) {
				return;
			}
		}
		obj.action='EditInventory';
		obj.submit();
	}

	function createExcelForClosedInv(obj) {
		obj.target='_self';
		obj.action='LoadExcelForClosedInv';
		obj.submit();
	}

//	function sortList(obj,sortType) {
//    obj.sort.value=sortType;
//		obj.target='_self';
//		obj.action='GetOldInventoryList';
//		obj.submit();
//	}

	function search(obj) {

		// 負荷軽減のため検索条件設定必須
		if (obj.SELL_MONTH.value == '' && obj.NAME.value == '' && obj.SELLER.value == ''&& obj.TANTO.value == '') {
			alert('検索条件を必ず指定してください。');
			return;
		}

		obj.target='_self';
		obj.action='/SeachOldInventoryList';
		obj.submit();
	}

-->
</script>
<title>締め在庫一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="EditInventory" name="cloesedListForm" method="POST">
<div><h1>締め在庫一覧</h1></div>
<div id="msg"><%= CommonUtil.nullConv(msg) %></div>
<div id="cond">検索条件</div>
<div align="left">
<table border="0">
<tr>
	<td>売上月</td>
	<td>
		<select name="SELL_MONTH">
				<option value="">選択</option>
				<%= CommonUtil.buildOptions(Const.SELL_MONTH_SET) %>
		</select>
	</td>

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
</tr>
</table>
</div>
<div align="right">
<!--
<input type="button" name="sort1" value="分類で並び替え" onclick="sortList(this.form,1);">
<input type="button" name="sort0" value="メーカーで並び替え" onclick="sortList(this.form,6);">
<input type="button" name="sort2" value="登録日で並び替え" onclick="sortList(this.form,2);">
-->
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
<%
// 管理者権限のみ表示
if ("3".equals(authCode)) {
%>
<input type="button" name="back" value="締め戻し" onclick="callServer(this.form,6);">
<%
}
%>
<%
// 一般以外表示
if (!"1".equals(authCode)) {
%>
<input type="button" name="createex" value="締め在庫EXCEL出力" onclick="createExcelForClosedInv(this.form);">
<%
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td nowrap bgcolor="#ffd700">選択</td>
<td nowrap bgcolor="#ffd700">No</td>
<td nowrap bgcolor="#ffd700">分類</td>
<td nowrap bgcolor="#ffd700">メーカー</td>
<td nowrap bgcolor="#ffd700">型式</td>
<td nowrap bgcolor="#ffd700">号機</td>
<td nowrap bgcolor="#ffd700">年式</td>
<td nowrap bgcolor="#ffd700">表示価格</td>
<td nowrap bgcolor="#ffd700">登録日</td>
<td nowrap bgcolor="#ffd700">仕入担当</td>
<td nowrap bgcolor="#ffd700">発注日</td>
<td nowrap bgcolor="#ffd700">仕入先</td>
<td nowrap bgcolor="#ffd700">仕入原価</td>
<td nowrap bgcolor="#ffd700">仕入支払日</td>
<td nowrap bgcolor="#ffd700">販売先</td>
<td nowrap bgcolor="#ffd700">販売原価</td>
<td nowrap bgcolor="#ffd700">販売価格</td>
<td nowrap bgcolor="#ffd700">利益</td>
<td nowrap bgcolor="#ffd700">売上入金日</td>
<td nowrap bgcolor="#ffd700">売上月</td>
</tr>
<%
if (listInventoryRecord != null) {
SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
int cnt = 1;
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\"><input type=\"radio\" name=\"EDITID\" value=\""+ inventoryRecord.getDATE() +"\"></td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + cnt + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + CodeUtil.getTypeJa(inventoryRecord.getTYPE()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getMANUFACTURER() + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getNAME() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getSERIALNO() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getYEAR() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(inventoryRecord.getPRICE()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + sdf.format(date) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getACCOUNT() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getORDER_DATE() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getSELLER() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(inventoryRecord.getORDER_COST_PRICE()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getORDER_PAY_DATE() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getBUYER() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(inventoryRecord.getSELL_COST_PRICE()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(inventoryRecord.getSELL_PRICE()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(inventoryRecord.getPROFIT()) + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getSELL_PAY_DATE() + "</td>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\">" + inventoryRecord.getSELL_MONTH() + "</td>";
	  record = record + "</tr>";
	  out.println(record);
		cnt++;
	}
}

String record = "<tr>";
record = record + "<td>Total</td>";
record = record + "<td>&nbsp;</td>";
//record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(orderCostPrice) + "</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(sellCostPrice) + "</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(sellPrice) + "</td>";
record = record + "<td nowrap style=\"text-align:right;\">" + CommonUtil.moneyFormat(profit) + "</td>";
record = record + "<td>&nbsp;</td>";
record = record + "<td>&nbsp;</td>";
record = record + "</tr>";
out.println(record);

 %>
</table>
</div>
<div>
<input type="button" name="detail2" value="在庫詳細" onclick="callServer(this.form,4);">
<%
// 管理者権限のみ表示
if ("3".equals(authCode)) {
%>
<input type="button" name="back2" value="締め戻し" onclick="callServer(this.form,6);">
<%
}
%>
<%
// 一般以外表示
if (!"1".equals(authCode)) {
%>
<input type="button" name="createex" value="締め在庫EXCEL出力" onclick="createExcelForClosedInv(this.form);">
<%
}
%>
</div>
</form>
</div>
</body>
</html>