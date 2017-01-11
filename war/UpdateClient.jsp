<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<%
	// 顧客データ取得
	Client clientRecord = (Client)request.getAttribute("ClientRecord");

	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");

	String msg = (String)request.getSession().getAttribute("MSG");
	request.getSession().setAttribute("MSG", "");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>顧客情報更新</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj) {
		obj.submit();
	}
-->
</script>
</head>
<body>
<div id="page">
<form action="EditClient?ACCOUNT=<%= account %>" name="clientForm" method="POST">
<div><h1>顧客情報更新</h1></div>
<div id="msg"><%= CommonUtil.nullConv(msg) %></div>
<div>
<input type="button" value="戻る" onclick="location.href='ClientList.jsp?ACCOUNT=<%=account %>'">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td class="th">顧客コード</td>
<td class="td"><%= clientRecord.getCLIENT_CODE() %></td>
</tr>
<tr>
<td class="th">業種</td>
<td class="td"><%= CodeUtil.getClientType(clientRecord.getCLIENT_TYPE()) %></td>
</tr>
<tr>
<td class="th">与信管理</td>
<td class="td"><%= CodeUtil.getCredit(clientRecord.getCREDIT()) %></td>
</tr>
<tr>
<td class="th">国番号</td>
<td class="td"><%= clientRecord.getCOUNTRY() %></td>
</tr>
<tr>
<td class="th">顧客番号</td>
<td class="td"><%= clientRecord.getSEQ() %></td>
</tr>
<tr>
<td class="th">住所</td>
<td class="td"><input type="text" name="ADDRESS" value="<%= clientRecord.getADDRESS() %>" size="100"></td>
</tr>
<tr>
<td class="th">郵便番号</td>
<td class="td"><input type="text" name="ZIP" value="<%= clientRecord.getZIP() %>"></td>
</tr>
<tr>
<td class="th">電話番号</td>
<td class="td"><input type="text" name="TEL" value="<%= clientRecord.getTEL() %>"></td>
</tr>
<tr>
<td class="th">FAX番号</td>
<td class="td"><input type="text" name="FAX" value="<%= clientRecord.getFAX() %>"></td>
</tr>
<tr>
<td class="th">メール</td>
<td class="td"><input type="text" name="MAIL" value="<%= clientRecord.getMAIL() %>"></td>
</tr>
<tr>
<td class="th">会社名</td>
<td class="td"><input type="text" name="COMPANY" value="<%= clientRecord.getCOMPANY() %>" size="100"></td>
</tr>
<tr>
<td class="th">支店営業所名</td>
<td class="td"><input type="text" name="OFFICE" value="<%= clientRecord.getOFFICE() %>" size="100"></td>
</tr>
<tr>
<td class="th">担当者</td>
<td class="td"><input type="text" name="NAME" value="<%= clientRecord.getNAME() %>" size="100"></td>
</tr>
<tr>
<td class="th">備考</td>
<td class="td"><textarea name="COMMENT" cols="50" rows="5" maxlength="256"><%= clientRecord.getCOMMENT() %></textarea></td>
</tr>
</table>
<div>
<input type="hidden" name="EDITID" value="<%= clientRecord.getCLIENT_CODE() %>">
<input type="hidden" name="type" value="1">
<input type="button" value="更新" onclick="callServer(this.form)">
</div>
</div>
</form>
</div>
</body>
</html>