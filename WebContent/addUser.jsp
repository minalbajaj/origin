<%@ include file="includes/header.jsp" %>

   <script type="text/javascript">
   function cancelAction()
   {
   	document.location.href("Search.jsp");
   }

   function Validate()
   { 
   	if(document.frmadd_user.user_name.value==""){
   		alert("Please enter username.");
   		document.frmadd_user.user_name.focus();
   		return false;
   	}
   	if (document.frmadd_user.user_pass.value==""){
   		alert("Please enter password.");
   		document.frmadd_user.user_pass.focus();
   		return false;
   	}
   	if (document.frmadd_user.user_confpass.value==""){
   		alert("Please enter confirm password.");
   		document.frmadd_user.user_confpass.focus();
   		return false;
   	}
   	if(document.frmadd_user.user_pass.value!=document.frmadd_user.user_confpass.value)
   	{
   		alert("Password doesn't match..!!");
   		document.frmadd_user.user_confpass.value="";
   		document.frmadd_user.user_confpass.focus();
   		return false;
   	}
   	document.frmadd_user.submit();
   	return true;
   }
   </script>.
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
		<tr >
          <td colspan="5">
           <table width="100%" height="23" border="0" align="left" cellpadding="0" cellspacing="0" style="border:0px solid #000000;">
         
          <tr>
              <td><div align="left" style="height:25px;" class="pageheading">Add User</div></td>
              <td align="right" valign="top"><div align="right" style="margin-right:10px; color:#990000;">
              <table border="0" cellpadding="0" cellspacing="0">
              <tr>
              	<td>
	              	<form name="adduser" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
	           			<input type="hidden" name="myname" value="AddUser"></input>
	           			<input type="submit" name="btnadduser" class="links" value="Add" style="border:none;background: none;" />
	           			&nbsp;&nbsp;|&nbsp;
	           		</form>
              	</td>
              	<td>
              		<form name="updateuser" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="UpdateUser"></input>
              			<input type="submit" name="btnupdateuser" class="links" value="Update" style="border:none;background: none;" />
              			&nbsp;&nbsp;|&nbsp;
              		</form>              		
              	</td>
              	<td valign="top">
              		<form name="Deleteuser" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="DeleteUser"></input>
              			<input type="submit" name="btndeleteuser" class="links" value="Delete" style="border:none;background: none;" />
              		</form>
              	</td>
              </tr>
              </table>
                 </div>            
               </td>
            </tr>
        </table>
      </td>
    </tr>
    <form name="frmadd_user" action="CommonServlet" method="post">
    <tr>
      <td colspan="5" align="left">&nbsp;
      <input type="hidden" name="myname" value="AddUser"></input>
      </td>
    </tr>
	 
	 <tr>
	 	<td align="left" valign="top" nowrap>
	 		<div align="left" style="margin-left:15px;" class="labels">Username<span style="color:#FF0000"> *</span></div> </td> 
		<td width="3%" valign="top">
   
				<div align="center" class="labels"><b>:</b></div></td>
    <td width="79%" align="left">
		<input type="text" name="user_name" id="user_name" style="width:175px"></td>
	</tr>
	 <tr>
	   <td align="left" valign="top">&nbsp;</td>
	   <td valign="top"><div align="center"></div></td>
	   <td align="left">&nbsp;</td>
	   </tr>
	 <tr>
		<td align="left" valign="top">
			<div align="left" style="margin-left:15px;" class="labels">Password	<span style="color:#FF0000"> *</span></div>	  </td> 
		<td width="3%" valign="top">

				<div align="center" class="labels"><b>:</b> </div></td>
<td align="left">
           	<input type="password" name="user_pass" id="user_pass" style="width:175px">  </td>
	</tr>
	<tr>
	   <td align="left" valign="top">&nbsp;</td>
	   <td valign="top"><div align="center"></div></td>
	   <td align="left">&nbsp;</td>
	   </tr>
	   <tr>
		<td align="left" valign="top">
			<div align="left" style="margin-left:15px;" class="labels">Confirm Password <span style="color:#FF0000"> *</span></div>	  </td> 
		<td width="3%" valign="top">

				<div align="center" class="labels"><b>:</b> </div></td>
<td align="left">
           	<input type="password" name="user_confpass" id="user_confpass" style="width:175px">  </td>
	</tr>
	<tr>
	   <td align="left" valign="top">&nbsp;</td>
	   <td valign="top"><div align="center"></div></td>
	   <td align="left">&nbsp;</td>
	   </tr>
	
           	<input type="hidden" name="usertype" id="usertype" value="U"></input>
	
	 <tr>
	   <td>&nbsp;</td>
	   <td>&nbsp;</td>
	   <td colspan="3" align="left">&nbsp;</td>
	   </tr>
	 <tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
		<td colspan="3" align="left">
			<div >
				<input type="button" name="save" onclick="return Validate();" value="Save" style="width: 80px; " class="buttons">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  					<input type="reset" name="set" style="width: 80px;" class="buttons">
  					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				<a href="Search.jsp" onclick="javascript:cancelAction();">	<input type="button" name="Cancel" style="width: 80px;" value="Cancel" class="buttons">
  				</a></div>		</td>
	</tr>
	</form>  
</table>

<%@ include file="includes/footer.jsp" %>
<%if(request.getAttribute("userlistrd")!=null){ %>
<script type="text/javascript">
	   alert("User already exist.");
	   </script>
	   <%} %>
<% 
	  if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("User added successfully.");
	   </script>
	   <%} %>