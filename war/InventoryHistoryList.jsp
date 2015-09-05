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
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>在庫削除履歴一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="EditInventoryHistory"  method="POST">
<div><h1>在庫削除履歴一覧</h1></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
out.println("<div id=\"count\">在庫削除履歴数:" + listInventoryRecord.size() + "</div>");
}
%>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
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
 %>
</table>
</div>
</form>
</div>
</body>
</html>