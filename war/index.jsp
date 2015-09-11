<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>CONSPRO ログイン<%= Const.ENV_NAME %></title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<form action="Login"  method="POST">
<div id="page">
<!--<div align="center"><img src="img/logo.png"></div>-->
<div>&nbsp;</div>
<div align="center">CONSPRO ログイン<%= Const.ENV_NAME %></div>
<div>&nbsp;</div>
<div align="center">
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td class="th">アカウント</td>
<td><input type="text" name="ACCOUNT"></td>
</tr>
<tr>
<td class="th">パスワード</td>
<td><input type="password" name="PASSWORD"></td>
</tr>
</table>
</div>
<div align="center"><input type="submit" name="LOGIN" value="ログイン"></div>
</div>
</form>
</body>
</html>