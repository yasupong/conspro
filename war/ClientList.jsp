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

	String msg = (String)request.getSession().getAttribute("MSG");
	request.getSession().setAttribute("MSG", "");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
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

	function search(obj) {
		obj.target='_self';
		obj.action='SeachClientList';
		obj.submit();
	}

	function createExcel(obj) {
		obj.target='_self';
		obj.action='LoadExcelClientAll';
		obj.submit();
	}
-->
</script>
<title>顧客一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="EditClient"  method="POST">
<div><h1>顧客一覧</h1></div>
<div id="msg"><%= CommonUtil.nullConv(msg) %></div>
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
<input type="hidden" name="type">
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<input type="button" name="update" value="顧客情報更新" onclick="callServer(this.form,0);">
<input type="button" name="delete" value="顧客削除" onclick="callServer(this.form,2);">
<input type="button" name="createex" value="EXCEL出力" onclick="createExcel(this.form);">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" class="t-line">
<div>
<tr>
<th nowrap class="th">選択</td>
<th nowrap class="th">顧客コード</td>
<th nowrap class="th">業種</td>
<th nowrap class="th">与信管理</td>
<th nowrap class="th">国番号</td>
<th nowrap class="th">顧客番号</td>
<th nowrap class="th">会社名</td>
<th nowrap class="th">支店営業所</td>
<th nowrap class="th">担当者</td>
<th nowrap class="th">住所</td>
<th nowrap class="th">郵便番号</td>
<th nowrap class="th">電話番号</td>
<th nowrap class="th">FAX番号</td>
<th nowrap class="th">メール</td>
<th nowrap class="th">備考</td>
</tr>
<%
List listClientRecord = (List)request.getAttribute("ClientRecordList");
if (listClientRecord != null) {
	for (Iterator iterator = listClientRecord.iterator(); iterator.hasNext();) {
		Client clientRecord = (Client) iterator.next();
		String record = "<tr>";
		record = record + "<td class=\"td\"><input type=\"radio\" name=\"EDITID\" value=\""+ clientRecord.getCLIENT_CODE() +"\"></td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getCLIENT_CODE() + "</td>";
		record = record + "<td nowrap class=\"td\">" + CodeUtil.getClientType(clientRecord.getCLIENT_TYPE()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + CodeUtil.getCredit(clientRecord.getCREDIT()) + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getCOUNTRY() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getSEQ() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getCOMPANY() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getOFFICE() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getNAME() + "</td>";
		record = record + "<td class=\"td\">" + clientRecord.getADDRESS() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getZIP() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getTEL() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getFAX() + "</td>";
		record = record + "<td nowrap class=\"td\">" + clientRecord.getMAIL() + "</td>";
		record = record + "<td class=\"td\">" + clientRecord.getCOMMENT() + "</td>";
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