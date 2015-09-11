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
<title>INVENTORY ALL LIST</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="GetInventoryAllList"  method="POST">
<div><input type="button" name="close" value="BACK" onclick="history.back();"></div>
<div>
<input type="hidden" name="page" value="1">
<input type="hidden" name="sort">
</div>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
out.println("<div id=\"count\">Number of Inventory:" + listInventoryRecord.size() + "</div>");
}
%>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700" align="left">
<tr>
<td nowrap class="th">TYPE</td>
<td nowrap class="th">MAKER</td>
<td nowrap class="th">MODEL</td>
<td nowrap class="th">YEAR</td>
<!--<td nowrap class="th">SERIAL</td>-->
<!--<td nowrap class="th">METER</td>-->
<td nowrap class="th">RANK</td>
<td nowrap class="th">PRICE</td>
<td nowrap class="th">DETAIL</td>
<td nowrap class="th">PHOTO</td>
</tr>
<%
if (listInventoryRecord != null) {
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td class=\"td\">" + CodeUtil.getTypeEng(inventoryRecord.getTYPE()) + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getMANUFACTURER()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getNAME()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getYEAR()  + "</td>";
//		record = record + "<td class=\"td\">" + inventoryRecord.getSERIALNO()  + "</td>";
//		record = record + "<td class=\"td\">" + inventoryRecord.getHOURS()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getCONDITION()  + "</td>";
		record = record + "<td class=\"td\" style=\"text-align:right;\">" + CommonUtil.checkEmptyOrZero(CommonUtil.moneyFormat(inventoryRecord.getPRICE()))  + "</td>";
		record = record + "<td class=\"td\"><input type=\"button\" value=\"DETAIL\" onClick=\"location.href='DetailInventory?page=1&EDITID=" + inventoryRecord.getDATE() + "'\"></td>";

		if (inventoryRecord.getPIC_URL() != null && inventoryRecord.getPIC_URL().length() > 0) {
			record = record + "<td class=\"td\"><a href=\"" + inventoryRecord.getPIC_URL() + "\" target=\"_blank\"><img src=\"img/piclink.gif\"></a></td>";
		}
		else {
			record = record + "<td class=\"td\">&nbsp;</td>";
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