<%@ include file="includes/header.jsp" %>

<script type="text/javascript">
function cancelAction()
{
	document.location.href("Search.jsp");
}
function validatePwd(){
	
	if(document.getElementById("emailfrom").value==""){
		alert("Please enter email from.");
		document.getElementById("emailfrom").focus();
		return false;
	}
	if(document.getElementById("emailto").value==""){
		alert("Please enter email to.");
		document.getElementById("emailto").focus();
		return false;
	}
	if(document.getElementById("emailsubject").value==""){
		alert("Please enter email subject.");
		document.getElementById("emailsubject").focus();
		return false;
	}
	if(document.getElementById("emailmessage").value==""){
		alert("Please enter email message.");
		document.getElementById("emailmessage").focus();
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
	 <td colspan="3"><div align="left" style="height:25px;" class="pageheading">Email Details :</div></td>
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
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">From<span style="color:#FF0000"> *</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="text" id="emailfrom" name="emailfrom" style="width:210px" ></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">To<span style="color:#FF0000">*</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="text" id="emailto" name="emailto" style="width:210px" >
    <input type="submit" value="import address" name="importbutton" id="importbutton" style="margin-left:20px"/>
    </div>
    </td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"></div></td>
  </tr>
  <tr>
    <td valign="top"><div align="left" style="margin-left:15px;" class="labels">Subject<span style="color:#FF0000"> *</span></div></td>
    <td valign="top"><div align="center"  class="labels"><b>:<b></div></td>
    <td valign="top"><div align="left"> <input type="text" id="emailsubject" name="emailsubject" style="width:210px" ></div></td>
  </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"><div align="left">&nbsp;</div></td>
    <td valign="top"><div align="center"></div></td>
    <td valign="top"><div align="left"><textarea name="emailmessage" id="emailmessage" style="height:100px; width:210px">Enter Your Message Here....</textarea></div></td>
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
		<div align="left"><input type="submit" name="save" value="Send" class="buttons" onclick="return validatePwd();"style="width: 80px;" />
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
	   alert("Email send successfully");
	   </script>
	   <%} %>