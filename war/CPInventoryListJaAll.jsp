<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>全在庫一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="GetInventoryAllList"  method="POST">
<div><input type="button" name="close" value="戻る" onclick="history.back();"></div>
<div>
<input type="hidden" name="page" value="2">
<input type="hidden" name="sort">
</div>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
out.println("<div id=\"count\">在庫登録数：" + listInventoryRecord.size() + "</div>");
}
%>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700" align="left">
<tr>
<td nowrap bgcolor="#ffd700">分類</td>
<td nowrap bgcolor="#ffd700">メーカー</td>
<td nowrap bgcolor="#ffd700">型式</td>
<td nowrap bgcolor="#ffd700">年式</td>
<!--<td nowrap bgcolor="#ffd700">号機</td>-->
<!--<td nowrap bgcolor="#ffd700">メーター</td>-->
<td nowrap bgcolor="#ffd700">程度</td>
<td nowrap bgcolor="#ffd700">価格</td>
<td nowrap bgcolor="#ffd700">詳細</td>
<td nowrap bgcolor="#ffd700">写真</td>
</tr>
<%
if (listInventoryRecord != null) {
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + CodeUtil.getTypeJa(inventoryRecord.getTYPE()) + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getMANUFACTURER() + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getNAME()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getYEAR()  + "</td>";
//		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getSERIALNO()  + "</td>";
//		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getHOURS()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getCONDITION()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.checkEmptyOrZero(CommonUtil.moneyFormat(inventoryRecord.getPRICE()))  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\"><input type=\"button\" value=\"詳細\" onClick=\"location.href='DetailInventory?page=2&EDITID=" + inventoryRecord.getDATE() + "'\"></td>";

		if (inventoryRecord.getPIC_URL() != null && inventoryRecord.getPIC_URL().length() > 0) {
			record = record + "<td bgcolor=\"#e6e6e6\"><a href=\"" + inventoryRecord.getPIC_URL() + "\" target=\"_blank\"><img src=\"img/piclink.gif\"></a></td>";
		}
		else {
			record = record + "<td bgcolor=\"#e6e6e6\">&nbsp;</td>";
		}

	 	record = record + "</tr>";
	  out.println(record);
	}
}
%>
</table>
</div>
</form>
</div>
</body>
</html>