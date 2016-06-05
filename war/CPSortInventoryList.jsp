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
<title>Latest List</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script src="js/conspro.js" type="text/javascript"></script>
</head>
<body>
<div id="page">
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="640">
<tr>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
	int count = 1;
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		if (count > 8) {
			break;
		}
		if (count == 5) {
				  out.println("</tr><tr>");
		}
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
		String record = "<td width=\"160\"><a href=\"javascript:void(0)\" onclick=\"loadDetailEn(" + inventoryRecord.getDATE() + ")\"><img src=\"GetPicture?EDITID=" + inventoryRecord.getDATE() + "\" width=\"160\" height=\"120\" title=\"" + inventoryRecord.getOTHER() + "\"><br>" + inventoryRecord.getMANUFACTURER() + "<br>" + inventoryRecord.getNAME() + "</a></td>";
	  out.println(record);
		count++;
	}
}
%>
</tr>
</table>
</div>
</div>
</body>
</html>