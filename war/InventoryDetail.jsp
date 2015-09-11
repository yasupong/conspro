<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<%
	// 在庫データ取得
	InventoryRecord inventoryRecord = (InventoryRecord)request.getAttribute("InventoryRecord");

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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>在庫詳細</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
</head>
<body>
<div id="page">
<div><h1>在庫詳細</h1></div>
<div>&nbsp;</div>
<div>
<input type="button" value="戻る" onclick="history.back();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td class="th">サムネイル</td>
<td class="td"><img src="GetPicture?EDITID=<%= inventoryRecord.getDATE() %>"width="160" height="120"></td>
</tr>
<tr>
<td class="th">分類</td>
<td class="td"><%= CodeUtil.getTypeJa(inventoryRecord.getTYPE()) %></td>
</tr>
<tr>
<td class="th">型式/MODEL</td>
<td class="td"><%= inventoryRecord.getNAME() %></td>
</tr>
<tr>
<td class="th">メーカー/MANUFACTURER</td>
<td class="td"><%= inventoryRecord.getMANUFACTURER() %></td>
</tr>
<tr>
<td class="th">年式/YEAR</td>
<td class="td"><%= inventoryRecord.getYEAR() %></td>
</tr>
<tr>
<td class="th">号機/SERIAL</td>
<td class="td"><%= inventoryRecord.getSERIALNO() %></td>
</tr>
<tr>
<td class="th">稼働時間/HOUR METER</td>
<td class="td" align="right"><%= inventoryRecord.getHOURS() %></td>
</tr>
<tr>
<td class="th">DESCRIPTION</td>
<td class="td"><%= inventoryRecord.getOTHER() %></td>
</tr>
<tr>
<td class="th">詳細</td>
<td class="td"><%= inventoryRecord.getOTHER_JA() %></td>
</tr>
<tr>
<td class="th">程度/CONDITION RANK</td>
<td class="td"><%= inventoryRecord.getCONDITION() %></td>
</tr>
<tr>
<td class="th">表示価格/LIST PRICE</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPRICE()) %></td>
</tr>
<tr>
<td class="th">業販価格</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getWHOL_PRICE()) %></td>
</tr>
<tr>
<td class="th">写真/PHOTO</td>
<td class="td"><a href="<%= inventoryRecord.getPIC_URL() %>" target="_blank"><%= inventoryRecord.getPIC_URL() %></a></td>
</tr>
<tr>
<td class="th">仕入担当</td>
<td class="td"><%= inventoryRecord.getACCOUNT() %></td>
</tr>
<tr>
<td class="th">発注日</td>
<td class="td"><%= inventoryRecord.getORDER_DATE() %></td>
</tr>
<tr>
<td class="th">WEB表示</td>
<td class="td"><%= CodeUtil.getIsDisp(inventoryRecord.getWEB_DISP()) %></td>
</tr>
<tr>
<td class="th">WEB表示日時</td>
<td class="td"><%= CommonUtil.nullConv(inventoryRecord.getWEB_DISP_DATE()) %></td>
</tr>
<tr>
<td class="th">仕入先</td>
<td class="td"><%= inventoryRecord.getSELLER() %></td>
</tr>
<tr>
<td class="th">仕入価格</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_PRICE()) %></td>
</tr>
<tr>
<td class="th">仕入運賃</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_TRANS_COST()) %></td>
</tr>
<tr>
<td class="th">部品代</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPARTS_COST()) %></td>
</tr>
<tr>
<td class="th">整備費</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getMAINTENANCE_COST()) %></td>
</tr>
<tr>
<td class="th">仕入外注費</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_OUT_ORDER_COST()) %></td>
</tr>
<tr>
<td class="th">仕入原価</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_COST_PRICE()) %></td>
</tr>
<tr>
<td class="th">販売運賃</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_TRANCE_COST()) %></td>
</tr>
<tr>
<td class="th">船積費用</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSHIP_COST()) %></td>
</tr>
<tr>
<td class="th">販売外注費</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_OUT_ORDER_COST()) %></td>
</tr>
<tr>
<td class="th">保険料</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getINS_COST()) %></td>
</tr>
<tr>
<td class="th">フレイト</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getFREIGHT_COST()) %></td>
</tr>
<tr>
<td class="th">販売原価</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_COST_PRICE()) %></td>
</tr>
<tr>
<td class="th">販売価格</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_PRICE()) %></td>
</tr>
<tr>
<td class="th">利益</td>
<td class="td" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPROFIT()) %></td>
</tr>
<tr>
<td class="th">販売先</td>
<td class="td"><%= inventoryRecord.getBUYER() %></td>
</tr>
<tr>
<td class="th">仕入代金支払日</td>
<td class="td"><%= inventoryRecord.getORDER_PAY_DATE() %></td>
</tr>
<tr>
<td class="th">売上入金日</td>
<td class="td"><%= inventoryRecord.getSELL_PAY_DATE() %></td>
</tr>
<tr>
<td class="th">売上月</td>
<td class="td"><%= inventoryRecord.getSELL_MONTH() %></td>
</tr>
<tr>
<td class="th">在庫メモ</td>
<td class="td"><%= inventoryRecord.getMEMO() %></td>
</tr>
</table>
</div>
</form>
</div>
</body>
</html>