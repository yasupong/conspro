<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<%
	// 在庫データ取得
	Employee employeeRecord = (Employee)request.getAttribute("EmployeeRecord");

	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>ユーザー情報更新</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj) {
	  if (obj.PASSWORD.value != obj.PASSWORD2.value) {
			alert('パスワードが一致しません。再度入力してください');
			return;
		}
		obj.submit();
	}

	// 初期化
	function initData() {
		document.empForm.AUTH_CODE.value = document.empForm.LOADAUTH_CODE.value;
	}
-->
</script>
</head>
<body onload="initData()">
<div id="page">
<form action="EditEmployee?ACCOUNT=<%= account %>" name="empForm" method="POST">
<div><h1>ユーザー情報更新</h1></div>
<div>
<input type="button" value="戻る" onclick="history.back();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td class="th">アカウント</td>
<td class="td"><%= employeeRecord.getACCOUNT() %></td>
</tr>
<tr>
<td class="th">パスワード</td>
<td class="td"><input type="PASSWORD" name="PASSWORD" value="<%= employeeRecord.getPASSWORD() %>"></td>
</tr>
<tr>
<td class="th">パスワード（確認用）</td>
<td class="td"><input type="PASSWORD" name="PASSWORD2" value="<%= employeeRecord.getPASSWORD() %>"></td>
</tr>
<tr>
<td class="th">ユーザー名</td>
<td class="td"><input type="text" name="NAME" value="<%= employeeRecord.getNAME() %>"></td>
</tr>
<tr>
<td class="th">権限</td>
<td class="td">
<input type="hidden" name="LOADAUTH_CODE" value="<%= employeeRecord.getAUTH_CODE() %>">
<select name="AUTH_CODE">
<%= Const.COMBO_AUTH_CODE %>
</select>
</td>
</tr>
</table>
<div>
<input type="hidden" name="EDITID" value="<%= employeeRecord.getACCOUNT() %>">
<input type="hidden" name="type" value="1">
<input type="button" value="更新" onclick="callServer(this.form)">
</div>
</div>
</form>
</div>
</body>
</html>