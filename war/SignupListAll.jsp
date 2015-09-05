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
<title>Sign Up一覧</title>
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
<form action="EditSignup"  method="POST">
<div><h1>Sign Up一覧</h1></div>
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
<td nowrap bgcolor="#ffd700">DATE</td>
<td nowrap bgcolor="#ffd700">NAME</td>
<td nowrap bgcolor="#ffd700">YOU ARE</td>
<td nowrap bgcolor="#ffd700">COMPANY</td>
<td nowrap bgcolor="#ffd700">STREET</td>
<td nowrap bgcolor="#ffd700">CITY</td>
<td nowrap bgcolor="#ffd700">STATE</td>
<td nowrap bgcolor="#ffd700">COUNTRY</td>
<td nowrap bgcolor="#ffd700">ZIP</td>
<td nowrap bgcolor="#ffd700">MAIL</td>
<td nowrap bgcolor="#ffd700">TEL</td>
<td nowrap bgcolor="#ffd700">FAX</td>
<td nowrap bgcolor="#ffd700">MAIL</td>
<td nowrap bgcolor="#ffd700">STOCK LIST</td>
<td nowrap bgcolor="#ffd700">COMMENT</td>
</tr>
<%
List listSignupRecord = (List)request.getAttribute("listSignupList");
if (listSignupRecord != null) {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	for (Iterator iterator = listSignupRecord.iterator(); iterator.hasNext();) {
		Signup signupRecord = (Signup) iterator.next();
	  Date date = new Date(Long.parseLong(signupRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap bgcolor=\"#e6e6e6\"><input type=\"radio\" name=\"EDITID\" value=\""+ signupRecord.getDATE() +"\"></td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + sdf.format(date)  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getNAME() + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getYOUARE()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getCOMPANY()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getSTREET()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getCITY()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getSTATE()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getCOUNTRY()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getZIP()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getMAIL()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getTEL()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getFAX()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getMAIL()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getRECEIVE()  + "</td>";
		record = record + "<td bgcolor=\"#e6e6e6\">" + signupRecord.getCOMMENT()  + "</td>";
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