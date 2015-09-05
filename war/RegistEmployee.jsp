<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	// 認証チェック
	String account = request.getParameter("ACCOUNT");
	if (account == null || account.length() == 0) {
		response.sendRedirect("LoginErr.jsp");
	}

	if (!account.equals(request.getSession().getAttribute("ACCOUNT"))) {
		response.sendRedirect("LoginErr.jsp");
	}
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>ユーザー情報登録</title>
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
-->
</script>
</head>
<body>
<div id="page">
<form action="RegistEmployee"  method="POST" >
<div><h1>ユーザー情報登録</h1></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td bgcolor="#ffd700">アカウント</td>
<td bgcolor="#e6e6e6"><input type="text" name="ACCOUNT" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">パスワード</td>
<td bgcolor="#e6e6e6"><input type="PASSWORD" name="PASSWORD" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">パスワード（確認用）</td>
<td bgcolor="#e6e6e6"><input type="PASSWORD" name="PASSWORD2" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">ユーザー名</td>
<td bgcolor="#e6e6e6"><input type="text" name="NAME" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">権限コード</td>
<td bgcolor="#e6e6e6">
<select name="AUTH_CODE">
	<option value="1">1：一般</option>
	<option value="2">2：経理</option>
	<option value="3">3：管理</option>
</select>
</td>
</tr>
</table>
<div>
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<input type="button" value="登録" onclick="callServer(this.form)">
</div>
</form>
</div>
</body>
</html>