<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");
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
if (Const.AUTH_ADMIN.equals(authCode) || Const.AUTH_ACCT.equals(authCode)) {
%>
<input type="button" name="delete" value="削除" onclick="callServer(this.form,2);">
<%
}
%>
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" class="t-line">
<tr>
<th nowrap class="th">選択</td>
<th nowrap class="th">日時</td>
<th nowrap class="th">名前</td>
<th nowrap class="th">〒</td>
<th nowrap class="th">県名</td>
<th nowrap class="th">住所</td>
<th nowrap class="th">TEL</td>
<th nowrap class="th">FAX</td>
<th nowrap class="th">MAIL</td>
<th nowrap class="th">状態</td>
<th nowrap class="th">金額</td>
<th nowrap class="th">分類</td>
<th nowrap class="th">メーカー</td>
<th nowrap class="th">型式</td>
<th nowrap class="th">年式</td>
<th nowrap class="th">号機</td>
<th nowrap class="th">メーター</td>
<th nowrap class="th">程度</td>
<th nowrap class="th">詳細</td>
</tr>
<%
List listEsateiRecord = (List)request.getAttribute("listEsateiList");
if (listEsateiRecord != null) {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	for (Iterator iterator = listEsateiRecord.iterator(); iterator.hasNext();) {
		Esatei esateiRecord = (Esatei) iterator.next();
	  Date date = new Date(Long.parseLong(esateiRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap class=\"td\"><input type=\"radio\" name=\"EDITID\" value=\""+ esateiRecord.getDATE() +"\"></td>";
		record = record + "<td class=\"td\">" + sdf.format(date)  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getSELLER() + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getPOST()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getPNAME()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getADDRESS()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getTEL()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getFAX()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getEMAIL()  + "</td>";
		record = record + "<td class=\"td\">" + CodeUtil.getSateiType(esateiRecord.getSOURCE())  + "</td>";

		record = record + "<td class=\"td\" style=\"text-align:right;\">" + CommonUtil.moneyFormat(esateiRecord.getORDER_PRICE())  + "</td>";
		record = record + "<td class=\"td\">" + CodeUtil.getTypeJa(esateiRecord.getTYPE())  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getMANUFACTURER()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getNAME()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getYEAR()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getSERIALNO()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getHOURS()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getCONDITION()  + "</td>";
		record = record + "<td class=\"td\">" + esateiRecord.getMEMO()  + "</td>";
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