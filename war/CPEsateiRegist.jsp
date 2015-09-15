<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>査定受付</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
	function callServer(obj) {
		if(obj.name.value==''){
			alert("「お名前」を入力してください");
			return;
		}
		if(obj.post.value==''){
			alert("「郵便番号」を入力してください");
			return;
		}
		if(obj.pname.value==''){
			alert("「都道府県」を選択してください");
			return;
		}
		if(obj.address.value==''){
			alert("「ご住所」を入力してください");
			return;
		}
		if(obj.tel.value==''){
			alert("「お電話番号」を入力してください");
			return;
		}
		if(obj.email.value==''){
			alert("「メールアドレス」を入力してください");
			return;
		}
		if (obj.source.value=='3') {
			if(obj.price.value==''){
				alert("「希望金額」を入力してください");
				return;
			}
			if(obj.type.value==''){
				alert("「分類」を入力してください");
				return;
			}
			if(obj.maker.value==''){
				alert("「メーカー」を入力してください");
				return;
			}
			if(obj.model.value==''){
				alert("「型式」を入力してください");
				return;
			}
			if(obj.cond.value==''){
				alert("「程度」を入力してください");
				return;
			}
		}

	  if (isNaN(obj.price.value)) {
			alert('「希望金額」は半角数字で入力してください');
			return;
		}

		if (confirm("査定内容を送信します。よろしいですか？")) {
			obj.passkey.value = '<%= Const.PASS_KEY_SATEI %>';
			obj.submit();
		}
	}
-->
</script>
</head>
<body>
<div id="page">
<form action="RegistEsatei" method="POST">
<div><h1>査定受付</h1></div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700">
<tr>
<td class="th">お名前*</td>
<td class="td"><input type="text" name="name" size="20">（全角）</td>
</tr>
<tr>
<td class="th">郵便番号*</td>
<td class="td"><input type="text" name="post" maxlength="8" size="10">（半角）</td>
</tr>
<tr>
<td class="th">都道府県*</td>
<td class="td">
<select name="pname"> 
  <option value="" selected>選択</option>
  <option value="北海道">北海道</option>
  <option value="青森県">青森県</option> 
  <option value="岩手県">岩手県</option>
  <option value="宮城県">宮城県</option>
  <option value="秋田県">秋田県</option> 
  <option value="山形県">山形県</option>
  <option value="福島県">福島県</option>
  <option value="茨城県">茨城県</option> 
  <option value="栃木県">栃木県</option>
  <option value="群馬県">群馬県</option>
  <option value="埼玉県">埼玉県</option> 
  <option value="千葉県">千葉県</option>
  <option value="東京都">東京都</option>
  <option value="神奈川県">神奈川県</option>
  <option value="新潟県">新潟県</option>
  <option value="富山県">富山県</option> 
  <option value="石川県">石川県</option>
  <option value="福井県">福井県</option>
  <option value="山梨県">山梨県</option> 
  <option value="長野県">長野県</option>
  <option value="岐阜県">岐阜県</option>
  <option value="静岡県">静岡県</option> 
  <option value="愛知県">愛知県</option>
  <option value="三重県">三重県</option>
  <option value="滋賀県">滋賀県</option> 
  <option value="京都府">京都府</option>
  <option value="大阪府">大阪府</option>
  <option value="兵庫県">兵庫県</option> 
  <option value="奈良県">奈良県</option>
  <option value="和歌山県">和歌山県</option>
  <option value="鳥取県">鳥取県</option>
  <option value="島根県">島根県</option> 
  <option value="岡山県">岡山県</option>
  <option value="広島県">広島県</option>
  <option value="山口県">山口県</option> 
  <option value="徳島県">徳島県</option>
  <option value="香川県">香川県</option>
  <option value="愛媛県">愛媛県</option> 
  <option value="高知県">高知県</option>
  <option value="福岡県">福岡県</option>
  <option value="佐賀県">佐賀県</option> 
  <option value="長崎県">長崎県</option>
  <option value="熊本県">熊本県</option>
  <option value="大分県">大分県</option> 
  <option value="宮崎県">宮崎県</option>
  <option value="鹿児島県">鹿児島県</option>
  <option value="沖縄県">沖縄県</option>
  <option value="海外">海外</option>
</select>
</td>
</tr>
<tr>
<td class="th">ご住所*</td>
<td class="td"><textarea name="address" rows="3" cols="40"></textarea></td>
</tr>
<tr>
<td class="th">お電話番号*</td>
<td class="td"><input type="text" name="tel" maxlength="30" size="30">（半角）</td>
</tr>
</tr>
<tr>
<td class="th">FAX番号</td>
<td class="td"><input type="text" name="fax" maxlength="30" size="30">（半角）</td>
</tr>
<tr>
<td class="th">メールアドレス*</td>
<td class="td"><input type="text" name="email" maxlength="40" size="40">（半角）</td>
</tr>
<tr>
<td class="th">どちらを希望しますか?</td>
<td class="td">
<input type="radio" name="source" value="1">とりあえず相場を知りたい 
<input type="radio" name="source" value="2">今すぐ売りたい
<input type="radio" name="source" value="3">金額が折り合えば売りたい
</td>
</tr>
<tr>
<td class="th">希望金額</td>
<td class="td"><input type="text" name="price" maxlength="17" size="17" style="text-align:right;">円</td>
</tr>
<tr>
<td class="th">分類</td>
<td class="td">
<select name="type">
  <option value="" selected>選択</option>
<%= Const.COMBO_TYPE %>
</select>
</td>
</tr>
<tr>
<td class="th">メーカー</td>
<td class="td">
<select name="maker" size="1">
  <option value="" selected>選択</option>
<%= Const.COMBO_MANUFACTURER %>
</select>
</td>
</tr>
<tr>
<td class="th">型式</td>
<td class="td"><input type="text" name="model" size="20"></td>
</tr>
<tr>
<td class="th">年式</td>
<td class="td"><input type="text" name="year" size="4"></td>
</tr>
<tr>
<td class="th">号機</td>
<td class="td"><input type="text" name="serial" size="20"></td>
</tr>
<tr>
<td class="th">メーター</td>
<td class="td"><input type="text" name="meter" size="10"></td>
</tr>
<tr>
<td class="th">程度</td>
<td class="td">
<select name="cond">
  <option value="" selected>選択</option>
<%= Const.COMBO_CONDITION %>
</select>
</td>
</tr>
<tr>
<td class="th">詳細</td>
<td class="td"><textarea name="detail" cols="45" rows="7" maxlength="256"></textarea></td>
</tr>
</table>
<div>
<input type="hidden" name="isdev" value="true">
<input type="hidden" name="passkey">
<input type="button" value="送信" onclick="callServer(this.form)">
</div>
</form>
</div>
</body>
</html>