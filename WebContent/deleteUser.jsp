<%@ include file="includes/header.jsp" %>
<% String mytype= (String) session.getAttribute("mytype");
   if(mytype.equals("U"))
   {   
		response.sendRedirect("/Dashboard")	 ;  
   }
%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<script language="javascript">
function cancelAction()
{
	document.location.href("Search.jsp");
}
function Validate()
{   
	var flag = true;
	for(var i=0;i<document.frmdel_user.elements.length;i++)
	{
		var e=document.frmdel_user.elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{
			if(e.checked)
				flag = false;
		}
	}
	if(flag == true)
	{
		alert("No user selected.");
		return false;
	}
	if(confirm('Are you sure, you want to delete selected records.')==true){
	document.frmdel_user.submit();
	return true;
	}else
	{
		return false;
	}
}

function UncheckAll()
{
	for(var i=0;i<document.frmdel_user.elements.length;i++)
	{
		var e=document.frmdel_user.elements[i];
		if (e.type=='checkbox')
		{
			e.checked=document.frmdel_user.allbox.unchecked;
		}
	}
}

function CheckAll(){
	for(var i=0;i<document.frmdel_user.elements.length;i++)
	{
		var e=document.frmdel_user.elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{
			e.checked=document.frmdel_user.allbox.checked;
		}
	}
}
function callPagination(iPageNo){
	document.getElementById("iPageNo").value=iPageNo;
	document.frmdel_user.submit();
}
</script>
<%  
	List<?> l13=(List<?>)request.getAttribute("abc"); 
	int istart=0;
	int iPageNo=0;
	int cPageNo=1;
	int itotalpages=0;
	int ilength=10;
	String str=null;
	itotalpages=Integer.parseInt(request.getAttribute("itotalpages").toString()); 
	cPageNo=Integer.parseInt(request.getAttribute("cPageNo").toString());
	iPageNo=Integer.parseInt(request.getAttribute("iPageNo").toString());
	ilength=Integer.parseInt(request.getAttribute("ilength").toString());
	str=(String)request.getAttribute("str");

%>
	
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
        <tr >
         <td colspan="4">
               <table width="100%" height="23" border="0" align="left" cellpadding="0" cellspacing="0" style="border:0px solid #000000;">
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
               </tr>
          <tr>
              <td><div align="left" style="height:25px;" class="pageheading">Delete User </div></td>
              <td align="right" valign="top"><div align="right" style="margin-right:10px; color:#990000;">
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
                     </div>            
                   </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
        <td colspan="5" align="left">&nbsp;</td>
       </tr>
        <%  if(l13!=null && l13.size()>0) { %>
           <form action="CommonServlet" name="frmdel_user" method="post">
          	 <input type="hidden" name="iPageNo" id="iPageNo" value="<%=iPageNo%>">
		     <input type="hidden" name="cPageNo" id="cPageNo" value="<%=cPageNo%>">
		     <input type="hidden" name="ilength" id="ilength" value="<%=ilength%>">
		     <input type="hidden" name="myname" value="DeleteUser"></input>
		    
             <tr>
        <td colspan="5" align="left"> <div align="right" style="margin-right:15px;" >
         <a href="#" onclick="javascript:callPagination('<%=1%>');"  class="links"> &nbsp;First</a> 
        <a href="#" onclick="javascript:callPagination('<%=cPageNo-1%>');"  class="links">&nbsp;Previous&nbsp;</a>
           <% 
				for(int i=1; i<= itotalpages; i++)
				{
				%> 
				 <a href="#" onclick="javascript:callPagination('<%=i%>');"" class="links" ><%=i%></a>
             <% } %>  
              <a href="#" onclick="javascript:callPagination('<%=cPageNo+1%>');" class="links">&nbsp;Next</a> 
               <a href="#" onclick="javascript:callPagination('<%=itotalpages%>');"  class="links">Last</a> 
   </div></td>
       </tr>
         <tr>
        <td colspan="5" align="left">&nbsp;</td>
       </tr>
            <tr>
            	<td colspan="4">
               		<div align="left" style="margin-left:12px;">
                    	<table width="99%" cellpadding="0" cellspacing="0" border="0">
                        	<tr>
                                <td width="4%" style="border-right:1px solid #000000; border-left:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#CCCCCC;"><div align="center" style="height:26px;">
                                        <input type="checkbox" name="allbox" value="on" onclick="CheckAll()">
                                    </div>
                                </td>
                                <td width="4%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; background:#CCCCCC;">
<div align="center">
                                        <img src="images/User.JPG">
                                    </div>
                                </td>
                          <td width="41%" style="border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000;background:#CCCCCC;" >
<div align="center">
                                        <b>User ID</b>
                                    </div>
                                <td width="51%" style="border-bottom:1px solid #000000; border-top:1px solid #000000; border-right:1px solid #000000;background:#CCCCCC;">
                              <div align="center">
                                        <b>Username</b>
                                    </div>
                                </td>
                          </tr>
                            <% Iterator<?> it13 = l13.iterator(); 
                                while(it13.hasNext()){ 
                                Object rowData[] = (Object[]) it13.next();%>
                                <tr>
                                    <td align="center" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;height:24px;">
                                        <input type="checkbox" name="on" value="<%= rowData[0] %>">
                                    </td>
                                    <td width="4%" style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
<div align="center" style="background:#ffffff; color:#ffffff; font-size:15px;height:20px; border:0px solid #000000;">
                                            <img src="images/User.JPG">
                                        </div>
                                    </td>
                      <% for(int j=0;j<rowData.length;j++){ %>
                                    <td align="left" style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
                                        &nbsp;&nbsp;&nbsp;&nbsp;<%=rowData[j] %>
                                    </td>
                                        <%} %>
                                </tr>
                                    <% } %>
                                <tr>
                                    <td colspan="5" style="border-bottom:1px solid #000000; border-top:0px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000;background:#CCCCCC;height:26px;">
                                        <div align="left">
                                        <a href="#" onclick="UncheckAll()" style="color:#333333; margin-left:30px;"><b>Uncheck All</b></a>
                                        </div>
                                    </td>
                                </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
        <td colspan="5" align="left">&nbsp;</td>
       </tr>
         <tr>
        <td colspan="5" align="left">&nbsp;</td>
       </tr>
            <tr>
                <td colspan="4" align="left" style="margin-left:12px;">
                    <input type="button" value="Delete" style="width: 80px;margin-left:12px;"  class="buttons" onclick="return Validate();">
                   &nbsp;&nbsp;&nbsp; 
                    <a href="Search.jsp" onclick="javascript:cancelAction();"><input type="button" value="Cancel" style="width: 80px;" class="buttons"></a>
                </td>
            </tr>
            <tr>
        <td colspan="5" align="left"> <div align="right" style="margin-right:15px;" >
         <a href="#" onclick="javascript:callPagination('<%=1%>');"  class="links"> &nbsp;First</a> 
        <a href="#" onclick="javascript:callPagination('<%=cPageNo-1%>');"  class="links">&nbsp;Previous&nbsp;</a>
           <% 
				for(int i=1; i<= itotalpages; i++)
				{
				%> 
				 <a href="#" onclick="javascript:callPagination('<%=i%>');"" class="links" ><%=i%></a>
             <% } %>  
              <a href="#" onclick="javascript:callPagination('<%=cPageNo+1%>');" class="links">&nbsp;Next</a> 
               <a href="#" onclick="javascript:callPagination('<%=itotalpages%>');"  class="links">&nbsp;Last</a> 
   </div></td>
       </tr>
       <tr>
<td ><div align="right" style="margin-right:17px;" class="labels">
	<%  
		int i = Integer.parseInt(str);
		%> 
		Rows <%=((cPageNo - 1)*ilength)+1%> - 
		<% if((i-(cPageNo*ilength)) < 0){ %> <%= i %>   
		<% } else { %>
		<%= cPageNo*ilength %> <%} %>
		Total Result  <%= str %>
	</div>
</td>
</tr>
       <tr>
        <td colspan="5" align="left">&nbsp;</td>
       </tr><%} else { %>
       <tr><td> <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0" style="margin-top:100px">
				 <tr>
				 <td align="right" style="height:22px; border-bottom:1px solid #000000; 
				border-left:1px solid #000000; border-top:1px solid #000000;  ">
			<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;"></img></div></td>
				
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; 
				border-top:1px solid #000000; ">
			<div style=" margin-left:5px;"  align="left" class="labels">
			
			<b><font color="red">No User Found </font> </b> </div></td>
				 </tr></table></td></tr>
       <%} %>
</form>		</table>
<%@ include file="includes/footer.jsp" %>
<% 
	  if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("Selected records deleted successfully.");
	   </script>
	   <%} %>