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
<title>在庫一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callSearchByMaker() {
		location.href='GetInventoryListByType?TYPE=maker&page=2&MANUFACTURER=' + document.main.MANUFACTURER.value;
	}
-->
</script>
</head>
<body>
<div id="page">
<form name="main">
<div>
<select name="MANUFACTURER" size="1" onChange="callSearchByMaker()">
        <option value="" selected>メーカー選択</option>
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
<input type="button" value="油圧ショベル 8t未満" onClick="location.href='GetInventoryListByType?TYPE=1&page=2'">&nbsp;
<input type="button" value="油圧ショベル 10t以上" onClick="location.href='GetInventoryListByType?TYPE=2&page=2'">&nbsp;
<input type="button" value="ブルドーザー" onClick="location.href='GetInventoryListByType?TYPE=3&page=2'">&nbsp;
<input type="button" value="ショベルローダー" onClick="location.href='GetInventoryListByType?TYPE=4&page=2'">&nbsp;
<input type="button" value="タイヤショベル" onClick="location.href='GetInventoryListByType?TYPE=5&page=2'">&nbsp;
<input type="button" value="舗装機械" onClick="location.href='GetInventoryListByType?TYPE=6&page=2'">&nbsp;
<input type="button" value="クレーン" onClick="location.href='GetInventoryListByType?TYPE=7&page=2'">&nbsp;
<input type="button" value="キャリアダンプ" onClick="location.href='GetInventoryListByType?TYPE=8&page=2'">&nbsp;
<input type="button" value="アタッチメント" onClick="location.href='GetInventoryListByType?TYPE=9&page=2'">&nbsp;
<input type="button" value="部品" onClick="location.href='GetInventoryListByType?TYPE=10&page=2'">&nbsp;
<input type="button" value="発電機" onClick="location.href='GetInventoryListByType?TYPE=11&page=2'">&nbsp;
<input type="button" value="エアーコンプレッサー" onClick="location.href='GetInventoryListByType?TYPE=12&page=2'">&nbsp;
<input type="button" value="溶接機" onClick="location.href='GetInventoryListByType?TYPE=13&page=2'">&nbsp;
<input type="button" value="トラック" onClick="location.href='GetInventoryListByType?TYPE=14&page=2'">&nbsp;
<input type="button" value="その他" onClick="location.href='GetInventoryListByType?TYPE=99&page=2'">&nbsp;
<input type="button" value="全在庫一覧" onClick="location.href='GetInventoryAllList?page=2'">
</div>
<div>&nbsp;</div>
<div id="category">現在のカテゴリー：
<%
if (request.getParameter("TYPE") != null && request.getParameter("TYPE").length() > 0) {
	out.println(CodeUtil.getTypeJa(request.getParameter("TYPE")));
}
if (request.getParameter("MANUFACTURER") != null && request.getParameter("MANUFACTURER").length() > 0) {
	out.println(request.getParameter("MANUFACTURER"));
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700" align="left">
<tbody>
<tr>
<td nowrap class="th">サムネイル</td>
<td nowrap class="th">メーカー</td>
<td nowrap class="th">型式</td>
<td nowrap class="th">年式</td>
<!--<td nowrap class="th">号機</td>-->
<!--<td nowrap class="th">メーター</td>-->
<td nowrap class="th">程度</td>
<td nowrap class="th">価格</td>
<td nowrap class="th">詳細</td>
<td nowrap class="th">写真</td>
</tr>
<%
List listInventoryRecord = (List)request.getAttribute("InventoryRecordList");
if (listInventoryRecord != null) {
	for (Iterator iterator = listInventoryRecord.iterator(); iterator.hasNext();) {
		InventoryRecord inventoryRecord = (InventoryRecord) iterator.next();
	  Date date = new Date(Long.parseLong(inventoryRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td class=\"td\" width=\"112\"><img src=\"GetPicture?EDITID=" + inventoryRecord.getDATE() + "\" width=\"112\" height=\"84\"></td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getMANUFACTURER()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getNAME()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getYEAR()  + "</td>";
//		record = record + "<td class=\"td\">" + inventoryRecord.getSERIALNO()  + "</td>";
//		record = record + "<td class=\"td\">" + inventoryRecord.getHOURS()  + "</td>";
		record = record + "<td class=\"td\">" + inventoryRecord.getCONDITION()  + "</td>";
		record = record + "<td class=\"td\" style=\"text-align:right;\">" + CommonUtil.checkEmptyOrZero(CommonUtil.moneyFormat(inventoryRecord.getPRICE())) + "</td>";
//		record = record + "<td class=\"td\"><a href=\"#\" onclick=\"showDetailInfo('"+ inventoryRecord.getMANUFACTURER()  + "','"+ inventoryRecord.getNAME() + "','"+ inventoryRecord.getOTHER_JA() + "')\">表示</a></td>";
		record = record + "<td class=\"td\"><input type=\"button\" value=\"詳細\" onClick=\"location.href='DetailInventory?page=2&EDITID=" + inventoryRecord.getDATE() + "'\"></td>";

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
</tbody>
</table>
</div>
</div>
</form>
</body>
</html>