<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>査定受付一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj,arg) {
		obj.type.value=arg;
		if (arg==2) {
			if (!confirm('削除してよろしいですか？')) {
				return;
			}
		}
		obj.submit();
	}
-->
</script>
</head>
<body>
<div id="page">
<form action="EditEsatei"  method="POST">
<div><h1>査定受付一覧</h1></div>
<div align="right"><input type="button" name="close" value="閉じる" onclick="window.close();"></div>
<div>
<input type="hidden" name="type">
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<%
// 経理・管理者権限のみ表示
if ("3".equals(authCode) || "2".equals(authCode)) {
%>
<input type="button" name="delete" value="削除" onclick="callServer(this.form,2);">
<%
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td nowrap bgcolor="#ffd700">選択</td>
<td nowrap bgcolor="#ffd700">日時</td>
<td nowrap bgcolor="#ffd700">名前</td>
<td nowrap bgcolor="#ffd700">〒</td>
<td nowrap bgcolor="#ffd700">県名</td>
<td nowrap bgcolor="#ffd700">住所</td>
<td nowrap bgcolor="#ffd700">TEL</td>
<td nowrap bgcolor="#ffd700">FAX</td>
<td nowrap bgcolor="#ffd700">MAIL</td>
<td nowrap bgcolor="#ffd700">状態</td>

<td nowrap bgcolor="#ffd700">金額</td>
<td nowrap bgcolor="#ffd700">分類</td>
<td nowrap bgcolor="#ffd700">メーカー</td>
<td nowrap bgcolor="#ffd700">型式</td>
<td nowrap bgcolor="#ffd700">年式</td>
<td nowrap bgcolor="#ffd700">号機</td>
<td nowrap bgcolor="#ffd700">メーター</td>
<td nowrap bgcolor="#ffd700">程度</td>
<td nowrap bgcolor="#ffd700">詳細</td>
</tr>
<%
List listEsateiRecord = (List)request.getAttribute("listEsateiList");
if (listEsateiRecord != null) {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	for (Iterator iterator = listEsateiRecord.iterator(); iterator.hasNext();) {
		Esatei esateiRecord = (Esatei) iterator.next();
	  Date date = new Date(Long.parseLong(esateiRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\"><input type=\"radio\" name=\"EDITID\" value=\""+ esateiRecord.getDATE() +"\"></td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + sdf.format(date)  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getSELLER() + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getPOST()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getPNAME()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getADDRESS()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getTEL()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getFAX()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getEMAIL()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + CodeUtil.getSateiType(esateiRecord.getSOURCE())  + "</td>";

		record = record + "<td bgcolor=\"#e6e6e6\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(esateiRecord.getORDER_PRICE())  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + CodeUtil.getTypeJa(esateiRecord.getTYPE())  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getMANUFACTURER()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getNAME()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getYEAR()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getSERIALNO()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getHOURS()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getCONDITION()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + esateiRecord.getMEMO()  + "</td>";
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