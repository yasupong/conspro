<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<%
	InventoryRecord inventoryRecord = (InventoryRecord)request.getAttribute("InventoryRecord");
	String type = (String)request.getAttribute("TYPE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title><%= inventoryRecord.getMANUFACTURER() %> <%= inventoryRecord.getNAME() %></title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script src="js/conspro.js" type="text/javascript"></script>
</head>
<body>
<div id="page">
<%
	if (!"1".equals(type)) {
%>
<div><input type="button" name="close" value="BACK" onclick="history.back();"></div>
<%
	}
%>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="665" align="left">
<tr>
<td width="664" colspan="2"><img src="GetPicture?EDITID=<%= inventoryRecord.getDATE() %>"width="664" height="498"></td>
</tr>
<tr>
<td class="th" nowrap>TYPE</td>
<td class="td"><%= CodeUtil.getTypeEng(inventoryRecord.getTYPE()) %></td>
</tr>
<tr>
<td class="th" nowrap>MAKER</td>
<td class="td"><%= inventoryRecord.getMANUFACTURER() %></td>
</tr>
<tr>
<td class="th" nowrap>MODEL</td>
<td class="td"><%= inventoryRecord.getNAME() %></td>
</tr>
<tr>
<td class="th" nowrap>YEAR</td>
<td class="td"><%= inventoryRecord.getYEAR() %></td>
</tr>
<tr>
<td class="th" nowrap>SERIAL</td>
<td class="td"><%= inventoryRecord.getSERIALNO() %></td>
</tr>
<tr>
<td class="th" nowrap>METER</td>
<td class="td"><%= inventoryRecord.getHOURS() %></td>
</tr>
<tr>
<td class="th" nowrap>RANK</td>
<td class="td"><%= inventoryRecord.getCONDITION() %></td>
</tr>
<tr>
<td class="th" nowrap>PRICE</td>
<td class="td" style=\"text-align:right;\"><%= CommonUtil.checkEmptyOrZero(CommonUtil.moneyFormat(inventoryRecord.getPRICE())) %></td>
</tr>
<tr>
<td class="th" nowrap>DETAIL</td>
<td class="td"><%= inventoryRecord.getOTHER() %></td>
</tr>
<tr>
<td class="th" nowrap>PHOTO</td>
<td class="td">
<%
if (inventoryRecord.getPIC_URL() != null && inventoryRecord.getPIC_URL().length() > 0) {
%>
<a href="<%= inventoryRecord.getPIC_URL() %>" target="_blank"><img src="img/piclink.gif"></a>
<%
} else {
%>
&nbsp;
<%
}
%>
</td>
</tr>
</table>
</div>
</div>
</body>
</html>