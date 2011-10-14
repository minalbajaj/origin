<%@ include file="includes/header.jsp" %>
<% String mytype= (String) session.getAttribute("mytype");
   if(mytype.equals("U"))
   {   
    response.sendRedirect("Search.jsp")	 ;  
   }
%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.Statement" %>
<script type="text/javascript">
function cancelAction()
{
	document.location.href("Search.jsp");
}
function ShowNoBox(typeval){
	if(typeval=='Married'){
		document.getElementById("textbox1").style.display='inline';
		document.getElementById("textbox2").style.display='inline';
		document.getElementById("textbox3").style.display='inline';
	    calendar3 = new Epoch('cal1','popup',document.getElementById('spouse_birth_date'),false);
	}else{
		document.getElementById("textbox1").style.display='none';
		document.getElementById("textbox2").style.display='none';
		document.getElementById("textbox3").style.display='none';
		//document.getElementById("spouse_birth_date").value="";
		
		
	}
} 
function Show(ID){
	if(ID==1)
	{
		document.getElementById('membercodeupd').disabled=false;
		document.getElementById('membernameupd').value==0;
		document.getElementById('membernameupd').disabled=true;
		
    }else
     {
		document.getElementById('membernameupd').disabled=false;
		document.getElementById('membercodeupd').value==0;
		document.getElementById('membercodeupd').disabled=true;
		
     }
}	
	var alphaNumExp = /^[0-9a-zA-Z_ ]+$/;
	var alphaExp = /^[a-zA-Z ]+$/;
	var numericExp = /^[0-9 ]+$/;
	var passwordExp = /^[0-9a-zA-Z_]+$/;
	var phoneNumExp = /^[0-9()-+ ]+$/;
	function Validate1()
	{
		document.getElementById("hdnupdt").value="SubmitFormupdt";
		
	}
	
	function Showinfo()
	{
		if(document.getElementById("membercodeupd").value=="0" &&  document.getElementById("membernameupd").value=="0"){
			alert("Please select member code.");
			document.getElementById("membercodeupd").focus();
			return false;
		}else{
			
			document.frmup_customer.submit();
			return true;
		}		
	}
</script>
	<%
		List<?> Custlist1=(List<?>)request.getAttribute("updatelist1");  
	   String strcustid=(String)request.getAttribute("strcustid");
	   String strcustid1=(String)request.getAttribute("strcustid1");
		List<?> Custlist2=null;
		if(request.getAttribute("updatelist2")!=null){		
			Custlist2=(List<?>)request.getAttribute("updatelist2"); 
		}
		
	%>
	<%!String d1; %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">  
    <tr >
      <td colspan="4">
        <table width="100%" height="23" border="0" align="left" cellpadding="0" cellspacing="0" style="border:0px solid #000000;">
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
              <td><div align="left" style="height:25px;" class="pageheading">Update Customer </div></td>
              <td align="right"><table border="0" cellpadding="0" cellspacing="0">
              <tr>
              	<td valign="top">
	              	<form name="addcustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
	           			<input type="hidden" name="myname" value="Addcustomer"></input>
	           			<input type="submit" name="btnaddcustomer" class="links" value="Add" style="border:none;background: none;" />
	           			&nbsp;&nbsp;|&nbsp;
	           		</form>              	</td>
              	<td valign="top">
              		<form name="updatecustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="Updatecustomer"></input>
              			<input type="submit" name="btnupdatecustomer" class="links" value="Update" style="border:none;background: none;" />
              			&nbsp;&nbsp;|&nbsp;
              		</form>              	</td>
              	<td valign="top">
              		<form name="Deletecustomer" action="CommonServlet" method="post" style="margin:0px 0px 0px 0px;">
              			<input type="hidden" name="myname" value="Deletecustomer"></input>
              			<input type="submit" name="btndeletecustomer" class="links" value="Delete" style="border:none;background: none;" />
              		</form>              	</td>
              </tr>
              </table>            </td>
          </tr>
        </table></td>
    </tr>
    <form name="frmup_customer" method="post" action="CommonServlet">
    <tr>
      <td colspan="5" align="left" >&nbsp;<input type="hidden" name="myname" value="Updatecustomer"></input></td>
    </tr>
    <tr>
      <td colspan="5" align="left"><table width="100%" border="0">
       
        <tr><% 
						if(Custlist2!=null && Custlist2.size()>0 && strcustid1!=null){ 
					%>
         <td width="16%" align="left" valign="top" ><div align="left" style="margin-left:10px;">
      
					<input type="radio" name="rdoShipmentAdd" id="rdoShipmentAdd" value="dbadd"  onclick="javascript:Show('1');" >
					 Member Code
	  </div></td>

          <td width="22%">	<select name="membercodeupd" id="membercodeupd" style="width:182px" disabled="disabled">
					 <option value ="0" >--Select Customer Code--</option>
						<% Iterator<?> it1 = Custlist1.iterator(); 
						Object []rowData=null;
						   while(it1.hasNext()){ 
						   rowData = (Object[]) it1.next(); 
						   Integer z5=(Integer) rowData[0];
						   if(z5.toString().equals(strcustid)){
						   %>
							<option value="<%= rowData[0] %>"  selected="selected"><%= rowData[1] %></option>
							<% 
						} else { 
					%><option value="<%= rowData[0] %>"><%= rowData[1] %></option>
					
						<% } }%> <input type="hidden" name="memberid1" id="memberid1" style="width:175px" value="<%= rowData[0]%>">
			</select></td>
					<%} else { %> <td width="16%" align="left" valign="top" ><div align="left" style="margin-left:15px;">
	  <input type="radio" name="rdoShipmentAdd" id="rdoShipmentAdd" value="dbadd"  onclick="javascript:Show('1');" checked="checked">Member Code
	  </div></td>

          <td width="22%">	<select name="membercodeupd" id="membercodeupd" style="width:182px" >
					 <option value ="0" >--Select Customer Code--</option>
						<% Iterator<?> it1 = Custlist1.iterator(); 
						Object []rowData=null;
						   while(it1.hasNext()){ 
						   rowData = (Object[]) it1.next(); 
						   Integer z5=(Integer) rowData[0];
						   if(z5.toString().equals(strcustid)){
						   %>
							<option value="<%= rowData[0] %>"  selected="selected"><%= rowData[1] %></option>
							<% 
						} else { 
					%><option value="<%= rowData[0] %>"><%= rowData[1] %></option>
				
						<% } }%> <input type="hidden" name="memberid1" id="memberid1" style="width:175px" value="<%= rowData[0]%>">
			</select></td><%} %>	
          <td width="5%">&nbsp;</td><% 
						if(Custlist2!=null && Custlist2.size()>0 && strcustid1!=null){ 
					%>
          <td width="17%">  <input type="radio" name="rdoShipmentAdd" id="rdoShipmentAdd" value="dbadd"  onclick="javascript:Show('2');" checked="checked"> Member Name
	  </div></td>
          <td width="20%">	<select name="membernameupd" id="membernameupd" style="width:182px" >
					 <option value ="0" >--Select Customer Name--</option>
						<% Iterator<?> it6 = Custlist1.iterator(); 
						Object []rowData1=null;
						while(it6.hasNext()){ 
							rowData1 = (Object[]) it6.next();
							System.out.println("gdgg");
						   Integer z5=(Integer) rowData1[0];
						   if(z5.toString().equals(strcustid1)){
							   System.out.println("gdgg");
						   %>
						   
							<option value="<%= rowData1[0] %>"  selected="selected"><%= rowData1[2]+"  "+rowData1[3]%></option>
							<% 
						} else { 
					%><option value="<%= rowData1[0] %>"><%= rowData1[2]+"  "+rowData1[3] %></option>
					
						<% } }%> <input type="hidden" name="memberid1" id="memberid1" style="width:175px" value="<%= rowData1[0]%>">
			</select></td><%}else{ %><td width="17%"><input type="radio" name="rdoShipmentAdd" id="rdoShipmentAdd" value="dbadd"  onclick="javascript:Show('2');" > Member Name
	  </div></td>
          <td width="20%">	<select name="membernameupd" id="membernameupd" style="width:182px" disabled="disabled">
					 <option value ="0" >--Select Customer Name--</option>
						<% Iterator<?> it6 = Custlist1.iterator(); 
						Object []rowData1=null;
						while(it6.hasNext()){ 
							rowData1 = (Object[]) it6.next();
							System.out.println("gdgg");
						   Integer z5=(Integer) rowData1[0];
						   if(z5.toString().equals(strcustid1)){
							   System.out.println("gdgg");
						   %>
						   
							<option value="<%= rowData1[0] %>"  selected="selected"><%= rowData1[2]+"  "+rowData1[3]%></option>
							<% 
						} else { 
					%><option value="<%= rowData1[0] %>"><%= rowData1[2]+"  "+rowData1[3] %></option>
				
						<% } }%>	 <input type="hidden" name="memberid1" id="memberid1" style="width:175px" value="<%= rowData1[0]%>">
			</select></td><%} %>
          <td width="20%"><input type="hidden" name="myname" value="Updatecustomer">
          
					<input type="button" name="btnGet" style="margin-left:10px; width:50px; height:24px" value="Get" onclick="return Showinfo();" class="buttons"></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td colspan="5" align="left" >&nbsp;</td>
    </tr>
   <% System.out.println("hello"+Custlist2);%>
		
			<tr>
			<td colspan="4">
				<div id="001" style="display:inline">
					<% 
						if(Custlist2!=null && Custlist2.size()>0 ){ 
					%>
					<table width="100%" border="0">
  <tr>
    <td colspan="7" style="border-top:1px solid #000000">&nbsp;</td>
    </tr>
  <% System.out.println("hello");
				             Iterator<?> it2= Custlist2.iterator(); 
						     while(it2.hasNext()){ 
						     Object []rowData = (Object[]) it2.next();
						 %>	
					  <input type="hidden" name="memberid2" id="memberid2" style="width:175px" value="<%= rowData[0]%>">
  <tr>
    <td width="13%" align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Title<span style="color:#FF0000"> *</span></div>  </td>
    <td width="3%" align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td width="24%" align="left" valign="top"><div align="left">
          <select name="member_title" id="member_title" style="width:115px">
           <option  value="<%= rowData[1] %>" > <%= rowData[1] %></option>
           <%if(rowData[1].equals("Mr")) { %>
           <option value ="Mrs" >Mrs</option>
             <option value ="Ms" >Ms</option>
             <%} %>
             <%if(rowData[1].equals("Mrs")) { %>
           <option value ="Mr" >Mr</option>
             <option value ="Ms" >Ms</option>
             
             <%}else { %>
           <option value ="Mr" >Mr</option>
             <option value ="Mrs" >Mrs</option>
             <%} %>
            
          </select>
        </div></td>
    <td width="4%">&nbsp;</td>
    <td width="16%" align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Member Code<span style="color:#FF0000"> *</span></div>  </td>
    <td width="2%" align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td width="38%" align="left" valign="top"> 	<input type="text"  value="<%= rowData[2] %>" name="member_code" id="member_code" style="width:175px"></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">First Name<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="first_name" id="first_name"value="<%= rowData[3] %>" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Last Name<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text" name="last_name" id="last_name" value="<%= rowData[4] %>" style="width:175px"></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Address<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
						 <textarea name="member_address" id="member_address"  style="height: 100px" ><%= rowData[5] %></textarea>
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">City<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text" name="member_city" id="member_city" value="<%= rowData[6] %>" style="width:175px"></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
  <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">State<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="member_state" id="member_state" value="<%= rowData[7] %>" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Pin<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text" value="<%= rowData[8] %>" name="member_pin" id="member_pin" style="width:175px"></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
 <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Email<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="member_email" id="member_email" value="<%= rowData[9] %>" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top"> </td>
    <td align="center" valign="top"></td>
    <td> </td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Phone</div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="member_phone" id="member_phone" value="<%= rowData[10] %>" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Mobile<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text" name="member_mobile" id="member_mobile" value="<%= rowData[11] %>" style="width:175px"></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
 <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Gender<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
          <select name="member_gender" id="member_gender" style="width:115px">
           <option  value="<%= rowData[12] %>" > <%= rowData[12] %></option>
           <%if(rowData[12].equals("Male")) { %>
           <option value ="Female" >Female</option>
           
             <%}else { %>
           <option value ="Male" >Male</option>
             
             <%} %>
            
          </select>
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Marital Status<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td> <div align="left">
          <select name="member_status" id="member_status" style="width:115px" onchange="javascript:ShowNoBox(this.value);" >
            <option  value="<%= rowData[13] %>" > <%= rowData[13] %></option>
           <%if(rowData[13].equals("Single")) { %>
            <option value ="Married" >Married</option>
           
             <%}else { %>
            <option value ="Single" >Single</option>
             
             <%} %>
       
          </select>
        </div></td>
  </tr>
  <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Birth Date<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
     <% 
					String sst = null,stt=null;
						
								sst = (rowData[14].toString()).substring(0,10);
								stt = sst.substring(8,10)+"/"+sst.substring(5,7)+"/"+sst.substring(0,4);
					%>
					<input type="text" value="<%= stt %>" name="member_birthdate" id="member_birthdate" size="8" style="border:0px; background-color: white;" readonly="readonly">
    

  
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Wedding Anniversary<span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 
    <% 
					String sst1 = null,stt1=null;
						
								sst1 = (rowData[15].toString()).substring(0,10);
								stt1 = sst1.substring(8,10)+"/"+sst1.substring(5,7)+"/"+sst1.substring(0,4);
					%>
					<input type="text" value="<%= stt %>" name="member_anniversary" id="member_anniversary" size="8" style="border:0px; background-color: white;" readonly="readonly">    	</td>
  </tr>
  
   <tr>
     <td colspan="7">&nbsp;</td>
     </tr>
   <%if(rowData[13].equals("Married")){ %>
    <tr id="textbox1" >
     <td colspan="7" align="left" valign="top">
     
						<div align="left" style="height: 25px;" class="pageheading">Spouse Details :						</div></td>
   </tr>
   <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr id="textbox2" >
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's First Name <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" value="<%= rowData[16] %>" name="spouse_first_name" id="spouse_first_name" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's Last Name <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text"  value="<%= rowData[17] %>" name="spouse_last_name" id="spouse_last_name" style="width:175px"></td>
  </tr>
   <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
  <tr id="textbox3" >
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's Email <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text"  value="<%= rowData[18] %>" name="spouse_email" id="spouse_email" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Birth Date <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top" > <div align="left">
     <% 
					String sst2 = null,stt2=null;
						
								sst2 = (rowData[19].toString()).substring(0,10);
								stt2 = sst2.substring(8,10)+"/"+sst2.substring(5,7)+"/"+sst2.substring(0,4);
					%>
					<input type="text" value="<%= stt2 %>" name="spouse_birth_date" id="spouse_birth_date" size="8" style="border:0px; background-color: white;" readonly="readonly">
     

  
        </div></td>
  </tr>
 <%}else {%>
    <tr id="textbox1" style="display: none;">
     <td colspan="7" align="left" valign="top">
     
						<div align="left" style="height: 25px;" class="pageheading">Spouse Details :						</div></td>
   </tr>
   <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr id="textbox2" style="display: none;">
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's First Name <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="spouse_first_name" id="spouse_first_name" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's Last Name <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"> 	<input type="text" name="spouse_last_name" id="spouse_last_name" style="width:175px"></td>
  </tr>
   <tr>
    <td colspan="7">&nbsp;</td>
    </tr>
   <tr id="textbox3" style="display: none;">
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Spouse's Email <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top"><div align="left">
        <input type="text" name="spouse_email" id="spouse_email" style="width:175px">
        </div></td>
    <td>&nbsp;</td>
    <td align="left" valign="top">
    <div align="left" style="margin-left:15px;" class="labels">Birth Date <span style="color:#FF0000"> *</span></div>  </td>
    <td align="center" valign="top"><div align="center" class="labels"><b>:</b></div></td>
    <td align="left" valign="top" > <div align="left">
       <input type="text" readonly="readonly"  name="spouse_birth_date" id="spouse_birth_date" <% if(d1!=null){ %> value="<%= d1 %>" <% } %>>

  
        </div></td>
  </tr>
 
 <%} }%>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
     <td colspan="7" align="left" valign="top">
		<div align="left" style="height: 25px;" class="pageheading">Family Details :	</div></td>
   </tr>
  
   <tr>
    <td colspan="7">  <div align="left" style="margin-left:10px;">
     <table width="95%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #000000;">
  <tr>
    <td width="20%" height="28px" style="border-right:1px solid #000000;background:#CCCCCC;"><div align="center"><strong><span class="style1">Full Name</span></strong></div></td>
    <td width="18%"  style="border-right:1px solid #000000; background:#CCCCCC;"><div align="center"><strong><span class="style1">Age</span></strong></div></td>
    <td width="20%"  style=" border-right:1px solid #000000;background:#CCCCCC;"><div align="center"><strong><span class="style1">Date of Birth</span></strong></div></td>
    <td width="23%"  style=" border-right:1px solid #000000;background:#CCCCCC;"><div align="center"><strong><span class="style1">Relationship with member</span></strong></div></td>
     <td width="19%"  style=" border-right:1px solid #000000;background:#CCCCCC;"><div align="center"><strong><span class="style1">Sex</span></strong></div></td>
  </tr>
      <tr>
        <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;"> 
          <div align="right">  
            <input type="text" name="frstrwfullname" id="frstrwfullname" style="text-align:right;margin-right:2px "  />
          </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" name="frstrwage" id="frstrwage" style="text-align:right;margin-right:2px "  />
         </div></div></td>
       <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" readonly="readonly"  name="frstrwdate" id="frstrwdate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %> style="text-align:right;margin-right:2px ">
         </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
          <input type="text" name="frstrwrelation" id="frstrwrelation" style="text-align:right;margin-right:2px "  />
         </div></div></td>
         <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
         <select name="frstrwgender" id="frstrwgender" style="text-align:right;margin-right:2px ">
          <option value ="Male" >Male</option>
            <option value ="Female" >Female</option>
          </select>
        </div></div></td>
      </tr>
       <tr>
        <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;"> 
          <div align="right">  
            <input type="text" name="secondrwfullname" id="secondrwfullname" style="text-align:right;margin-right:2px "  />
          </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" name="secondrwage" id="secondrwage" style="text-align:right;margin-right:2px "  />
         </div></div></td>
       <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" readonly="readonly"  name="secondrwdate" id="secondrwdate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %> style="text-align:right;margin-right:2px ">
         </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
          <input type="text" name="secondrwrelation" id="secondrwrelation" style="text-align:right;margin-right:2px "  />
         </div></div></td>
         <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
         <select name="secondrwgender" id="secondrwgender" style="text-align:right;margin-right:2px ">
          <option value ="Male" >Male</option>
            <option value ="Female" >Female</option>
          </select>
        </div></div></td>
      </tr>
       <tr>
        <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;"> 
          <div align="right">  
            <input type="text" name="thirdrwfullname" id="thirdrwfullname" style="text-align:right;margin-right:2px "  />
          </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" name="thirdrwage" id="thirdrwage" style="text-align:right;margin-right:2px "  />
         </div></div></td>
       <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" readonly="readonly"  name="thirdtrwdate" id="thirdtrwdate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %> style="text-align:right;margin-right:2px ">
         </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
          <input type="text" name="thirdrwrelation" id="thirdrwrelation" style="text-align:right;margin-right:2px "  />
         </div></div></td>
         <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
         <select name="thirdrwgender" id="thirdrwgender" style="text-align:right;margin-right:2px ">
          <option value ="Male" >Male</option>
            <option value ="Female" >Female</option>
          </select>
        </div></div></td>
      </tr>
        <tr>
        <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;"> 
          <div align="right">  
            <input type="text" name="forthrwfullname" id="forthrwfullname" style="text-align:right;margin-right:2px "  />
          </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" name="forthrwage" id="forthrwage" style="text-align:right;margin-right:2px "  />
         </div></div></td>
       <td style="border-top:1px solid #000000;">
         <div align="left" style="margin-left:4px;">  
         <div align="right">  
           <input type="text" readonly="readonly"  name="forthrwdate" id="forthrwdate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %> style="text-align:right;margin-right:2px ">
         </div></div></td>
       <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
          <input type="text" name="forthrwrelation" id="forthrwrelation" style="text-align:right;margin-right:2px "  />
         </div></div></td>
         <td style="border-top:1px solid #000000;"><div align="left" style="margin-left:4px;">  <div align="right">  
         <select name="forthrwgender" id="forthrwgender" style="text-align:right;margin-right:2px ">
          <option value ="Male" >Male</option>
            <option value ="Female" >Female</option>
          </select>
        </div></div></td>
      </tr>
</table>
</div>    </td>
    </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
						<td align="left">&nbsp;</td>
						<td align="left" valign="top">&nbsp;</td>
						<td align="left" colspan="5">
						<div align="left"> <input type="hidden" name="hdnupdt" id="hdnupdt" value=""></input>
				        <input type="submit" name="save" value="Update" onClick="return Validate1();" class="buttons" style="width: 80px;">
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				         <a href="Search.jsp" onclick="javascript:cancelAction();"><input type="button" class="buttons" value="Cancel" style="width: 80px;">
				     </a> </div></td>
					</tr>
                    <tr>
						<td colspan="7" align="left">&nbsp;</td>
					</tr>
</table>
				  <% } %>	
				</div>			</td>
		</tr>
	</form>
  </table>
<%@ include file="includes/footer.jsp" %>
<%if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("Customer updated successfully.");
	   </script>
	   <%} %>