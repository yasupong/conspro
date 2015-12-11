<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>顧客情報登録</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj) {

		if(obj.COUNTRY.value==''){
			alert("「国番号」を入力してください");
			return;
		}

		obj.submit();
	}
-->
</script>
</head>
<body>
<div id="page">
<form action="RegistClient" method="POST">
<div><h1>顧客情報登録</h1></div>
<div id="msg"><%= CommonUtil.nullConv(msg) %></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td class="th">業種</td>
<td class="td">
<select name="CLIENT_TYPE">
<%= Const.COMBO_CLIENT_TYPE %>
</select>
</td>
</tr>
<tr>
<td class="th">与信管理</td>
<td class="td">
<select name="CREDIT">
<%= Const.COMBO_CREDIT %>
</select>
</td>
</tr>
<tr>
<td class="th">国番号</td>
<td class="td"><input type="text" name="COUNTRY" value=""></td>
</tr>
<tr>
<td class="th">住所</td>
<td class="td"><input type="text" name="ADDRESS" value="" size="100"></td>
</tr>
<tr>
<td class="th">郵便番号</td>
<td class="td"><input type="text" name="ZIP" value=""></td>
</tr>
<tr>
<td class="th">電話番号</td>
<td class="td"><input type="text" name="TEL" value=""></td>
</tr>
<tr>
<td class="th">FAX番号</td>
<td class="td"><input type="text" name="FAX" value=""></td>
</tr>
<tr>
<td class="th">メール</td>
<td class="td"><input type="text" name="MAIL" value=""></td>
</tr>
<tr>
<td class="th">会社名</td>
<td class="td"><input type="text" name="COMPANY" value="" size="100"></td>
</tr>
<tr>
<td class="th">支店営業所名</td>
<td class="td"><input type="text" name="OFFICE" value="" size="100"></td>
</tr>
<tr>
<td class="th">担当者</td>
<td class="td"><input type="text" name="NAME" value="" size="100"></td>
</tr>
<tr>
<td class="th">備考</td>
<td class="td"><textarea name="COMMENT" cols="50" rows="5" maxlength="256"></textarea></td>
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