<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.storage.*" %>
<%@ page import="conspro.util.*" %>
<%
	// 在庫データ取得
	InventoryRecord inventoryRecord = (InventoryRecord)request.getAttribute("InventoryRecord");

	// 認証チェック
	AuthUtil.isLogin(request, response);

	String account = request.getParameter("ACCOUNT");
	String authCode = (String)(request.getSession()).getAttribute("AUTH_CODE");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>在庫更新</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj) {
	  if (isNaN(obj.PRICE.value)||
				isNaN(obj.ORDER_PRICE.value)||
				isNaN(obj.ORDER_TRANS_COST.value)||
				isNaN(obj.PARTS_COST.value)||
				isNaN(obj.MAINTENANCE_COST.value)||
				isNaN(obj.ORDER_OUT_ORDER_COST.value)||
				isNaN(obj.ORDER_COST_PRICE.value)||
				isNaN(obj.SELL_TRANCE_COST.value)||
				isNaN(obj.SHIP_COST.value)||
				isNaN(obj.SELL_OUT_ORDER_COST.value)||
				isNaN(obj.INS_COST.value)||
				isNaN(obj.FREIGHT_COST.value)||
				isNaN(obj.SELL_COST_PRICE.value)||
				isNaN(obj.SELL_PRICE.value)||
				isNaN(obj.WHOL_PRICE.value)||
				isNaN(obj.PROFIT.value)) {
			alert('金額項目に数字以外の文字が入力されています。入力を見直してください');
			return;
		}
		if (!ckDate(obj.ORDER_DATE.value) || !ckDate(obj.ORDER_PAY_DATE.value) || !ckDate(obj.SELL_PAY_DATE.value)) {
			alert('日付の入力が不正です。入力を見直してください');
			return;
		}
		if (!ckYM(obj.SELL_MONTH.value)) {
			alert('年月の入力が不正です。入力を見直してください');
			return;
		}
		obj.submit();
	}

	// 計算ロジック
	function autoSum(obj) {
		obj.ORDER_COST_PRICE.value = Number(obj.ORDER_PRICE.value) + Number(obj.ORDER_TRANS_COST.value) + Number(obj.PARTS_COST.value) + Number(obj.MAINTENANCE_COST.value) + Number(obj.ORDER_OUT_ORDER_COST.value);
		obj.SELL_COST_PRICE.value = Number(obj.SELL_TRANCE_COST.value) + Number(obj.SHIP_COST.value) + Number(obj.SELL_OUT_ORDER_COST.value) + Number(obj.INS_COST.value) + Number(obj.FREIGHT_COST.value) + Number(obj.ORDER_COST_PRICE.value);
		obj.PROFIT.value = Number(obj.SELL_PRICE.value) - Number(obj.SELL_COST_PRICE.value);
	}

	// 初期化
	function initData() {
		document.updateForm.MANUFACTURER.value = document.updateForm.LOADMANUFACTURER.value;
		document.updateForm.TYPE.value = document.updateForm.LOADTYPE.value;
		document.updateForm.CONDITION.value = document.updateForm.LOADCONDITION.value;
		document.updateForm.WEB_DISP.value = document.updateForm.LOADWEB_DISP.value;
	}

	// 日付チェック
	function ckDate(datestr) {
		if (datestr == "") {
			return true;
		}
		if(!datestr.match(/^\d{4}\/\d{2}\/\d{2}$/)){
			return false;
		}
		return true;
	}

	// 年月チェック
	function ckYM(datestr) {
		if (datestr == "") {
			return true;
		}
		if(!datestr.match(/^\d{4}\/\d{2}$/)){
			return false;
		}
		return true;
	}
-->
</script>
</head>
<body onload="initData()">
<div id="page">
<form action="EditInventory?ACCOUNT=<%= account %>" name="updateForm" method="POST">
<div><h1>在庫更新</h1></div>
<div>
<input type="button" value="戻る" onclick="history.back();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td colspan="2" class="th" id="editmenu">WEB表示項目：ホームページに表示される項目です。外部に公開される情報です。</td>
</tr>
<tr>
<td class="th">分類</td>
<td class="td">
<input type="hidden" name="LOADTYPE" value="<%= inventoryRecord.getTYPE() %>" size="1">
<select name="TYPE">
<%= Const.COMBO_TYPE %>
</select>
</td>
</tr>
<tr>
<td class="th">型式/MODEL</td>
<td class="td"><input type="text" name="NAME" value="<%= inventoryRecord.getNAME() %>" size="50"></td>
</tr>
<tr>
<td class="th">メーカー/MANUFACTURER</td>
<td class="td">
<input type="hidden" name="LOADMANUFACTURER" value="<%= inventoryRecord.getMANUFACTURER() %>">
<select name="MANUFACTURER">
<%= Const.COMBO_MANUFACTURER %>
</select>
</td>
</tr>
<tr>
<td class="th">年式/YEAR</td>
<td class="td"><input type="text" name="YEAR" value="<%= inventoryRecord.getYEAR() %>"></td>
</tr>
<tr>
<td class="th">号機/SERIAL</td>
<td class="td"><input type="text" name="SERIALNO" value="<%= inventoryRecord.getSERIALNO() %>"></td>
</tr>
<tr>
<td class="th">稼働時間/HOUR METER</td>
<td class="td"><input type="text" name="HOURS" value="<%= inventoryRecord.getHOURS() %>"></td>
</tr>
<tr>
<td class="th">DESCRIPTION</td>
<td class="td"><input type="text" name="OTHER" value="<%= inventoryRecord.getOTHER() %>" size="100"></td>
</tr>
<tr>
<td class="th">詳細</td>
<td class="td"><input type="text" name="OTHER_JA" value="<%= inventoryRecord.getOTHER_JA() %>" size="100"></td>
</tr>
<tr>
<td class="th">程度/CONDITION RANK</td>
<td class="td">
<input type="hidden" name="LOADCONDITION" value="<%= inventoryRecord.getCONDITION() %>" size="1">
<select name="CONDITION">
<%= Const.COMBO_CONDITION %>
</select>
</td>
</tr>
<tr>
<td class="th">表示価格/LIST PRICE</td>
<td class="td"><input type="text" name="PRICE" value="<%= inventoryRecord.getPRICE() %>" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">写真/PHOTO</td>
<td class="td"><input type="text" name="PIC_URL" value="<%= inventoryRecord.getPIC_URL() %>" size="100">（入力形式:アドレス）</td>
</tr>
<tr>
<td colspan="2" class="th" id="editmenu">内部業務項目：内部業務で利用する項目です。非公開情報です。</td>
</tr>
</tr>
<tr>
<td class="th">仕入担当</td>
<td class="td"><input type="text" name="INACCOUNT" value="<%= inventoryRecord.getACCOUNT() %>"></td>
</tr>
<tr>
<td class="th">発注日</td>
<td class="td"><input type="text" name="ORDER_DATE" value="<%= inventoryRecord.getORDER_DATE() %>">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td class="th">WEB表示</td>
<td class="td">
<input type="hidden" name="LOADWEB_DISP" value="<%= inventoryRecord.getWEB_DISP() %>" size="1">
<select name="WEB_DISP">
<%= Const.COMBO_WEB_DISP %>
</select>
</td>
</tr>
<tr>
<td class="th">仕入先</td>
<td class="td"><input type="text" name="SELLER" value="<%= inventoryRecord.getSELLER() %>" size="100"></td>
</tr>
<tr>
<td class="th">仕入価格</td>
<td class="td"><input type="text" name="ORDER_PRICE" value="<%= inventoryRecord.getORDER_PRICE() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">仕入運賃</td>
<td class="td"><input type="text" name="ORDER_TRANS_COST" value="<%= inventoryRecord.getORDER_TRANS_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">部品代</td>
<td class="td"><input type="text" name="PARTS_COST" value="<%= inventoryRecord.getPARTS_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">整備費</td>
<td class="td"><input type="text" name="MAINTENANCE_COST" value="<%= inventoryRecord.getMAINTENANCE_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">仕入外注費</td>
<td class="td"><input type="text" name="ORDER_OUT_ORDER_COST" value="<%= inventoryRecord.getORDER_OUT_ORDER_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">仕入原価</td>
<td class="td"><input type="text" name="ORDER_COST_PRICE" value="<%= inventoryRecord.getORDER_COST_PRICE() %>" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">販売運賃</td>
<td class="td"><input type="text" name="SELL_TRANCE_COST" value="<%= inventoryRecord.getSELL_TRANCE_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">船積費用</td>
<td class="td"><input type="text" name="SHIP_COST" value="<%= inventoryRecord.getSHIP_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">販売外注費</td>
<td class="td"><input type="text" name="SELL_OUT_ORDER_COST" value="<%= inventoryRecord.getSELL_OUT_ORDER_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">保険料</td>
<td class="td"><input type="text" name="INS_COST" value="<%= inventoryRecord.getINS_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">フレイト</td>
<td class="td"><input type="text" name="FREIGHT_COST" value="<%= inventoryRecord.getFREIGHT_COST() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">販売原価</td>
<td class="td"><input type="text" name="SELL_COST_PRICE" value="<%= inventoryRecord.getSELL_COST_PRICE() %>" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">販売価格</td>
<td class="td"><input type="text" name="SELL_PRICE" value="<%= inventoryRecord.getSELL_PRICE() %>" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">利益</td>
<td class="td"><input type="text" name="PROFIT" value="<%= inventoryRecord.getPROFIT() %>" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td class="th">販売先</td>
<td class="td"><input type="text" name="BUYER" value="<%= inventoryRecord.getBUYER() %>" size="100"></td>
</tr>
<tr>
<td class="th">業販価格</td>
<td class="td"><input type="text" name="WHOL_PRICE" value="<%= inventoryRecord.getWHOL_PRICE() %>" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<%
// 経理・管理者権限のみ表示
if (Const.AUTH_ADMIN.equals(authCode) || Const.AUTH_ACCT.equals(authCode)) {
%>
<tr>
<td class="th">仕入代金支払日</td>
<td class="td"><input type="text" name="ORDER_PAY_DATE" value="<%= inventoryRecord.getORDER_PAY_DATE() %>">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td class="th">売上入金日</td>
<td class="td"><input type="text" name="SELL_PAY_DATE" value="<%= inventoryRecord.getSELL_PAY_DATE() %>">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td class="th">売上月</td>
<td class="td"><input type="text" name="SELL_MONTH" value="<%= inventoryRecord.getSELL_MONTH() %>">（入力形式:YYYY/MM）</td>
</tr>
<tr>
<%
} else {
%>
<input type="hidden" name="ORDER_PAY_DATE" value="<%= inventoryRecord.getORDER_PAY_DATE() %>">
<input type="hidden" name="SELL_PAY_DATE" value="<%= inventoryRecord.getSELL_PAY_DATE() %>">
<input type="hidden" name="SELL_MONTH" value="<%= inventoryRecord.getSELL_MONTH() %>">
<%
}
%>
<tr>
<td class="th">在庫メモ</td>
<td class="td"><textarea name="MEMO" cols="50" rows="5" maxlength="256"><%= inventoryRecord.getMEMO() %></textarea></td>
</tr>
</table>
<div>
<input type="hidden" name="EDITID" value="<%= inventoryRecord.getDATE() %>">
<input type="hidden" name="type" value="1">
<input type="button" value="更新" onclick="callServer(this.form)">
</div>
</div>
</form>
</div>
</body>
</html>