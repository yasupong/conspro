<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conspro.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>SIGN UP</title>
<link rel="stylesheet" href="css/conspro.css" type="text/css">
<script type="text/javascript">
<!--
function callServer(obj) {
	if(obj.name.value==''){
		alert("PLEASE FILL NAME");
		return;
	}
	if(obj.street.value==''){
		alert("PLEASE FILL STREET ADDRESS");
		return;
	}
	if(obj.city.value==''){
		alert("PLEASE FILL CITY");
		return;
	}
	if(obj.state.value==''){
		alert("PLEASE FILL STATE/ PROVINCE");
		return;
	}
	if(obj.country.value==''){
		alert("PLEASE FILL COUNTRY");
		return;
	}
	if(obj.zipcode.value==''){
		alert("PLEASE FILL ZIP CODE");
		return;
	}
	if(obj.tel.value==''){
		alert("PLEASE FILL TEL");
		return;
	}
	if(obj.email.value==''){
		alert("PLEASE FILL E-MAIL");
		return;
	}

	var message = 'ARE YOU SURE TO SUBMIT THOSE?\n\n';

	message = message + 'NAME:' + obj.name.value + '\n';

	for (var i = 0; i < obj.usertype.length; i++)
	{
		if(obj.usertype[i].checked == true)
		{
			message = message + 'YOU ARE:' + obj.usertype[i].value + '\n';
		}
	}
	message = message + 'STREET ADDRESS :' + obj.street.value + '\n';
	message = message + 'CITY:' + obj.city.value + '\n';
	message = message + 'STATE/ PROVINCE:' + obj.state.value + '\n';
	message = message + 'COUNTRY:' + obj.country.value + '\n';
	message = message + 'ZIP CODE:' + obj.zipcode.value + '\n';
	message = message + 'TEL:' + obj.tel.value + '\n';
	message = message + 'FAX:' + obj.fax.value + '\n';
	message = message + 'E-MAIL:' + obj.email.value + '\n';

	for (var i = 0; i < obj.stocklist.length; i++)
	{
		if(obj.stocklist[i].checked == true)
		{
			message = message + 'STOCK LIST:' + obj.stocklist[i].value + '\n';
		}
	}

	message = message + 'COMMENT:' + obj.comment.value + '\n';

	if (confirm(message)) {
		obj.passkey.value = '<%= Const.PASS_KEY_SIGN_UP %>';
		obj.submit();
	}
}
-->
</script>
</head>
<body>
<div id="page">
<form action="RegistSignup" method="POST">
<div><h1>SIGN UP</h1></div>
<div>
<table border="1" cellpadding="1" cellspacing="0" bordercolor="#c0c0c0" width="700">
<tr>
<td class="th">NAME</td>
<td class="td"><input type="text" name="name" size="26"></td>
</tr>
<tr>
<td class="th">YOU ARE</td>
<td class="td">
	<input type="radio" name="usertype" value="DEALER" checked> DEALER
	<input type="radio" name="usertype" value="CONTRACTOR"> CONTRACTOR
	<input type="radio" name="usertype" value="IMPORTER/EXPORTER">IMPORTER/EXPORTER
	<input type="radio" name="usertype" value="OTHER">OTHER
</td>
</tr>
<tr>
<td class="th">COMPANY NAME</td>
<td class="td"><input type="text" name="company" maxlength="100" size="45"></td>
</tr>
<tr>
<td class="th">STREET ADDRESS</td>
<td class="td"><input type="text" name="street" maxlength="100" size="45"></td>
</tr>
<tr>
<td class="th">CITY</td>
<td class="td"><input type="text" name="city" maxlength="100" size="45"></td>
</tr>
</tr>
<tr>
<td class="th">STATE/ PROVINCE</td>
<td class="td"><input type="text" name="state" maxlength="100" size="45"></td>
</tr>
<tr>
<td class="th">COUNTRY</td>
<td class="td"><input type="text" name="country" maxlength="100" size="26"></td>
</tr>
<tr>
<td class="th">ZIP CODE</td>
<td class="td"><input type="text" name="zipcode" maxlength="8" size="10"></td>
</tr>
<tr>
<td class="th">TEL</td>
<td class="td"><input type="text" name="tel" maxlength="100" size="30"></td>
</tr>
<tr>
<td class="th">FAX</td>
<td class="td"><input type="text" name="fax" maxlength="100" size="30"></td>
</tr>
<tr>
<td class="th">E-MAIL</td>
<td class="td"><input type="text" name="email" maxlength="100" size="40"></td>
</tr>
<tr>
<td class="th">DO YOU WANT TO RECEIVE OUR STOCK LIST WEEKLY?</td>
<td class="td">
	<input type="radio" name="stocklist" value="yes" checked>yes
	<input type="radio" name="stocklist" value="no">no 
</td>
</tr>
<tr>
<td class="th">COMMENT</td>
<td class="td"><textarea name="comment" cols="45" rows="7" maxlength="256"></textarea></td>
</tr>
</table>
<div>
<input type="hidden" name="isdev" value="true">
<input type="hidden" name="passkey">
<input type="button" value="SEND" onclick="callServer(this.form)">
</div>
</form>
</div>
</body>
</html>