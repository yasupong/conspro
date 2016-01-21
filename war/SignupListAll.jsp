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
<th nowrap class="th">DATE</td>
<th nowrap class="th">NAME</td>
<th nowrap class="th">YOU ARE</td>
<th nowrap class="th">COMPANY</td>
<th nowrap class="th">STREET</td>
<th nowrap class="th">CITY</td>
<th nowrap class="th">STATE</td>
<th nowrap class="th">COUNTRY</td>
<th nowrap class="th">ZIP</td>
<th nowrap class="th">MAIL</td>
<th nowrap class="th">TEL</td>
<th nowrap class="th">FAX</td>
<th nowrap class="th">MAIL</td>
<th nowrap class="th">STOCK LIST</td>
<th nowrap class="th">COMMENT</td>
</tr>
<%
List listSignupRecord = (List)request.getAttribute("listSignupList");
if (listSignupRecord != null) {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	for (Iterator iterator = listSignupRecord.iterator(); iterator.hasNext();) {
		Signup signupRecord = (Signup) iterator.next();
	  Date date = new Date(Long.parseLong(signupRecord.getDATE()));
		String record = "<tr>";
		record = record + "<td nowrap class=\"td\"><input type=\"radio\" name=\"EDITID\" value=\""+ signupRecord.getDATE() +"\"></td>";
		record = record + "<td class=\"td\">" + sdf.format(date)  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getNAME() + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getYOUARE()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getCOMPANY()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getSTREET()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getCITY()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getSTATE()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getCOUNTRY()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getZIP()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getMAIL()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getTEL()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getFAX()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getMAIL()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getRECEIVE()  + "</td>";
		record = record + "<td class=\"td\">" + signupRecord.getCOMMENT()  + "</td>";
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