<%@ include file="includes/header.jsp" %>
<% String mytype= (String) session.getAttribute("mytype");
   if(mytype.equals("U"))
   {   
    response.sendRedirect("Search.jsp")	 ;  
   }
%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<script type="text/javascript">
function cancelAction()
{
	document.location.href("Search.jsp");
}
	function Show()
	{   
		
		if(document.getElementById("username1").value=="0"){
			alert("Please select user name.");
			document.getElementById("username1").focus();
			return;
		}else{
			document.frmup_user.submit();
		}
		return true;
	}	
	function ValidateUser()
	{
		if(document.frmup_user.txtuser_name.value==""){
			alert("Please enter username.");
			document.frmup_user.txtuser_name.focus();
			return false;
		}
		
		if (document.frmup_user.user_pass.value==""){
			alert("Please enter password");
			document.frmup_user.user_pass.focus();
			return false;
		}
		if (document.frmup_user.user_confpass.value==""){
	   		alert("Please enter confirm password.");
	   		document.frmup_user.user_confpass.focus();
	   		return false;
	   	}
	   	if(document.frmup_user.user_pass.value!=document.frmup_user.user_confpass.value)
	   	{
	   		alert("Password doesn't match..!!");
	   		document.frmup_user.user_confpass.focus();
	   		return false;
	   	}
		document.getElementById("hdnupdtuser").value="SubmitFormuser";
	}	
</script>
<% 
    String struserid=(String)request.getAttribute("struserid");  
	List<?> userlist1=(List<?>)request.getAttribute("updatelist1");  
	System.out.println(userlist1);
	List<?> userlist2=null;
	if(request.getAttribute("updatelist2")!=null){		
		userlist2=(List<?>)request.getAttribute("updatelist2"); 
	}
%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
    <tr >
      <td colspan="4"><table width="100%" height="23" border="0" align="left" cellpadding="0" cellspacing="0" style="border:0px solid #000000;">
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
              <td><div align="left" style="height:25px;" class="pageheading">Update User </div></td>
              <td align="right" valign="top">
              <table border="0" cellpadding="0" cellspacing="0">
              <tr>
              	<td valign="top">
	              	<form name="adduser" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
	           			<input type="hidden" name="myname" value="AddUser"></input>
	           			<input type="submit" name="btnadduser" class="links" value="Add" style="border:none;background: none;" />
	           			&nbsp;&nbsp;|&nbsp;
	           		</form>
              	</td>
              	<td valign="top">
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
            </td>
          </tr>
        </table></td>
    </tr>
    <form name="frmup_user" method="post" action="CommonServlet">
   
    <tr>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td nowrap>&nbsp;</td>
      <td width="4%" ></td>
    </tr>
    <tr>
      <td width="18%" valign="top" nowrap><div align="left" style="margin-left:15px;" class="labels">Username 
      </div> </td>
      <td width="3%" valign="top" nowrap><div align="center" class="labels"><b>:</b></div>
      </td>
      <td nowrap width="75%"><div align="left">
          <select name="username1" id="username1" style="width:182px">
          <option value ="0" >--Select Username--</option>
            <% Iterator<?> it11 = userlist1.iterator(); 
				while(it11.hasNext()){ 
				Object []rowData = (Object[]) it11.next(); 
				Integer z5=(Integer) rowData[0];
				if(z5.toString().equals(struserid)){
				%>
            	<option value="<%= rowData[0] %>" selected="selected"><%= rowData[1] %></option>
            	<% 
						} else { 
					%><option value="<%= rowData[0] %>"><%= rowData[1] %></option>
            <% } }%>
          </select>
          <input type="hidden" name="myname" value="UpdateUser"></input>
          <input type="button" style="margin-left:10px;width:50px; height:24px" value="Get" name="btnGet" onclick="return Show();" class="buttons">
        </div></td>
      <td ></td>
    </tr>
    <tr>
     
      <td colspan="4">
      <div id="001" style="display:inline">
<% 
	if(userlist2!=null && userlist2.size()>0){ 
%>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
			<tr>
	    <td colspan="6" align="left" style="border-bottom:1px solid #000000">&nbsp;</td>
	  </tr>
			<tr>
			  <td valign="top">&nbsp;</td>
			  <td valign="top" class="labels">&nbsp;</td>
			  <td valign="top" >&nbsp;</td>
		  </tr>
			<tr>
				<td width="18%" valign="top"><div align="left" style="margin-left:15px;" class="labels">
				  <div align="left"></div>
				</div>			  </td>
		  <td width="3%" valign="top" class="labels">
						<div align="center"  ></div></td>
		  <td width="79%" valign="top" >
			
		    <div align="left">
		           <% 
					
					    Iterator<?> it12= userlist2.iterator(); 
					    while(it12.hasNext()){ 
					    Object []rowData = (Object[]) it12.next();
					%>
	         
	          <input type="hidden"  id="userid1" name="userid1" style="width:175px" value="<%= rowData[0]%>">				
	          </div></td> 
			</tr>
			 <tr>
			   <td valign="top" nowrap><div align="left">&nbsp;</div></td>
			   <td valign="top"><div align="center"></div></td>
			   <td valign="top" ><div align="left"></div></td>
	      </tr>
			 <tr>
			 	<td valign="top" nowrap>
			 	<div align="left" style="margin-left:15px;" class="labels">
			 	  <div align="left">Username				  </div>
			 	</div>			   </td> 
				<td width="3%" valign="top" class="labels">

						<div align="center"><b>:</b> </div></td>
<td valign="top" >
					
	    <div align="left">
	      <input type="text"  value="<%= rowData[1] %>" id="txtuser_name" name="txtuser_name" style="width:175px">			   
                      </div></td>
			</tr>
			 <tr>
			   <td valign="top"><div align="left">&nbsp;</div></td>
			   <td valign="top"><div align="center"></div></td>
			   <td valign="top" ><div align="left"></div></td>
	      </tr>
		    <tr>
				<td valign="top">
					<div align="left" style="margin-left:15px;" class="labels">
					  <div align="left">Password					</div>
					</div>			  </td> 
				<td width="3%" valign="top" class="labels">

						<div align="center"><b>:</b> </div></td>
<td valign="top" >
	           		
	    <div align="left">
	      <input type="hidden"  value="<%= rowData[1] %>" id="user_name" name="user_name" style="width:175px">	
	      <input type="Password"  value="<%= rowData[2] %>" id="user_pass" name="user_pass" style="width:175px">			   
                      </div></td>
		   </tr>
		    <tr>
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td align="left">&nbsp;</td>
	      </tr>
	      <tr>
				<td valign="top">
					<div align="left" style="margin-left:15px;" class="labels">
					  <div align="left">Confirm Password					</div>
					</div>			  </td> 
				<td width="3%" valign="top" class="labels">

						<div align="center"><b>:</b> </div></td>
<td valign="top" >
	           		
	    <div align="left">
	      <input type="Password"  value="<%= rowData[2] %>" id="user_confpass" name="user_confpass" style="width:175px">			   
                      </div></td><% } %> 
		   </tr>
		    <tr>
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td align="left">&nbsp;</td>
	      </tr>
	        <tr>
	          <td>&nbsp;</td>
	          <td>&nbsp;</td>
	          <td align="left">&nbsp;</td>
          </tr>
           <tr>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
			   <td align="left">
					<div >
					 <input type="hidden" id="hdnupdtuser" name="hdnupdtuser" value=""></input>
						<input type="submit" name="save" value="Update" style="width: 80px;" onclick="return ValidateUser();" class="buttons">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    					 <a href="Search.jsp" onclick="javascript:cancelAction();"><input type="button" name="Cancel" style="width: 80px;" value="Cancel" class="buttons">
    				</a></div>	</td>
			</tr>
</table>
  <% } %>
        </div>      
       </td>
    </tr>
    </form>
  </table>

<%@ include file="includes/footer.jsp" %>
<% if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("User updated successfully.");
	   </script>
	   <%} %>
