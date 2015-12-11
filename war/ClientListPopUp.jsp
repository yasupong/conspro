<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<script type="text/javascript">
<!--
	function selectData(obj) {
		window.opener.document.getElementById(obj.code.value).value = window.document.getElementById('CLIENT_CODE' + obj.CNT.value).value;
		window.opener.document.getElementById(obj.name.value).value = window.document.getElementById('COMPANY_OFFICE' + obj.CNT.value).value;
		window.close();
	}

	function search(obj) {
		obj.target='_self';
		obj.action='SeachClientList';
		obj.submit();
	}
-->
</script>
<title>顧客選択</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form method="POST">
<div><h1>顧客選択</h1></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<div id="cond">検索条件</div>
<div align="left">
<table border="0">
<tr>
	<td>業種</td>
	<td>
		<select name="CLIENT_TYPE">
			<option value="">選択</option>
			<%= Const.COMBO_CLIENT_TYPE %>
		</select>
	</td>
</tr>
<tr>
	<td>与信管理</td>
	<td>
		<select name="CREDIT">
			<option value="">選択</option>
			<%= Const.COMBO_CREDIT %>
		</select>
	</td>
</tr>
<tr>
	<td>国番号</td>
	<td>
		<input type="text" name="COUNTRY" value="">
	</td>
</tr>
<tr>
	<td>会社名</td>
	<td>
		<input type="text" name="COMPANY" value="">
	</td>
</tr>
<tr>
	<td>支店営業所</td>
	<td>
		<input type="text" name="OFFICE" value="">
	</td>
</tr>
<tr>
	<td>担当者</td>
	<td>
		<input type="text" name="NAME" value="">
	</td>
</tr>
<tr>
	<td>電話番号</td>
	<td>
		<input type="text" name="TEL" value="">
	</td>
</tr>
<tr>
	<td>郵便番号</td>
	<td>
		<input type="text" name="ZIP" value="">
	</td>
</tr>
<tr>
	<td><input type="button" name="srch" value="検索" onclick="search(this.form);"></td>
</tr>
</table>
</div>
<div>&nbsp;</div>
<div>
<input type="hidden" name="type" value="0">
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<input type="hidden" name="code" value="<%= request.getParameter("code") %>">
<input type="hidden" name="name" value="<%= request.getParameter("name") %>">
<input type="button" name="select" value="選択" onclick="selectData(this.form);">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<div>
<tr>
<td class="th">選択</td>
<td class="th">顧客コード</td>
<td class="th">業種</td>
<td class="th">与信管理</td>
<td class="th">国番号</td>
<td class="th">顧客番号</td>
<td class="th">会社名</td>
<td class="th">支店営業所</td>
<td class="th">担当者</td>
</tr>
<%
List listClientRecord = (List)request.getAttribute("ClientRecordList");
if (listClientRecord != null) {
	int index = 0;
	for (Iterator iterator = listClientRecord.iterator(); iterator.hasNext();) {
		Client clientRecord = (Client) iterator.next();
		String record = "<tr>";
		record = record + "<td class=\"td\"><input type=\"radio\" name=\"CNT\" value=\""+ index +"\"></td>";
		record = record + "<td class=\"td\">" + clientRecord.getCLIENT_CODE() + "<input type=\"hidden\" id=\"CLIENT_CODE" + index + "\" value=\""+ clientRecord.getCLIENT_CODE() +"\"></td>";
		record = record + "<td class=\"td\">" + CodeUtil.getClientType(clientRecord.getCLIENT_TYPE()) + "</td>";
		record = record + "<td class=\"td\">" + CodeUtil.getCredit(clientRecord.getCREDIT()) + "</td>";
		record = record + "<td class=\"td\">" + clientRecord.getCOUNTRY() + "</td>";
		record = record + "<td class=\"td\">" + clientRecord.getSEQ() + "</td>";
		String comanyOffice = clientRecord.getCOMPANY() + " " + clientRecord.getOFFICE();
		record = record + "<td class=\"td\">" + clientRecord.getCOMPANY() + "<input type=\"hidden\" id=\"COMPANY_OFFICE" + index + "\" value=\""+ comanyOffice.trim() + "\"></td>";
		record = record + "<td class=\"td\">" + clientRecord.getOFFICE() + "</td>";
		record = record + "<td class=\"td\">" + clientRecord.getNAME() + "</td>";
	  record = record + "</tr>";
	  out.println(record);
		index++;
	}
}
%>
</table>
</div>
</form>
</div>
</body>
</html>