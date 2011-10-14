<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Loyalty Rewards Management</title>
<link rel="stylesheet" type="text/css" href="sdmenu/sdmenu.css" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>

<script type="text/javascript">
	
	var alphaNumExp = /^[0-9a-zA-Z_ ]+$/;
		function Validate()
		{
		if(document.frmlogin.username.value=="")
			{
				alert("Please enter username.");
				document.frmlogin.username.focus();
				return false;
			}
			if(document.frmlogin.userpass.value=="")
			{
				alert("Please enter password.");
				document.frmlogin.userpass.focus();
				return false;	
			}
			return true;
		}
		function load()
		{
			if(document.getElementById('invalid').value=="iu")
			{
				alert("Invalid User");
			}
		}
	</script>
</head>
<input type="hidden" name="invalid" id="invalid" value="<%= request.getAttribute("IU") %>">
<body >
<div align="center">
<table border="0" cellpadding="0" cellspacing="0" width="960px" style="background-color:#FFFFFF; border:1px solid #000000;">
	<tr >
		<td colspan="2" style="background:url(images/fadedBar.png) left repeat-y; color:#ffffff; height:30px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td style="height:30px;">
            <div align="left" style="margin-left:8px;font-family:Georgia;font-size: 26px; margin-top:5px;">
            <img src="images/logo.jpg" width="200" height="75" />
          </div></td>
            <td style="color:#ffffff; height: 32px; font-weight: bold;"><div align="right" style="margin-right: 5px;"></div></td>
        </tr>
        </table>
		</td>
	</tr>
    
	<tr>
		<td >
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td valign="top">&nbsp;
		</td>
		<td width="85%" valign="top" align="center">
<% String msg="empty";
if(request.getAttribute("IU")!=null){
	msg = (String)request.getAttribute("IU");
}
%>
<form name="frmlogin" action="StartServlet" method="post">
	<div align="left" style="margin-left:150px;margin-bottom:10px;">
	<br>
        	<table width="55%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #999999;">
              <tr>
                <td colspan="4" bgcolor="#333333" style="color: white;height:30px;" class="sub_heading">
                	<div align="center">USER LOGIN</div>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="31%">&nbsp;</td>
                <td width="6%">&nbsp;</td>
                <td width="31%">&nbsp;</td>
                <td width="32%">&nbsp;</td>
              </tr>
              <tr>
                <td valign="top"><div align="center">
                <img src="images/login.png" width="100" height="100" /></div></td>
                <td colspan="3" valign="top"><div align="left">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="29%"><div align="left" class="labels">Username</div></td>
                      <td width="7%"><div align="center" class="labels">:</div></td>
                      <td width="64%"><div align="left">
                        <label>
                        <input type="text" name="username" id="textfield" />
                        </label>
                      </div></td>
                    </tr>
                    <tr>
                      <td><div align="left">&nbsp;</div></td>
                      <td><div align="center"></div></td>
                      <td><div align="left"></div></td>
                    </tr>
                    <tr>
                      <td><div align="left" class="labels">Password</div></td>
                      <td><div align="center" class="labels">:</div></td>
                      <td><div align="left">
                        <input type="password" name="userpass" id="textfield2" />
                      </div></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td><div align="left">
                        <input type="submit" name="btnLogin" id="btnLogin" value="Login" onClick="return Validate();">
                       <input type="reset" value="Reset" style="width:60px;">
                      </div></td>
                    </tr>
                  </table>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
        </div>
        <br>
        </form>
<%@ include file="includes/footer.jsp" %>