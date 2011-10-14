<%@ include file="includes/header.jsp" %>

<script type="text/javascript">
function cancelAction()
{
	document.location.href("Search.jsp");
}
function validatePwd(){
	var oldpwd='<%= session.getAttribute("mypwd")%>';
	if(document.getElementById("oldpass").value==""){
		alert("Please enter old password.");
		document.getElementById("oldpass").focus();
		return false;
	}
	if(document.getElementById("oldpass").value!=oldpwd){
		alert("Please enter valid old password.");
		document.getElementById("oldpass").value="";
		document.getElementById("oldpass").focus();
		return false;
	}
	if(document.getElementById("newpass").value==""){
		alert("Please enter new password.");
		document.getElementById("newpass").focus();
		return false;
	}
	if(document.getElementById("cnfmpass").value==""){
		alert("Please enter confirm password.");
		document.getElementById("cnfmpass").focus();
		return false;
	}
	if(document.getElementById("cnfmpass").value!=document.getElementById("newpass").value){
		alert("New password and confirm password does not match.");
		document.getElementById("newpass").value="";
		document.getElementById("cnfmpass").value="";
		document.getElementById("cnfmpass").focus();
		return false;
	}	
}
</script>
<form name="chgpassword" method="post" action="CommonServlet">
<input type="hidden" name="myname" value="changepassword"></input>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr >
    <td colspan="3">&nbsp;</td>
    <td  valign="top" align="right" >&nbsp;</td>
  </tr>
  <tr >
	 <td colspan="3"><div align="left" style="height:25px;" class="pageheading">Change Password</div></td>
      <td  valign="top" align="right" >
       <div align="right" style="margin-right:10px; color:#990000;">
          <table border="0" cellpadding="0" cellspacing="0">
             <tr>
              	<td valign="top"> </td>
                <td></td>
              </tr>
           </table>
       </div>  
      </td>
    </tr>
  <tr>
    <td width="18%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
    <td width="79%">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">Old Password<span style="color:#FF0000"> *</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="password" id="oldpass" name="oldpass" style="width:175px" ></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">New Password<span style="color:#FF0000"> *</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="password" id="newpass" name="newpass" style="width:175px" ></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">Confirm Password<span style="color:#FF0000"> *</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="password" id="cnfmpass" name="cnfmpass" style="width:175px" ></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
	<td align="left">&nbsp;</td>
	<td align="left" valign="top">&nbsp;</td>
	<td align="left" valign="top">
		<div align="left"><input type="submit" name="save" value="Update" class="buttons" onclick="return validatePwd();"style="width: 80px;" />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" name="set" class="buttons" style="width: 80px;" />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  <a href="Search.jsp" onclick="javascript:cancelAction();">
    <input type="button" value="Cancel" class="buttons" style="width: 80px;"></input>
  </a></div></td>
  </tr>
</table>
</form>
<%@ include file="includes/footer.jsp" %>
<% if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("Password changed successfully");
	   </script>
	   <%} %>