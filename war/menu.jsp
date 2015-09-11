<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.util.*" %>
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
	String authCode = (String)(request.getSession()).getAttribute("AUTH_CODE");
	String accName = (String)(request.getSession()).getAttribute("NAME");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>CONSPRO メニュー<%= Const.ENV_NAME %></title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<div align="center" id="menuhead">CONSPRO メニュー<%= Const.ENV_NAME %></div>
<div>&nbsp;</div>
<div align="center" id="menuhead"><%= accName %>さん（権限レベル：<%= CodeUtil.getAuthName(authCode) %>）</div>
<div>&nbsp;</div>
<div align="center">
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="100%">
	<tr>
		<td colspan="2" class="th" id="menucat"><center>業務メニュー</center></td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="RegistInventory.jsp?ACCOUNT=<%=account %>" target="reginv">在庫登録</a></td>
		<td class="td">在庫を新規登録します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryList?ACCOUNT=<%=account %>&MENU=1" target="invlist1">在庫一覧</a></td>
		<td class="td">在庫の一覧を参照します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetOldInventoryList?ACCOUNT=<%=account %>&MENU=1" target="invlist2">締め在庫一覧</a></td>
		<td class="td">締め在庫の一覧を参照します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryHistoryList?ACCOUNT=<%=account %>" target="invlist3">在庫削除履歴一覧</a></td>
		<td class="td">在庫の削除履歴一覧を参照します</td>
	</tr>
<%
// 管理者権限・一般権限のみ表示
if ("3".equals(authCode) || "1".equals(authCode)) {
%>
	<tr>
		<td class="th" id="menu"><a href="GetEsateiAllList?ACCOUNT=<%=account %>" target="esatei">査定受付一覧</a></td>
		<td class="td">投稿された査定受付一覧を参照します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetSignupAllList?ACCOUNT=<%=account %>" target="signup">Sign Up一覧</a></td>
		<td class="td">投稿されたSign Up一覧を参照します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="LoadExcelForSellInv">販売用在庫一覧出力</a></td>
		<td class="td">販売用在庫一覧を出力します</td>
	</tr>
<%
}
%>
<%
// 管理者権限・経理権限のみ表示
if ("3".equals(authCode) || "2".equals(authCode)) {
%>
	<tr>
		<td class="th" id="menu"><a href="LoadExcelForInvCount">棚卸在庫一覧出力</a></td>
		<td class="td">棚卸在庫一覧を出力します</td>
	</tr>
<%
}
%>
<%
// 管理者権限のみ表示
if ("3".equals(authCode)) {
%>
	<tr>
		<td class="th" id="menu"><a href="RegistEmployee.jsp?ACCOUNT=<%=account %>" target="userlist">ユーザー情報登録</a></td>
		<td class="td">システム利用ユーザーを登録します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetEmployeeAllList?ACCOUNT=<%=account %>" target="userlist">ユーザー一覧</a></td>
		<td class="td">システム利用ユーザー一覧を参照します</td>
	</tr>
<%
}
%>
	<tr>
		<td colspan="2" class="th" id="menucat"><center>WEB公開参照</center></td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryListSortByDate?page=2" target="latest">最新在庫情報</a></td>
		<td class="td">最新在庫情報８件を確認します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryList?page=1" target="eng">在庫一覧（英語）</a></td>
		<td class="td">英語に表示する在庫一覧を確認します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryList?page=2" target="ja">在庫一覧（日本語）</a></td>
		<td class="td">日本語に表示する在庫一覧を確認します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryAllList?page=1" target="alleng">全在庫一覧（英語）</a></td>
		<td class="td">英語に表示する在庫全一覧を確認します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="GetInventoryAllList?page=2" target="allja">全在庫一覧（日本語）</a></td>
		<td class="td">日本語に表示する在庫全一覧を確認します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="CPEsateiRegist.jsp" target="esatei">査定受付</a></td>
		<td class="td">査定受付を表示します</td>
	</tr>
	<tr>
		<td class="th" id="menu"><a href="CPSignupRegist.jsp" target="esatei">SIGN UP</a></td>
		<td class="td">SIGN UPを表示します</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
