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
	String authCode = (String)(request.getSession()).getAttribute("AUTH_CODE");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>在庫登録</title>
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
<body>
<div id="page">
<form action="RegistInventory"  method="POST">
<div><h1>在庫登録</h1></div>
<div align="right">
<input type="button" name="close" value="閉じる" onclick="window.close();">
</div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0">
<tr>
<td colspan="2" bgcolor="#ffd700" id="editmenu">WEB表示項目：ホームページに表示される項目です。外部に公開される情報です。</td>
</tr>
<tr>
<td bgcolor="#ffd700">分類</td>
<td bgcolor="#e6e6e6">
<select name="TYPE">
	<option value="1">1:Excavator (under 8 ton) - 油圧ショベル 8t未満</option>
	<option value="2">2:Excavator (10 ton up) - 油圧ショベル 10t以上</option>
	<option value="3">3:Crawler Dozer (Bulldozer) - ブルドーザー</option>
	<option value="4">4:Crawler Loader (Dozer shovel) - ショベルローダー</option>
	<option value="5">5:Wheel Loader (Rubber Tired Loader) - タイヤショベル</option>
	<option value="6">6:Road Equipment - 舗装機械</option>
	<option value="7">7:Crane - クレーン</option>
	<option value="8">8:Crawler Carrier - キャリアダンプ</option>
	<option value="9">9:Attachment - アタッチメント</option>
	<option value="10">10:Parts - 部品</option>
	<option value="11">11:Generator - 発電機</option>
	<option value="12">12:Air Compressor - エアーコンプレッサー</option>
	<option value="13">13:Welder - 溶接機</option>
	<option value="14">14:Truck - トラック</option>
	<option value="99">99:Other - その他</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#ffd700">メーカー/MANUFACTURER</td>
<td bgcolor="#e6e6e6">
<select name="MANUFACTURER">
	<option value="AIRMAN">AIRMAN</option>
	<option value="BOMAG">BOMAG</option>
	<option value="CAT">CAT</option>
	<option value="DENYO">DENYO</option>
	<option value="DYNAPAC">DYNAPAC</option>
	<option value="FURUKAWA">FURUKAWA</option>
	<option value="HANTA">HANTA</option>
	<option value="HITACHI">HITACHI</option>
	<option value="IHI">IHI</option>
	<option value="KATO">KATO</option>
	<option value="KAWASAKI">KAWASAKI</option>
	<option value="KOBELCO">KOBELCO</option>
	<option value="KOMATSU">KOMATSU</option>
	<option value="KUBOTA">KUBOTA</option>
	<option value="MEIWA">MEIWA</option>
	<option value="MIKASA">MIKASA</option>
	<option value="MITSUBISHI">MITSUBISHI</option>
	<option value="MOROOKA">MOROOKA</option>
	<option value="NISSHA">NISSHA</option>
	<option value="OTHER">OTHER</option>
	<option value="SAKAI">SAKAI</option>
	<option value="SHINDAIWA">SHINDAIWA</option>
	<option value="SUMITOMO">SUMITOMO</option>
	<option value="TACOM">TACOM</option>
	<option value="TADANO">TADANO</option>
	<option value="TCM">TCM</option>
	<option value="YANMAR">YANMAR</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#ffd700">型式/MODEL</td>
<td bgcolor="#e6e6e6"><input type="text" name="NAME" value="" size="50"></td>
</tr>
<tr>
<td bgcolor="#ffd700">年式/YEAR</td>
<td bgcolor="#e6e6e6"><input type="text" name="YEAR" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">号機/SERIAL</td>
<td bgcolor="#e6e6e6"><input type="text" name="SERIALNO" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">稼働時間/HOUR METER</td>
<td bgcolor="#e6e6e6"><input type="text" name="HOURS" value=""></td>
</tr>
<tr>
<td bgcolor="#ffd700">DESCRIPTION</td>
<td bgcolor="#e6e6e6"><input type="text" name="OTHER" value="" size="100"></td>
</tr>
<tr>
<td bgcolor="#ffd700">詳細</td>
<td bgcolor="#e6e6e6"><input type="text" name="OTHER_JA" value="" size="100"></td>
</tr>
<tr>
<td bgcolor="#ffd700">程度/CONDITION RANK</td>
<td bgcolor="#e6e6e6">
<select name="CONDITION">
	<option value="5">5：新車もしくは、新車に近い状態</option>
	<option value="4">4：高年式・メーターの少ない極上品</option>
	<option value="3.5">3.5：整備済み</option>
	<option value="3">3：現状で使用可能な状態</option>
	<option value="2">2：故障はしてないが、使用するには軽微な修理や整備が必要なもの</option>
	<option value="1">1：故障はしていないが、摩耗が激しく、使用するには相当の修理や整備が必要なもの</option>
	<option value="B">B：エンジンや油圧系統など重要部品が故障しているもの</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#ffd700">表示価格/LIST PRICE</td>
<td bgcolor="#e6e6e6"><input type="text" name="PRICE" value="0" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">写真/PHOTO</td>
<td bgcolor="#e6e6e6"><input type="text" name="PIC_URL" value="" size="100">（入力形式:アドレス）</td>
</tr>
<tr>
<td colspan="2" bgcolor="#ffd700" id="editmenu">内部業務項目：内部業務で利用する項目です。非公開情報です。</td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入担当</td>
<td bgcolor="#e6e6e6"><input type="text" name="INACCOUNT" value="<%= account %>"></td>
</tr>
<tr>
<td bgcolor="#ffd700">発注日</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_DATE" value="">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td bgcolor="#ffd700">WEB表示</td>
<td bgcolor="#e6e6e6">
<select name="WEB_DISP">
	<option value="0">0:WEBに表示しない</option>
	<option value="1">1:WEBに表示する</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入先</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELLER" value="" size="100"></td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入価格</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_PRICE" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入運賃</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_TRANS_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">部品代</td>
<td bgcolor="#e6e6e6"><input type="text" name="PARTS_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">整備費</td>
<td bgcolor="#e6e6e6"><input type="text" name="MAINTENANCE_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入外注費</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_OUT_ORDER_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">仕入原価</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_COST_PRICE" value="0" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">販売運賃</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_TRANCE_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">船積費用</td>
<td bgcolor="#e6e6e6"><input type="text" name="SHIP_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">販売外注費</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_OUT_ORDER_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">保険料</td>
<td bgcolor="#e6e6e6"><input type="text" name="INS_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">フレイト</td>
<td bgcolor="#e6e6e6"><input type="text" name="FREIGHT_COST" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">販売原価</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_COST_PRICE" value="0" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">販売価格</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_PRICE" value="0" style="text-align:right;" onblur="autoSum(this.form)">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">利益</td>
<td bgcolor="#e6e6e6"><input type="text" name="PROFIT" value="0" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<tr>
<td bgcolor="#ffd700">販売先</td>
<td bgcolor="#e6e6e6"><input type="text" name="BUYER" value="" size="100"></td>
</tr>
<tr>
<td bgcolor="#ffd700">業販価格</td>
<td bgcolor="#e6e6e6"><input type="text" name="WHOL_PRICE" value="0" style="text-align:right;">（数字のみ入力可能）</td>
</tr>
<%
// 経理・管理者権限のみ表示
if ("3".equals(authCode) || "2".equals(authCode)) {
%>
<tr>
<td bgcolor="#ffd700">仕入代金支払日</td>
<td bgcolor="#e6e6e6"><input type="text" name="ORDER_PAY_DATE" value="">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td bgcolor="#ffd700">売上入金日</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_PAY_DATE" value="">（入力形式:YYYY/MM/DD）</td>
</tr>
<tr>
<td bgcolor="#ffd700">売上月</td>
<td bgcolor="#e6e6e6"><input type="text" name="SELL_MONTH" value="">（入力形式:YYYY/MM）</td>
</tr>
<tr>
<%
} else {
%>
<input type="hidden" name="ORDER_PAY_DATE" value="">
<input type="hidden" name="SELL_PAY_DATE" value="">
<input type="hidden" name="SELL_MONTH" value="">
<%
}
%>
<td bgcolor="#ffd700">在庫メモ</td>
<td bgcolor="#e6e6e6"><textarea name="MEMO" cols="50" rows="5" maxlength="256"></textarea></td>
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