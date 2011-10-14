<%@ include file="includes/header.jsp" %>
<% String mytype= (String) session.getAttribute("mytype");
   if(mytype.equals("U"))
   {   
    response.sendRedirect("Search.jsp")	 ;  
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
	for(var i=0;i<document.frmdel_customer.elements.length;i++)
	{
		var e=document.frmdel_customer.elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{
			if(e.checked)
				flag = false;
		}
	}
	if(flag == true)
	{
		alert("No member is selected.");
		return false;
	}
	if(confirm('Are you sure, you want to delete selected records.')==true){
	
		return true;
	}else{
		return false;
	}
}
function UncheckAll()
{
	for(var i=0;i<document.frmdel_customer.elements.length;i++)
	{
		var e=document.frmdel_customer.elements[i];
		if (e.type=='checkbox')
		{
			e.checked=document.frmdel_customer.allbox.unchecked;
		}
	}
}
function CheckAll(){
	for(var i=0;i<document.frmdel_customer.elements.length;i++)
	{
		var e=document.frmdel_customer.elements[i];
		if ((e.name != 'allbox') && (e.type=='checkbox'))
		{
			e.checked=document.frmdel_customer.allbox.checked;
		}
	}
}
function callPagination(iPageNo){
	document.getElementById("iPageNo").value=iPageNo;
	document.frmdel_customer.submit();
}
</script>
<%
	List<?> lc=(List<?>)request.getAttribute("Deletecus"); 
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
         <td colspan="5">
           <table width="100%" height="23" border="0" align="left" cellpadding="0" cellspacing="0" style="border:0px solid #000000;">
            <tr>
	            <td>&nbsp;</td>
	            <td>&nbsp;</td>
           </tr>
           <tr>
              <td>
               <div align="left" style="height:25px;" class="pageheading">Delete Member</div></td>
              <td align="right">
                <table border="0" cellpadding="0" cellspacing="0">
               <tr>
              	<td valign="top">
	              	<form name="addcustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
	           			<input type="hidden" name="myname" value="Addcustomer"></input>
	           			<input type="submit" name="btnaddcustomer" class="links" value="Add" style="border:none;background: none;" />
	           			&nbsp;&nbsp;|&nbsp;
	           		</form>
              	</td>
              	<td valign="top">
              		<form name="updatecustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="Updatecustomer"></input>
              			<input type="submit" name="btnupdatecustomer" class="links" value="Update" style="border:none;background: none;" />
              			&nbsp;&nbsp;|&nbsp;
              		</form>              		
              	</td>
              	<td valign="top">
              		<form name="Deletecustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="Deletecustomer"></input>
              			<input type="submit" name="btndeletecustomer" class="links" value="Delete" style="border:none;background: none;" />
              		</form>
              	</td>
              </tr>
              </table>
               </td>
           </tr>
         </table>
       </td>
     </tr>
    <%  if(lc!=null && lc.size()>0) { %>
      <form action="CommonServlet" name="frmdel_customer" method="post">
       <input type="hidden" name="iPageNo" id="iPageNo" value="<%=iPageNo%>">
     <input type="hidden" name="cPageNo" id="cPageNo" value="<%=cPageNo%>">
     <input type="hidden" name="ilength" id="ilength" value="<%=ilength%>">
     <input type="hidden" name="myname" value="Deletecustomer"></input>
    <tr>
      <td colspan="5" align="left">&nbsp;</td>
     </tr>
     <tr>
        <td colspan="5" align="left"><div align="right" style="margin-right:15px;" >
         <a href="#" onclick="javascript:callPagination('<%=1%>');"  class="links"> &nbsp;First</a> 
        <a href="#" onclick="javascript:callPagination('<%=cPageNo-1%>');"  class="links">&nbsp;Previous&nbsp;</a>
           <% for(int i=1; i<= itotalpages; i++)
				{
				%> 
				 <a href="#" onclick="javascript:callPagination('<%=i%>');"" class="links" ><%=i%></a>
             <% } %>  
              <a href="#" onclick="javascript:callPagination('<%=cPageNo+1%>');" class="links"> &nbsp;Next</a> 
               <a href="#" onclick="javascript:callPagination('<%=itotalpages%>');"  class="links"> &nbsp;Last</a> 
   </div></td>
       </tr>
     <tr>
      <td colspan="5" align="left">&nbsp;</td>
     </tr>
      <tr>
       	<td colspan="5"><div align="left" style="margin-left:12px;">
           <table width="99%" cellpadding="0" cellspacing="0">
             <tr>
                <td width="3%" style="border-right:1px solid #333333;border-left:1px solid #333333;border-bottom:1px solid #333333;border-top:1px solid #000000; background:#CCCCCC; height:28px;">
            <div align="center">
                      <input type="checkbox" name="allbox" value="on" onClick="CheckAll()">
                     </div>                          
                  </td>
               <td width="2%" style="border-right:1px solid #333333; border-bottom:1px solid #333333; border-top:1px solid #333333; background:#CCCCCC">
<div align="center" style="height:20px;">
                         <img src="images/User.JPG" width="16" height="16">                            
                       </div>                          
                     </td>
         <td width="13%" style="border-right:1px solid #333333; border-bottom:1px solid #333333; border-top:1px solid #333333; background:#CCCCCC">
<div align="center" style="color:#333333;font-size:15px; border:0px solid #000000"> &nbsp;&nbsp;&nbsp;&nbsp;
                        <b>Member Code</b></div>
                      </td>
         <td width="35%" style="border-bottom:1px solid #000000; border-top:1px solid #000000; border-right:1px solid #000000;  background:#CCCCCC">
         <div align="center" style="font-size:15px; border:0px solid #000000"><b>Member First Name</b></div>                          
                      </td>
               <td width="47%" style="border-bottom:1px solid #000000; border-top:1px solid #000000; border-right:1px solid #000000;  background:#CCCCCC">
         <div align="center" style="font-size:15px; border:0px solid #000000"><b> Member Last Name</b></div>                          
                      </td>
             </tr>
             	<% 
					 Iterator<?> it10 = lc.iterator(); 
					 while(it10.hasNext()){ 
					 Object rowData[] = (Object[]) it10.next();
		        %>
		       <tr>
		         <td align="center" style="border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000; height:24px;">
			      <input type="checkbox" name="on1" value="<%= rowData[0] %>">					  
			      </td>
		           <td width="2%" style="border-right:1px solid #000000; border-bottom:1px solid #000000;">
<div align="center" style="background:#ffffff; color:#ffffff; font-size:15px;height:20px; border:0px solid #000000;">
                                            <img src="images/User.JPG">
                                        </div>
                                    </td>
		      <% 
		      for(int j=1;j<rowData.length;j++){ 
		      %>
		      <td align="left" style="border-right:1px solid #000000;margin-left:50px; border-bottom:1px solid #000000;">
		        <div align="left" style="margin-left:12px;"><%=rowData[j] %></div></td> <%} %>
		    </tr><% } %>
		    <tr>
		      <td colspan="5" style="border-bottom:1px solid #000000; border-top:0px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000; background:#CCCCCC; height:26px;">
			   <div align="left"> 
			   <a href="#" onClick="UncheckAll()" style="color:#333333; margin-left:30px">
				<b>Uncheck All</b>						  
			    </a>						 
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
       <td colspan="5" align="left">
        <div align="left" style="margin-left:12px;">
           <input type="submit" value="Delete"  onclick="return Validate();" style="width: 80px;" class="buttons"> &nbsp;&nbsp;&nbsp;
            <a href="Search.jsp" onclick="javascript:cancelAction();"> <input type="button" value="Cancel" style="width: 80px;" class="buttons">
          </a></div>	</td>
    </tr>
       <tr>
        <td colspan="5" align="left"><div align="right" style="margin-right:15px;" >
         <a href="#" onclick="javascript:callPagination('<%=1%>');"  class="links"> &nbsp;First  </a> 
        <a href="#" onclick="javascript:callPagination('<%=cPageNo-1%>');"  class="links"> &nbsp;Previous&nbsp;  </a>
           <% 
				for(int i=1; i<= itotalpages; i++)
				{
				%> 
				 <a href="#" onclick="javascript:callPagination('<%=i%>');"" class="links" ><%= i  %></a>
             <% } %>  
              <a href="#" onclick="javascript:callPagination('<%=cPageNo+1%>');" class="links">&nbsp;Next</a> 
               <a href="#" onclick="javascript:callPagination('<%=itotalpages%>');"  class="links">&nbsp;Last </a> 
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
			
			<b><font color="red">No Customer Found </font> </b> </div></td>
				 </tr></table></td></tr>
       <%} %>
  </form>
  </table>

<%@ include file="includes/footer.jsp" %>
<% if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("Selected records deleted successfully.");
	   </script>
	   <%} %>