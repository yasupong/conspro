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
<td bgcolor="#ffd700">サムネイル</td>
<td bgcolor="#e6e6e6"><img src="GetPicture?EDITID=<%= inventoryRecord.getDATE() %>"width="160" height="120"></td>
</tr>
<tr>
<td bgcolor="#ffd700">分類</td>
<td bgcolor="#e6e6e6"><%= CodeUtil.getTypeJa(inventoryRecord.getTYPE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">型式/MODEL</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getNAME() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">メーカー/MANUFACTURER</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getMANUFACTURER() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">年式/YEAR</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getYEAR() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">号機/SERIAL</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getSERIALNO() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">稼働時間/HOUR METER</td>
<td bgcolor="#e6e6e6" align="right"><%= inventoryRecord.getHOURS() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">DESCRIPTION</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getOTHER() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">詳細</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getOTHER_JA() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">程度/CONDITION RANK</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getCONDITION() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">表示価格/LIST PRICE</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">業販価格</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getWHOL_PRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">写真/PHOTO</td>
<td bgcolor="#e6e6e6"><a href="<%= inventoryRecord.getPIC_URL() %>" target="_blank"><%= inventoryRecord.getPIC_URL() %></a></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入担当</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getACCOUNT() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">発注日</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getORDER_DATE() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">WEB表示</td>
<td bgcolor="#e6e6e6"><%= CodeUtil.getIsDisp(inventoryRecord.getWEB_DISP()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">WEB表示日時</td>
<td bgcolor="#e6e6e6"><%= CommonUtil.nullConv(inventoryRecord.getWEB_DISP_DATE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入先</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getSELLER() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入価格</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_PRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入運賃</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_TRANS_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">部品代</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPARTS_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">整備費</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getMAINTENANCE_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入外注費</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_OUT_ORDER_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入原価</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getORDER_COST_PRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">販売運賃</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_TRANCE_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">船積費用</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSHIP_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">販売外注費</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_OUT_ORDER_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">保険料</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getINS_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">フレイト</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getFREIGHT_COST()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">販売原価</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_COST_PRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">販売価格</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getSELL_PRICE()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">利益</td>
<td bgcolor="#e6e6e6" align="right"><%= CommonUtil.moneyFormat(inventoryRecord.getPROFIT()) %></td>
</tr>
<tr>
<td bgcolor="#ffd700">販売先</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getBUYER() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入代金支払日</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getORDER_PAY_DATE() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">売上入金日</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getSELL_PAY_DATE() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">売上月</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getSELL_MONTH() %></td>
</tr>
<tr>
<td bgcolor="#ffd700">在庫メモ</td>
<td bgcolor="#e6e6e6"><%= inventoryRecord.getMEMO() %></td>
</tr>
</table>
</div>
</form>
</div>
</body>
</html>