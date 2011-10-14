<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
  
    <% String mystatus1= (String) session.getAttribute("mystatus");
    String myname1=null;
	   if(mystatus1==null)
	   {   
	    response.sendRedirect("Login.jsp") ;  	   
	   }else{
		   myname1= (session.getAttribute("myname")).toString();
	   }
	    
	%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Loyalty Rewards Management</title>
<link rel="stylesheet" type="text/css" href="sdmenu/sdmenu.css" />
<link rel="stylesheet" type="text/css" href="css/stylesheet.css"/>


<script type="text/javascript">
	// <![CDATA[
	var myMenu;
	window.onload = function() 
	{
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	// ]]>
	
</script>

</head>
<body >
<div align="center">
<table border="0" cellpadding="0" cellspacing="0" width="95%" style="background-color:#FFFFFF; border:1px solid #000000;">
	<tr>
		<td colspan="2" style="background:url(images/fadedBar.png) right repeat-y; color:#ffffff;">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td rowspan="2"><div align="left" style="margin-left:8px;font-family:Georgia;font-size: 26px; margin-top:5px;">
            <img src="images/logo.jpg" width="200" height="75"  style="cursor:pointer;" />
            </div></td>
                <td style="color:#ffffff; font-weight: bold;"><div align="right" style="margin-right: 5px;">WELCOME  <%=myname1 %><a href="Logout.jsp" class="links" style="color: white;font-size:12px;">  (Logout)</a></div></td>
              </tr>
              <tr>
                <td style=" color:#ffffff; font-weight: bold;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="60%" align="right"><img src="images/home.png" width="24" height="24" style="cursor:pointer;"  title="Home">&nbsp;</td>
                    <td width="6%" align="center">|</td>
                    <td width="34%" align="left">
                    	<div align="right" style="margin-right:5px;color:#ffffff;" class="labels">
                			<%	Date date = Calendar.getInstance().getTime();
                                DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy, hh:mm:ss a");
                            %>
                    	    <%= formatter.format(date) %>
                            <input type="hidden" name="inDate1" id="inDate1" value="<%= formatter.format(date) %>"></input>
                        </div>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
            </table>
        </td>
    </tr>
	<tr>
		<td style="background:url(images/fadedBar.png) repeat-y; color:#ffffff;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		
          </tr>
        </table>        
       </td>
	</tr>
	<tr>
		<td colspan="2" width="15%" valign="top" align="center">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td valign="top">
			<% 
				String myType= (String) session.getAttribute("mytype");
				if(myType!=null && myType.equals("A"))
				{
			%>
			<%@ include file="menu.jsp" %>
			<% }else if(myType!=null && myType.equals("U")){ %>
			<%@ include file="usermenu.jsp" %>
			<% } %>
		</td>
		<td width="90%" height="400" valign="top" align="center">