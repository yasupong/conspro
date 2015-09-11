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
<title>ユーザー一覧</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<form action="EditEmployee"  method="POST">
<div><h1>ユーザー一覧</h1></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<div>
<input type="hidden" name="type">
<input type="hidden" name="ACCOUNT" value="<%= account %>">
<input type="button" name="update" value="ユーザー情報更新" onclick="callServer(this.form,0);">
<input type="button" name="delete" value="ユーザー削除" onclick="callServer(this.form,2);">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<div>
<tr>
<td class="th">選択</td>
<td class="th">アカウント</td>
<td class="th">ユーザー名</td>
<td class="th">権限</td>
</tr>
<%
List listEmployeeRecord = (List)request.getAttribute("EmployeeRecordList");
if (listEmployeeRecord != null) {
	for (Iterator iterator = listEmployeeRecord.iterator(); iterator.hasNext();) {
		Employee employeeRecord = (Employee) iterator.next();
		String record = "<tr>";
		record = record + "<td class=\"td\"><input type=\"radio\" name=\"EDITID\" value=\""+ employeeRecord.getACCOUNT() +"\"></td>";
		record = record + "<td class=\"td\">" + employeeRecord.getACCOUNT()  + "</td>";
		record = record + "<td class=\"td\">" + employeeRecord.getNAME()  + "</td>";
		record = record + "<td class=\"td\">" + CodeUtil.getAuthName(employeeRecord.getAUTH_CODE())  + "</td>";
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