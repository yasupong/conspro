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
<title>INVENTORY LIST</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<!--<script src="js/tinybox.js" type="text/javascript"></script>-->
<!--<script src="js/conspro.js" type="text/javascript"></script>-->
<script type="text/javascript">
<!--
	function callSearchByMaker() {
		location.href='GetInventoryListByType?TYPE=maker&page=1&MANUFACTURER=' + document.main.MANUFACTURER.value;
	}
-->
</script>
</head>
<body>
<div id="page">
<form name="main">
<div>
<select name="MANUFACTURER" size="1" onChange="callSearchByMaker()">
        <option value="" selected>MAKER</option>
				<option value="AIRMAN">AIRMAN</option>
				<option value="BOMAG">BOMAG</option>
				<option value="CAT">CAT</option>
				<option value="DENYO">DENYO</option>
				<option value="DYNAPAC">DYNAPAC</option>
				<option value="FURUKAWA">FURUKAWA</option>
				<option value="HANTA">HANTA</option>
				<option value="HITACHI">HITACHI</option>
				<option value="IHI">IHI</option>
				<option value="KATO">KATO</option>
				<option value="KAWASAKI">KAWASAKI</option>
				<option value="KOBELCO">KOBELCO</option>
				<option value="KOMATSU">KOMATSU</option>
				<option value="KUBOTA">KUBOTA</option>
				<option value="MEIWA">MEIWA</option>
				<option value="MIKASA">MIKASA</option>
				<option value="MITSUBISHI">MITSUBISHI</option>
				<option value="MOROOKA">MOROOKA</option>
				<option value="NISSHA">NISSHA</option>
				<option value="OTHER">OTHER</option>
				<option value="SAKAI">SAKAI</option>
				<option value="SHINDAIWA">SHINDAIWA</option>
				<option value="SUMITOMO">SUMITOMO</option>
				<option value="TACOM">TACOM</option>
				<option value="TADANO">TADANO</option>
				<option value="TCM">TCM</option>
				<option value="YANMAR">YANMAR</option>
</select>
&nbsp;
<input type="button" value="Mini Excavator" onClick="location.href='GetInventoryListByType?TYPE=1&page=1'">&nbsp;
<input type="button" value="Excavator" onClick="location.href='GetInventoryListByType?TYPE=2&page=1'">&nbsp;
<input type="button" value="Crawler Dozer" onClick="location.href='GetInventoryListByType?TYPE=3&page=1'">&nbsp;
<input type="button" value="Crawler Loader" onClick="location.href='GetInventoryListByType?TYPE=4&page=1'">&nbsp;
<input type="button" value="Wheel Loader" onClick="location.href='GetInventoryListByType?TYPE=5&page=1'">&nbsp;
<input type="button" value="Road Equipment" onClick="location.href='GetInventoryListByType?TYPE=6&page=1'">&nbsp;
<input type="button" value="Crane" onClick="location.href='GetInventoryListByType?TYPE=7&page=1'">&nbsp;
<input type="button" value="Crawler Carrier" onClick="location.href='GetInventoryListByType?TYPE=8&page=1'">&nbsp;
<input type="button" value="Attachment" onClick="location.href='GetInventoryListByType?TYPE=9&page=1'">&nbsp;
<input type="button" value="Parts" onClick="location.href='GetInventoryListByType?TYPE=10&page=1'">&nbsp;
<input type="button" value="Generator" onClick="location.href='GetInventoryListByType?TYPE=11&page=1'">&nbsp;
<input type="button" value="Air Compressor" onClick="location.href='GetInventoryListByType?TYPE=12&page=1'">&nbsp;
<input type="button" value="Welder" onClick="location.href='GetInventoryListByType?TYPE=13&page=1'">&nbsp;
<input type="button" value="Truck" onClick="location.href='GetInventoryListByType?TYPE=14&page=1'">&nbsp;
<input type="button" value="Other" onClick="location.href='GetInventoryListByType?TYPE=99&page=1'">&nbsp;
<input type="button" value="ALL LIST" onClick="location.href='GetInventoryAllList?page=1'">
</div>
<div>&nbsp;</div>
<div id="category">Now Showing:
<%
if (request.getParameter("TYPE") != null && request.getParameter("TYPE").length() > 0) {
	out.println(CodeUtil.getTypeEng(request.getParameter("TYPE")));
}
if (request.getParameter("MANUFACTURER") != null && request.getParameter("MANUFACTURER").length() > 0) {
	out.println(request.getParameter("MANUFACTURER"));
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700" align="left">
<tr>
<td nowrap bgcolor="#ffd700">THUMBNAIL</td>
<td nowrap bgcolor="#ffd700">MAKER</td>
<td nowrap bgcolor="#ffd700">MODEL</td>
<td nowrap bgcolor="#ffd700">YEAR</td>
<!--<td nowrap bgcolor="#ffd700">SERIAL</td>-->
<!--<td nowrap bgcolor="#ffd700">METER</td>-->
<td nowrap bgcolor="#ffd700">RANK</td>
<td nowrap bgcolor="#ffd700">PRICE</td>
<td nowrap bgcolor="#ffd700">DETAIL</td>
<td nowrap bgcolor="#ffd700">PHOTO</td>
</tr>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td bgcolor=\"#e6e6e6\" width=\"112\"><img src=\"GetPicture?EDITID=" + inventoryRecord.getDATE() + "\" width=\"112\" height=\"84\"></td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getMANUFACTURER()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getNAME()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getYEAR()  + "</td>";
//		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getSERIALNO()  + "</td>";
//		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getHOURS()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + inventoryRecord.getCONDITION()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.checkEmptyOrZero(CommonUtil.moneyFormat(inventoryRecord.getPRICE())) + "</td>";
//		record = record + "<td bgcolor=\"#e6e6e6\"><a href=\"#\" onclick=\"showDetailInfoEn('"+ inventoryRecord.getMANUFACTURER()  + "','"+ inventoryRecord.getNAME() + "','"+ inventoryRecord.getOTHER() + "')\">SHOW</a></td>";
		record = record + "<td bgcolor=\"#e6e6e6\"><input type=\"button\" value=\"DETAIL\" onClick=\"location.href='DetailInventory?page=1&EDITID=" + inventoryRecord.getDATE() + "'\"></td>";

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