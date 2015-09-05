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
<title>在庫結果</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<div align="center">在庫を正常登録しました</div>
<div>&nbsp;</div>
<div align="center"><a href="RegistInventory.jsp?ACCOUNT=<%=account %>">在庫を連続入力する</a></div>
<div align="center"><input type="button" name="close" value="閉じる" onclick="window.close();"></div>
</div>
</body>
</html>
