<%@ include file="includes/header.jsp" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<script type="text/javascript">

	function OpenPopup(optval,entertext,invoiceid,orderid){
		var w = 850;
		var h = 900;
		var winl = (screen.width-w)/2;
		var wint = (screen.height-h)/2;
		if (winl < 0) winl = 0;
		if (wint < 0) wint = 0;
		var page = "searchServlet?optval="+optval + "&entertext="+entertext + "&invoiceid="+invoiceid+ "&orderid="+orderid;
		windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,"
		+ "scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=yes";
		window.open(page, "Popup", windowprops);
	}
	function callPagination(iPageNo)
	{
		document.getElementById("iPageNo").value=iPageNo;
		document.frmsearch_order1.submit();
	}
	function ShowMyDiv(divid, myval2)
	{
		if(divid=="1"){	
			window.location.href='Search.jsp?str='+myval2;
			document.getElementById("divDate").style.display='inline';
			document.getElementById("divCmb").style.display='none';
		}else if(divid=="2"){
			window.location.href='Search.jsp?str='+myval2;
			document.getElementById("divDate").style.display='none';
			document.getElementById("divCmb").style.display='inline';
		}
		else if(divid=="3"){
			window.location.href='Search.jsp?str='+myval2;
			document.getElementById("divDate").style.display='none';
			document.getElementById("divCmb").style.display='inline';
		}
		else if(divid=="4"){
			window.location.href='Search.jsp?str='+myval2;
			document.getElementById("divDate").style.display='none';
			document.getElementById("divCmb").style.display='inline';
		}
	}
		
	function ValidateVal()
	{
		var numericExp = /^[0-9 ]+$/;
		if(document.getElementById("entertext").value=="" )
		{
			alert("Please enter search details");
			document.getElementById.entertext.focus();
			return false;
	    }
	   else if(document.getElementById("hdnOptVal").value=="invoicenumber" && !document.getElementById("entertext").value.match(numericExp))
		{
			alert("Please enter number");
			document.getElementById("entertext").value="";
			document.getElementById.entertext.focus();
			return false;
		}
		else
		{
			document.frmsearch_order1.submit();
			return true;
		}
	}
	
	function ShowDate()
	{
		if(document.getElementById("txtfromdate").value=="")
		{
		alert("Please select from date");
		document.getElementById.txtfromdate.focus();
		document.getElementById.txttodate.focus();
		return false;
	    }
		if(document.getElementById("txttodate").value=="")
		{
		alert("Please select to date");
		document.getElementById.txtfromdate.focus();
		document.getElementById.txttodate.focus();
		return false;
	    }
		 if(document.getElementById("txtfromdate").value > document.getElementById("txttodate").value)
		{
			alert("From date should be smaller");
			document.getElementById.txtfromdate.focus();
			document.getElementById.txttodate.focus();
			return false;
		}
		 else
		 {
			 document.frmsearch_order1.submit();
			return true;
		 }
	}
	</script>
	<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" /> 
	<script type="text/javascript" src="javascript/epoch_classes.js"></script> 
	<script language="javascript" src="javascript/cal2.js"></script>
	<script type="text/javascript"> 
	var calendar1, calendar2;  
	window.onload = function() 
	{ 
		calendar1 = new Epoch('cal1','popup',document.getElementById('txtfromdate'),false); 
		calendar2 = new Epoch('cal2','popup',document.getElementById('txttodate'),false);
	
 	}; 
 	addCalendar("Calendar1", "Select Date", "txtfromdate", "frmsearch_order1");
 	addCalendar("Calendar2", "Select Date", "txttodate", "frmsearch_order1");
 	 setWidth(90, 1, 15, 1);
 	</script> 
	<!--<script language="javascript" src="javascript/cal2.js"></script>
	<script language="javascript" src="javascript/cal_conf2.js"></script>
-->
<%!
	DateFormat df =  new SimpleDateFormat("dd-mm-y");
	Date date;
	String strFlag="False";
%>
<% 
 List<?> lstrsCount=null,lstrsResult=null;
if(request.getAttribute("lstrsCount")!=null){
	lstrsCount=(List<?>)request.getAttribute("lstrsCount"); 
	lstrsResult=(List<?>)request.getAttribute("lstrsResult"); 
}
String textdata="empty";
String r="" ;
	String myval="empty";
	if(request.getParameter("hdnOptVal")!=null)
	{
		myval=(String) request.getParameter("hdnOptVal");
	}
	String d1=null,d2=null;
	if(myval.equals("date")){
		d1=(String) request.getAttribute("serhdate1");
		d2=(String) request.getAttribute("serhdate2");		
	}else if(myval.equals("invoicenumber") || myval.equals("ordernumber") || myval.equals("orderCustomerName") || myval.equals("orderProductName") && request.getAttribute("entertext")!=null){
		textdata= (String) request.getAttribute("entertext");		
	}
%>
<% 
int istart=0;
int iPageNo=0;
int cPageNo=1;
int itotalpages=0;
int ilength=10;
String str=null;

if(request.getAttribute("itotalpages")!=null){	
	itotalpages=Integer.parseInt(request.getAttribute("itotalpages").toString()); 
	cPageNo=Integer.parseInt(request.getAttribute("cPageNo").toString());
	iPageNo=Integer.parseInt(request.getAttribute("iPageNo").toString());
	ilength=Integer.parseInt(request.getAttribute("ilength").toString());
	str=(String)request.getAttribute("strTotalCnt");
}
%>
<form name="frmsearch_order1" method="POST" action="CommonServlet">
<input type="hidden" name="hdnOptVal" id="hdnOptVal" value="<%=myval %>">
<input type="hidden" name="hdnInvoiceVal" id="hdnInvoiceVal" value=""></input>
<input type="hidden" name="iPageNo" id="iPageNo" value="<%=iPageNo%>">
<input type="hidden" name="cPageNo" id="cPageNo" value="<%=cPageNo%>">
<input type="hidden" name="ilength" id="ilength" value="<%=ilength%>">
 <input type="hidden" name="myname" id="myname" value="searchpage"></input>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
<tr>
  <td colspan="3">&nbsp;</td>
</tr>
 <tr>
    <td colspan="3"><div align="left" class="pageheading">Search Invoice</div></td>
<tr>
  <td colspan="3">&nbsp;</td>
</tr>
<tr>
	<td width="17%" colspan="3"><div align="left" style="margin-left:15px;" class="labels">Search By <b>:</b></div></td>
</tr>
<tr>
			<td></td>
			<td align="center" width="3%">
		      <div align="center">
		        <input type="radio" name="rd1" id="rd1"<% if ((myval.equals("date")) || (d1!=null) || (d2!=null)){  %> checked="checked" <%} %> value="date" onClick="javascript:document.getElementById('hdnOptVal').value=this.value; document.frmsearch_order1.submit();">			
	            </div></td>
			<td width="80%"><div align="left" >
			  <input type="text" readonly="readonly" style=" border:0px solid #666666" class="labels" value="Member code ">
			  </div></td>
	</tr>
	<tr>
			<td></td>
			<td align="center" width="3%">
			  
		      <div align="center">
		        <input type="radio" name="rd1" id="rd1"<% if (myval.equals("invoicenumber")){  %> checked="checked" <%} %> value="invoicenumber" onClick="javascript:document.getElementById('hdnOptVal').value=this.value; document.getElementById('entertext').value=''; document.frmsearch_order1.submit();">			
	            </div></td>
			<td width="80%" ><div align="left"  >
			  <input type="text" readonly="readonly" style=" border:0px solid #666666" class="labels" value="Member Name">
			  </div></td>
	</tr>
			<tr>
			<td></td>
					<td align="center" >
					  <div align="center">
					    <input type="radio" name="rd1" id="rd1" <% if (myval.equals("ordernumber")){  %> checked="checked" <%} %> value="ordernumber" onClick="javascript:document.getElementById('hdnOptVal').value=this.value; document.getElementById('entertext').value='';document.frmsearch_order1.submit();">
			          </div></td>
			  <td ><div align="left" >
			    <input type="text" readonly="readonly" style=" border:0px solid #666666"  class="labels" value="Card No. ">
		      </div></td>
			</tr>
			<tr>
			<td></td>
					<td align="center" >
					  <div align="center">
					    <input type="radio" name="rd1" id="rd1"<% if (myval.equals("orderCustomerName")){  %> checked="checked" <%} %> value="orderCustomerName" onClick="javascript:document.getElementById('hdnOptVal').value=this.value;  document.getElementById('entertext').value='';document.frmsearch_order1.submit();">
				      </div>
			  <td ><div align="left">
			    <input type="text" readonly="readonly" style=" border:0px solid #666666" class="labels" value="By transaction">
		      </div></td>
			</tr>
			<tr>
			<td></td>
					<td align="center" >
					  <div align="center">
					    <input type="radio" name="rd1" id="rd1" <%if (myval.equals("orderProductName")){  %> checked="checked" <%} %>  value="orderProductName" onClick="javascript:document.getElementById('hdnOptVal').value=this.value; document.getElementById('entertext').value='';document.frmsearch_order1.submit();">
				      </div>
			  <td ><div align="left" >
			    <input type="text" readonly="readonly" style=" border:0px solid #666666" class="labels" value="Product Name ">
		      </div></td>
			</tr>
			<tr>
			  <td colspan="3">&nbsp;</td>
    </tr>
			<tr>
			<td colspan="3">
				<div align="left" id="divCmb" <% if (myval.equals("invoicenumber") || myval.equals("ordernumber")|| myval.equals("orderCustomerName") || myval.equals("orderProductName")){  %> style="display:inline;" <%}else{ %>style="display:none;" <%} %>>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="26%" >
						  <div align="left" style="margin-left:15px;" class="labels">Please enter search details <b>:</b></div></td>
						  <td width="18%">
						  <input type="text"  size="25" <% if (textdata!=null){ if (textdata.equals("empty")){   %>  value=""  <% }else{ %>value="<%=textdata%>"<%}} %> name="entertext" id="entertext" ></input></td>
						  <td width="56%" >
<div style="margin-top:0px ;margin-left:15px" >
									<div align="left">
									  <input type="button" name="getdate" id="getdate" class="buttons" style="margin-left:10px; width:50px; height:24px" value="Get" onClick="javascript:ValidateVal();"  >
			      </div>
						  </div></td>
					  </tr>
					</table>
				</div>
				<%	if(myval.equals("date")) { %>
  <div align="left" id="divDate"> 
  <table border="0" cellpadding="0" cellspacing="0" width="96%">
						<tr>
							<td width="14%">
						  <div align="left" style="margin-left:15px;" class="labels">From Date <b>:</b>	</div></td>
						  <td width="14%">
						<input type="text" readonly="readonly" name="txtfromdate" id="txtfromdate" <% if(d1!=null){ %> value="<%= d1 %>" <% } %>>
						 </td>
						<td width="6%">
<!--						<img src="images/cal.JPG" onClick="javascript:showCal('Calendar1')" name="btnGetDate1" style="margin-left:2px;">-->
							</td>
							<td width="10%">
						  <div align="left" style="margin-left:0px" class="labels">To Date <b>:</b></div>	</td >
						  <td width="12%"><input type="text" readonly="readonly" id="txttodate" name="txttodate" <% if(d1!=null){ %> value="<%= d2 %>"  <% } %>></td>
							<td width="7%">
<!--						<img src="images/cal.JPG" onClick="javascript:showCal('Calendar2')" name="btnGetDate2" style="margin-left:2px;">-->
							</td>
						  <td width="37%"><div align="left">
						    <input type="button" name="Show" id="Show" class="buttons" style="margin-left:10px; width:50px; height:24px" onClick="return ShowDate();" value="Show"/>
					      </div></td>
			</tr>						
		    </table>		    
			</div>
			<%} %></td></tr>
		<% 
	if(myval.equals("orderProductName") && lstrsResult!=null && !textdata.equals("")){
	%>
    <tr>
	<td colspan="3" align="center">	
    <div align="center">
    <%
		Integer intsno=0;
		if(lstrsResult.size()>0){
			strFlag="True";
			Iterator <?> ipro  = lstrsResult.iterator();
			String s="";
			Integer i=0;
	%>
<br >
		<table align="center" width="96%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="7%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div  align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>Invoice No.</b></div></td>
			
			<td width="8%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>Ordered Qty</b></div></td>
			
			<td width="10%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>Dispatched Qty</b></div></td>
			
			<td width="10%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>Dispatching Qty</b></div></td>
            
          
                
            <td width="10%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			  <b>Amendment Qty</b></div></td>
                
             <td width="11%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			  <b>Amendment Cost</b></div></td>
			
			<td width="13%" align="right" style="border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>Amount</b></div></td>
			
			<td width="9%" align="right" style="border-right:1px solid #333333;   border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #333333;  background:#007CF9">
				<div  align="center" style="color:#FFFFFF;font-size:14px;margin-top:5px; margin-bottom:5px ;margin-left:5px;margin-right:5px; " class="labels">
			<b>View </b></div></td>			
			</tr>
			<% String invoiceno = "No invoice";
			String cusorderno = "No order";
			String qty = "No qty";
			String cname = "No customer";
			String odate = "";
			String dispatched="";
			String dispatching="";
			String amount="";
			int corderno=0;
				while(ipro.hasNext())
				{ 	intsno++;
					Object []  p1 = (Object[] ) ipro.next();
					if(p1[5]!=null )
					{
						invoiceno = p1[5].toString();
					}
					else
					{
						invoiceno = "-";
					}
					if(p1[7]!=null )
					{
						cusorderno = p1[7].toString();
					}
					else
					{
						cusorderno = "-";
					}
					if(p1[3]!=null )
					{
						qty = p1[3].toString();
					}
					else
					{
						qty = "-";
					}
					if(p1[8]!=null )
					{
						dispatched = p1[8].toString();
					}
					else
					{
						dispatched = "-";
					}
					if(p1[9]!=null )
					{
						dispatching = p1[9].toString();
					}
					else
					{
						dispatching = "-";
					}
				
				if(!s.equals(p1[1])|| !cname.equals(p1[6]) ){
						intsno=1;
						if(!s.equals(p1[1]))
						{
							s= (String) p1[1];	
				%>
						<tr>
						  <td colspan="6" align="left" style=" background:#B9B9B9 ;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px; font-size:15px;" class="labels">
							<b>Product Name &nbsp; : &nbsp;<%= s  %></b></div>
							</td>
							 <td colspan="4" align="left" style=" background:#B9B9B9 ;height:22px;border-bottom:1px solid #000000;border-right:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px; font-size:15px ;" class="labels">
							<b>Product Cost &nbsp;:&nbsp;
							<% Double formatcost3 = (Double)p1[2];
							NumberFormat formatter1 = new DecimalFormat("#0.00");
							p1[2] =(formatter1.format(formatcost3)); %> <%= p1[2]  %>
					</b></div>
							</td>
						</tr>
						<% } %>	
							<% if(p1[6]!=null)
						{ 
							if(!cname.equals(p1[6])){
								cname=(String)p1[6];
							%>
					<tr>
                        <td colspan="10" align="left" style=" background:#E9E9E9 ;height:22px;border-left:1px solid #000000; border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
			
							<b>Customer Name :&nbsp;<%=cname %> <% //cname = p1[6].toString(); %></b></div>
							</td></tr><% }
							 if(corderno!=(Integer)p1[4] ){
								 corderno= (Integer) p1[4];
							%>	<tr>
                        <td colspan="6" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
							<b>Customer Order No :&nbsp;<%=cusorderno %></b></div>
							</td>
							
							 <td colspan="4" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000; border-right:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
			<b>Order date :</b>
				<% if(p1[11]!=null) {%>
				<% 
						String s1,s2;
						s1=(p1[11].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
						<b><%= s2  %></b>
					
					<% } else{ %>
							<b><%=odate %></b></div>
							<% } %>
							</td> 
							</tr>
                            
                            <tr>
                        <td colspan="6" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
							<b>Amendment  No :&nbsp; <% if(p1[14]==null){ %>
						Not Available						
						<% }else{ %>
					 <%= p1[14]  %>
                     <% } %></b></div>
							</td>
							
							 <td colspan="4" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000; border-right:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
			<b>Amendment date :</b>
			<% if(p1[15]==null){ %>
			<b>Not Available</b>
			<% }else{ %>
         				<% 
							String s19,s29;
							s19=(p1[15].toString()).substring(0,10);
							s29=  s19.substring(0,2)+"/"+s19.substring(3,5)+"/"+s19.substring(6,10);
						%>
					 <%= s29  %>
                     <% } %> </div>
							</td> 
							</tr>
                            
							<% } }%>
							
            
          
			
			<%} else {
					if(corderno!=(Integer)p1[4] && !p1[6].equals("No Customer")){
						intsno=1;
						corderno= (Integer) p1[4];	%>
							<tr>
                        <td colspan="6" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
							<b>Customer Order No :&nbsp;<%=cusorderno %></b></div></td>
						<td colspan="4" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000; border-right:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
			<b>Order date :</b>
				<% 
						String s1,s2;
						s1=(p1[11].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
						<b><%= s2  %></b>
			</div></tr>	
            
            
            
               <tr>
                        <td colspan="6" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
							<b>Amendment  No :&nbsp; <% if(p1[14]==null){ %>
							Not Available
							<% }else{ %>
					 <%= p1[14]  %>
                     <% } %></b></div>
				 </td>
							
							 <td colspan="4" align="left" style=" background:#E9E9E9 ;height:22px;border-bottom:1px solid #000000; border-right:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
			<b>Amendment date :</b>
			<% if(p1[15]==null){ %>
			<b>Not Available</b>
			<% }else{ %>
         				<% 
							String s19,s29;
							s19=(p1[15].toString()).substring(0,10);
							s29=  s19.substring(0,2)+"/"+s19.substring(3,5)+"/"+s19.substring(6,10);
						%>
					 <%= s29  %>
                     <% } %> </div>
							</td> 
							</tr>
            
            
            
            
            
            
            
            
            
            
            
            
            
            <tr>
				<% }} %>
			  <td align="right" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000;">
			<div style="margin-right:10px;" class="labels"><%= invoiceno  %></div></td>
			
			<td align="right" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; ">
			<div style="margin-right:10px;" class="labels"><%= qty  %></div></td>
			
			<td align="right" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; ">
			<div style="margin-right:10px;" class="labels"><%= dispatched  %></div></td>
			
			<td align="right" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; ">
			<div style="margin-right:10px;" class="labels"><%= dispatching  %></div></td>
            
          
                  
                  
		 	  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				  <% if(p1[12]==null){ %>
						- 						
						<% }else{ %>
         				 <%= p1[12]  %>
                     <% } %>
						</div></td>
                  
                        
               	  <td width="11%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
				<% if(p1[13]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost22 = (Double)p1[13];
						NumberFormat formatter22 = new DecimalFormat("#0.00");
						p1[13] =(formatter22.format(formatcost22));%>
				  <%= p1[13]  %>
						<% 	} %>
				  </div></td>
						
			  <td align="right" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; ">
			<div style="margin-right:10px;" class="labels">
				<% if(p1[10]!=null)
					{
					Double formatcost4 = (Double)p1[10];
					NumberFormat formatter4 = new DecimalFormat("#0.00");
					p1[10] =(formatter4.format(formatcost4));%>
						<%= p1[10]  %>
					<% }else if(p1[10]==null  &&  !cname.equals("No Customer"))
					{
						amount = "-";%>
						<%= amount  %>
						
					<% }%>
						</div></td>
										
						<td align="center" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<% if(invoiceno!="-"){%>
					<div style="margin-left:10px; cursor: pointer;" onclick="javascript:OpenPopup('<%= myval %>','<%= textdata %>','<%= p1[5] %>','<%= p1[4] %>');" class="links">
					  <div align="center"><img src="images/view.png" width="32" height="32"></div>
					</div>
			<%}else {%>
					<div style="margin-left:10px; cursor: pointer;"  class="links">-</div>
			<%} %></td>
				</tr>
			<%} %>
						</table>
	<% }else{  %> 
		<br>
				 <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0">
				 <tr>
				<td align="right" style="height:22px; border-bottom:1px solid #000000; border-left:1px solid #000000; border-top:1px solid #000000; ">
					<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;">				</div></td>				
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; border-top:1px solid #000000; ">
				<div style=" margin-left:5px;"  align="left" class="labels"><b><font color="red">No Data Found </font></b></div>           		</td>
				 </tr>
               </table>              
	<% } %>
       </div></td></tr>
	<%  }else if(myval.equals("orderCustomerName") && lstrsResult!=null && !textdata.equals("")){%>
    <tr>
	<td colspan="3" align="center">	
    <div align="center">
    <%
				if(lstrsResult.size()>0 ) {
						strFlag="True";
						Iterator<?> icus  = lstrsResult.iterator();
						String s="";
						Integer p=0;
						Integer intsno=0;
						int corderno=0;
					%>
	<br>
	<div >
		<table width="96%" align="center"  border="0" cellpadding="0" cellspacing="0" >
			<tr>			
			<td width="5%"  align="center" style="border-right:1px solid #333333;  border-left:1px solid #000000;   border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Invoice No.</b></div></td>
            
			<td width="19%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Product Name</b></div></td>
			
			<td width="5%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Ordered Qty</b></div></td>
            
            <td width="7%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Dispatched Qty</b></div></td>
            
            <td width="8%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Dispatching Qty</b></div></td>
            
			<td width="8%" align="right"  style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Rate</b></div></td>
            
             
                
                <td width="7%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Qty</b></div></td>
                
                <td width="7%" align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Cost</b></div></td>
                
            <td width="10%" align="right"  style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Amount</b></div></td>
			
				<td width="10%" align="right"  style="border-right:1px solid #333333;   border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>View </b></div></td>
			</tr>
			<%	String invoiceno = "No invoice", strCOrdno="";
				while(icus.hasNext())
				{
					intsno++;
					Object []  p1 = (Object[]) icus.next();
					if(p1[8]!=null)
					{
						invoiceno = p1[8].toString();
					}
					else
					{
						invoiceno = "-";
					}
					if(!s.equals(p1[1].toString())){
						intsno=1;
						s= (String) p1[1];	
						p= (Integer) p1[2];	
				%>
				<tr>
				<td colspan="12"  align="left" style="background:#B9B9B9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-top:5px; margin-bottom:5px; font-size:15px" class="labels">
				  <b>Customer Name : <%= s  %></b></div></td>
						</tr>
						<% 
					}
					if(corderno!=(Integer)p1[2]){
						strCOrdno=p1[2].toString();
						corderno= (Integer) p1[2];
						%>
						<tr>
						<td  colspan="6" align="left" style="background:#E9E9E9;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;" class="labels">
						<b>Customer Order No : <input type="text" name="cus_orderno" value="<%= p1[9] %>" style="font-weight:bold; border: 0px; background:#E9E9E9; " readonly="readonly"></b></div></td>
						
						<td  colspan="6" align="right" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;" class="labels">
						<b>Order date : 
						<% 
						String s1,s2;
						s1=(p1[4].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
						<%= s2  %>	</b></div></td>
									</tr>	
                                    
                                    
                        <tr>
						<td  colspan="6" align="left" style="background:#E9E9E9;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;" class="labels">
						<b>Amendment No : <% if(p1[15]==null){ %>
						Not Available						
						<% }else{ %>
					 <%= p1[15]  %>
                     <% } %></b></div></td>
						
						<td  colspan="6" align="right" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;" class="labels">
						<b>Amendment date : 
						 <% if(p1[16]==null){ %>
							Not Available					
						<% }else{ %>
         				<% 
							String s15,s25;
							s15=(p1[16].toString()).substring(0,10);
							s25=  s1.substring(0,2)+"/"+s15.substring(3,5)+"/"+s15.substring(6,10);
						%>
					 <%= s25  %>
                     <% } %> 	</b></div></td>
									</tr>   
                                    			
				<%} else {
					if(corderno!=(Integer)p1[2]){
						intsno=1;
						corderno= (Integer) p1[2];	%>
						<tr>
							<td  colspan="6" align="left" style="background:#E9E9E9;height:22px;border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;" class="labels">
						<b>Customer Order No : <input type="text" name="cus_orderno" value="<%= p1[9] %>" style="font-weight:bold;  border: 0px; background:#E9E9E9; " readonly="readonly"></b></div></td>
						
							<td  colspan="6" align="right" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-right:5px;margin-bottom:5px;" class="labels">
						<div align="left"><b>Order date : 
						  <% 
						String s1,s2;
						s1=(p1[4].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
					      <%= s2  %></b> </div>
			</div></td>
						<%} %>
						</tr>
				<%} %>
				<tr>
						<td align="right" style="height:22px;border-left:1px solid #000000 ;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
			<input type="text" name="s_invoiceno1" value="<%= invoiceno %>"  class="labels" style="border: 0px; text-align: right; width:50px;" readonly="readonly">	</div></td>
						
					<td align="left" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-left:5px;" class="labels">
						<%= p1[5]  %></div></td>
						
							<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
			
						<%= p1[7]  %></div></td>
						
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<% if(p1[10]==null){%>-
						<% }else{ %>
						<%= p1[10]  %><% } %>
					</div></td>
						
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
				<% if(p1[11]==null){%>-
						<% }else{ %>
						<%= p1[11]  %><% } %>
					</div></td>
                    
                    
							<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
			<% Double formatcost23 = (Double)p1[6];
						NumberFormat formatter23 = new DecimalFormat("#0.00");
						p1[6] =(formatter23.format(formatcost23));%>
				  <%= p1[6]  %>
						
                        </div></td>
                        
			
                  
                  
			 	  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				  <% if(p1[13]==null){ %>
						- 						
						<% }else{ %>
         				 <%= p1[13]  %>
                     <% } %>
						</div></td>
                  
                        
               	  <td width="7%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
				<% if(p1[14]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost22 = (Double)p1[14];
						NumberFormat formatter22 = new DecimalFormat("#0.00");
						p1[14] =(formatter22.format(formatcost22));%>
				  <%= p1[14]  %>
						<% 	} %>
				  </div></td>
						
				  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<% if(p1[12]==null){%>-
						<% }else{ %>
							<% Double informat3 = (Double)p1[12];
				NumberFormat formatter3 = new DecimalFormat("#0.00");
				p1[12] =(formatter3.format(informat3)); %>
						<%= p1[12]  %> <% } %></div></td>
						
						<td align="center" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<% if(invoiceno!="-")
				{
				%>
				<div style="margin-left:10px; cursor: pointer;" onclick="javascript:OpenPopup('<%= myval %>','<%= textdata %>','<%= p1[8] %>','<%= p1[2] %>');" class="links">
						 <div align="center"><img src="images/view.png" width="32" height="32"></img>	 </div>
				</div>
						  <%}else {%>
						  
						  <div style="margin-left:10px; cursor: pointer;"  class="links">
						  - </div><%} %>						  </td>
				</tr>
				 <%} %>
				 </table></div>
<% } else {   %> 
				 <br>
				 <div >
				 <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0">
				 <tr>
				 <td align="right" style="height:22px; border-bottom:1px solid #000000; 
				border-left:1px solid #000000; border-top:1px solid #000000;  ">
			<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;"></img>				</div></td>
				
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; 
				border-top:1px solid #000000; ">
			<div style=" margin-left:5px;"  align="left" class="labels">
			
			<b><font color="red">No Data Found </font> </b> </div></td>
				 </tr></table> </div>
				 <% }%>
	    </div>        </td></tr>
<% } else if(myval.equals("invoicenumber") && lstrsResult!=null && !textdata.equals("")){ %>
<tr>
	<td colspan="3" align="center">	
    <div align="center">
<%
				if(lstrsResult!=null && lstrsResult.size()>0 ){
					strFlag="True";
					Iterator <?> invoice = lstrsResult.iterator();
					String s1="";
					Integer p=0;
					Integer intsno=0;
					%>
	<br>
	<div >
		<table width="96%" align="center"  border="0" cellpadding="0" cellspacing="0" >
			 <tr>
			<td width="24%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; border-left:1px solid #000000; background:#007CF9">
			<div align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Product Name</b></div></td>
			<td width="15%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000;  background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Product Cost</b></div></td>
			<td width="6%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000;  background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Ordered Qty</b></div></td>
			<td width="6%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000;  background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Dispatched Qty</b></div></td>
			<td width="7%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000;  background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Dispatching Qty</b></div></td>
                
                <td width="8%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; background:#007CF9">
<div align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Qty</b></div></td>
                
                <td width="8%" align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000;  background:#007CF9">
<div align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Cost</b></div></td>
                
			<td width="17%" align="right" style="border-right:1px solid #333333;   border-top:1px solid #000000; background:#007CF9">
			<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>Amount</b></div></td>
				<td width="9%" align="right"  style="border-right:1px solid #333333;   border-top:1px solid #000000;background:#007CF9">
			<div  align="center" style="color:#FFFFFF;font-size:14px;" class="labels">
			<b>View </b></div></td>
			</tr>
			<%
				while(invoice.hasNext())
				{
					intsno++;
					Object []  p1 = (Object[]) invoice.next();
					if(!s1.equals(p1[7])){
						intsno=1;
						s1= (String) p1[7];	
				%>
				<tr>
				<td colspan="6" align="right" style="  border-left:1px solid #000000; border-top:1px solid #000000; border-bottom:1px solid #000000; background:#B9B9B9">
				<div  align="center" style="color:#333333;font-size:15px; margin-top:5px; margin-bottom:5px; margin-left:5px; " class="labels">
			      <div align="left"><b>Invoice No.  &nbsp; &nbsp; &nbsp; &nbsp;: <%= p1[0]  %></b></div>
				</div></td>
			
			<td colspan="5" align="right"  style="border-right:1px solid #333333; border-top:1px solid #000000; border-bottom:1px solid #000000; background:#B9B9B9">
			<div  align="center" style="color:#333333;font-size:15px; margin-top:5px; margin-bottom:5px;" class="labels">
			  <div align="left"><b>Customer Order No. : <%= p1[7] %></b></div>
			</div></td>
			  </tr>
				<tr>
				<td  colspan="6" align="right"  style="  border-left:1px solid #000000;background:#E9E9E9">
			<div  align="center" style="color:#333333;font-size:15px;  margin-left:5px;margin-top:1px;" class="labels">
			  <div align="left"><b>Customer Name : <%= p1[6] %></b></div>
			</div></td>
				
			<td colspan="5" align="right" style=" border-right:1px solid #333333; background:#E9E9E9">
				<div  align="center" style="color:#333333;font-size:15px;" class="labels">
			      <div align="left"><b>Advance : 
			        <% Double informat2 = (Double)p1[4];
				NumberFormat formatter2 = new DecimalFormat("#0.00");
				p1[4] =(formatter2.format(informat2)); %>
			        <%= p1[4]  %></b></div>
				</div></td>
			  </tr>
						<tr>
						<td colspan="6" align="right" style=" border-left:1px solid #000000;background:#E9E9E9">
			<div  align="center" style="color:#333333;font-size:15px;  margin-left:5px; " class="labels">
			  <div align="left"><b>Total Amount  &nbsp; &nbsp;: 
			        <% Double informat1 = (Double)p1[2];
				NumberFormat formatter3 = new DecimalFormat("#0.00");
				p1[2] =(formatter3.format(informat1)); %>
			    <%= p1[2]  %></b></div>
                
			</div></td>
          <td colspan="5" align="right"  style="border-right:1px solid #333333; background:#E9E9E9">
			<div  align="center" style="color:#333333;font-size:15px;" class="labels">
			  <div align="left"><b>Net Payable : 
			    <% Double informat3 = (Double)p1[5];
				NumberFormat formatter1 = new DecimalFormat("#0.00");
				p1[5] =(formatter1.format(informat3)); %>
			    <%= p1[5]  %></b></div>
			</div></td>
			  </tr>
						<tr>
						<td colspan="6" align="right" style=" border-left:1px solid #000000; border-bottom:1px solid #000000;background:#E9E9E9">
			<div  align="center" style="color:#333333;font-size:15px;  margin-left:5px; margin-bottom:5px;" class="labels">
			  <div align="left"><b>Amendment No.  &nbsp; &nbsp;: 
			        <% if(p1[15]==null){ %>
						- 						
						<% }else{ %>
					 <%= p1[15]  %>
                     <% } %></b></div>
                
			</div></td>
          <td colspan="5" align="right"  style="border-right:1px solid #333333; border-bottom:1px solid #000000; background:#E9E9E9">
			<div  align="center" style="color:#333333;font-size:15px; margin-bottom:5px;" class="labels">
			  <div align="left"><b>Amendment Date : 
              <% if(p1[16]==null){ %>
						- 						
						<% }else{ %>
         				<% 
						String adate11,adate21;
						adate11=(p1[16].toString()).substring(0,10);
						adate21=  adate11.substring(0,2)+"/"+adate11.substring(3,5)+"/"+adate11.substring(6,10);
						
						%>
						<%= adate21%>
                     <% } %>
			   </b></div>
			</div></td>
			  </tr>
              
			<% } %>
				<tr>
						<td align="left" style="height:22px;border-right:1px solid #000000 ; border-left:1px solid #000000; border-bottom:1px solid #000000; ">
			<div style="margin-left:5px;" class="labels">
						<%= p1[8]  %></div></td>
						<td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<% Double informat11 = (Double)p1[9];
				NumberFormat formatter31 = new DecimalFormat("#0.00");
				p1[9] =(formatter31.format(informat11)); %><%= p1[9]  %></div></td>
				<td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<%= p1[12]  %></div></td>
				<td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<%= p1[11]  %></div></td>
							<td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
						<%= p1[3]  %></div></td>
                  
						 	<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				  <% if(p1[13]==null){ %>
						- 						
						<% }else{ %>
         				 <%= p1[13]  %>
                     <% } %>
						</div></td>
                        
               	  <td width="8%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
				<% if(p1[14]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost22 = (Double)p1[14];
						NumberFormat formatter22 = new DecimalFormat("#0.00");
						p1[14] =(formatter22.format(formatcost22));%>
				  <%= p1[14]  %>
						<% 	} %>
				  </div></td>
                  
				  <td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px;" class="labels">
			  <% Double informat12 = (Double)p1[10];
				NumberFormat formatter32= new DecimalFormat("#0.00");
				p1[10] =(formatter32.format(informat12)); %><%= p1[10]  %> 
						</div></td>
                        
						<td align="right" style="height:22px;border-right:1px solid #000000 ; border-bottom:1px solid #000000; ">
			<div style="margin-right:5px; cursor: pointer;" onclick="javascript:OpenPopup('<%= myval %>','<%= textdata %>','<%= p1[0] %>','<%= p1[1] %>');"  class="links">
						 <div align="center"><img src="images/view.png" width="32" height="32">	 </div>
			</div></td>
				</tr>
				 <%} %>
				 </table> 
				  <% } else { %> 
				 <br>
				 <div >
				 <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0">
				 <tr>
				 <td align="right" style="height:22px; border-bottom:1px solid #000000; 
				border-left:1px solid #000000; border-top:1px solid #000000;  ">
			<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;"></img></div></td>
				
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; 
				border-top:1px solid #000000; ">
			<div style=" margin-left:5px;"  align="left" class="labels">
			
			<b><font color="red">No Data Found </font> </b> </div></td>
				 </tr></table> </div>
				 <% }%>
				 </div>
                </div></td></tr>

	<%  }else if(myval.equals("date") && lstrsResult!=null ){%>
    <tr>
	<td colspan="3" align="center">	
    <div align="center">
    <%
				String s = "";
   				int corderno=0 ;
				Integer intsno=0;
				if(lstrsResult.size()>0){
				strFlag="True";
	%>
	<br>
	<div >
		<table width="96%" align="center"  border="0" cellpadding="0" cellspacing="0" >
			<tr>
									
			<td width="6%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-left:1px solid #000000 ; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Invoice No.</b></div></td>
						
				<td width="21%" align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center"style="color:#FFFFFF;font-size:14px;" class="labels">
				<b>Product Name</b></div></td>
				
				<td width="6%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Ordered Qty</b></div></td>
				
				<td width="6%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Dispatched Qty</b></div></td>
				
				<td width="7%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Dispatching Qty</b></div></td>
                
                <td width="13%" align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Rate</b></div></td>
                
                <td width="8%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Qty</b></div></td>
                
                <td align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Cost</b></div></td>
				
				<td align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amount</b></div></td>
						
				<td align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
		<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>View </b></div></td>
			</tr>
			<%  String invoiceno1 = "No invoice";
			Iterator <?> idate  = lstrsResult.iterator();
				while(idate.hasNext())
				{	intsno++;
					Object []  p1 = (Object[]) idate.next();
					if(p1[4]!=null)
					{
						invoiceno1 = p1[4].toString();
					}
					else
					{
						invoiceno1 = "-";
					}
					if(!s.equals(p1[5])){
						intsno=1;
						s= (String) p1[5];
						corderno= (Integer)p1[0];
				%>
				<tr><td colspan="12"  align="left" style="background:#B9B9B9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style=" margin-left:5px; margin-top:5px; font-size:15px; margin-bottom:5px;" class="labels">
					<b>Customer Name : <%= s  %></b></div></td></tr>
						
						<tr><td colspan="7"  align="left" style="background:#E9E9E9;height:22px; border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px;  margin-bottom:5px;" class="labels">
						<b>Customer Order No : <%= p1[9]  %></b>
						</div></td>
						
							<td  colspan="5"align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
						<% 
						String s1,s2;
						s1=(p1[6].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
						<b>Order date : <%= s2 %> </b></div></td>
						</tr>	
                        
                        <tr><td colspan="7"  align="left" style="background:#E9E9E9;height:22px; border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px;  margin-bottom:5px;" class="labels">
						<b>Amendment No :	 <% if(p1[15]==null){ %>
						Not Available 						
						<% }else{ %>
					 <%= p1[15]  %>
                  <% } %></b>
						</div></td>
						
							<td  colspan="5"align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
						<b> Amendment Date :
						<% if(p1[16]==null){ %>
						Not Available 								
						<% }else{ %>
       				<% 
							String s17,s27;
							s17=(p1[16].toString()).substring(0,10);
							s27=  s17.substring(0,2)+"/"+s17.substring(3,5)+"/"+s17.substring(6,10);
						%>
					 <%= s27  %>
                  <% } %> </b></div></td>
						</tr>
                        		
				<%} else {
					if(corderno!=(Integer)p1[0]){
						intsno=1;
						corderno= (Integer) p1[0];	%>
				<tr><td colspan="7"  align="left" style="background:#E9E9E9;height:22px; border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px;margin-bottom:5px;" class="labels">
						<b>Customer Order No : <%= p1[9]  %></b>
				  </div></td>
						
							<td  colspan="5" align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
						<% 
						String s1,s2;
						s1=(p1[6].toString()).substring(0,10);
						s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
						%>
						<b>Order date : <%= s2 %> </b></div></td>
			  </tr>	
               <tr><td colspan="7"  align="left" style="background:#E9E9E9;height:22px; border-bottom:1px solid #000000;border-left:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px;  margin-bottom:5px;" class="labels">
						<b>Amendment No :	 <% if(p1[15]==null){ %>
						Not Available 								
						<% }else{ %>
					 <%= p1[15]  %>
                  <% } %></b>
						</div></td>
						
							<td  colspan="5"align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px; margin-top:5px; margin-bottom:5px;" class="labels">
						<b> Amendment Date :
						<% if(p1[16]==null){ %>
						Not Available 							
						<% }else{ %>
       				<% 
							String s18,s28;
							s18=(p1[16].toString()).substring(0,10);
							s28=  s18.substring(0,2)+"/"+s18.substring(3,5)+"/"+s18.substring(6,10);
						%>
					 <%= s28 %>
                  <% } %> </b></div></td>
						</tr>				
						<% }} %>
                        
				<tr>
						<td align="right" style="height:22px;border-bottom:1px solid #000000 ; border-left:1px solid #000000  ;border-right:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
						<%= invoiceno1 %>  </div></td>

				<td align="left" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-left:5px;" class="labels">
				  		<%= p1[7]  %> </div></td>
				
					<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
						<%= p1[3]  %> </div></td>
						
							<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
							<div style="margin-right:5px;" class="labels">
								<% if(p1[11]==null){ %>
                                    - 
                                <% }else{ %>									
                                    <%= p1[11]  %> 
                                <% 	}%>			
                            </div></td>
				  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
						<% if(p1[10]==null){ %>
						- 						
						<% }else{ %>
							<%= p1[10]  %>
						<% 	}%>
			      </div></td>
                         
						<td width="13%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
			
						<% Double formatcost1 = (Double)p1[8];
						NumberFormat formatter1 = new DecimalFormat("#0.00");
						p1[8] =(formatter1.format(formatcost1));%>
				  <%= p1[8]  %> </div></td>
                  
			 	  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				  <% if(p1[13]==null){ %>
						- 						
						<% }else{ %>
         				 <%= p1[13]  %>
                     <% } %>
				  </div></td>
                        
               	  <td width="9%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
				<% if(p1[14]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost22 = (Double)p1[14];
						NumberFormat formatter22 = new DecimalFormat("#0.00");
						p1[14] =(formatter22.format(formatcost22));%>
				  <%= p1[14]  %>
						<% 	} %>
				  </div></td>
                  
				  <td width="15%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
			<% if(p1[12]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost2 = (Double)p1[12];
						NumberFormat formatter2 = new DecimalFormat("#0.00");
						p1[12] =(formatter2.format(formatcost2));%>
				  <%= p1[12]  %>
						<% 	} %>
			      </div></td>
										
				  <td width="9%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<% if(invoiceno1!="-")
				{
				%>
			<div style="margin-right:5px; cursor: pointer;" onclick="javascript:OpenPopup('<%= myval %>','<%= textdata %>','<%= p1[4] %>','<%= p1[0] %>');" class="links">
						 <div align="center"><img src="images/view.png" width="32" height="32"> </div>
			</div>
						  <%}else {%>
						  
						  <div  align="center" style="margin-right:5px; cursor: pointer;"  class="links">
			    - </div><%} %>				</tr>
				 <% } %>
		    </table> </div>
				  <% } else {   %> 
				 <br>
				 <div >
				 <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0">
				 <tr>
				 <td align="right" style="height:22px; border-bottom:1px solid #000000; 
				border-left:1px solid #000000; border-top:1px solid #000000;  ">
			<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;"></img></div></td>
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; 
				border-top:1px solid #000000; ">
			<div style=" margin-left:5px;"  align="left" class="labels">
			<b><font color="red">No Data Found </font> </b> </div></td>
				 </tr></table> </div>
				 <% }%>
</div></td></tr>
	<%  } else if(myval.equals("ordernumber")&& lstrsResult!=null && !textdata.equals("")){%>
    <tr>
	<td colspan="3" align="center">	
    <div align="center">
    <%
			Integer intsno=0;
			if(lstrsResult!=null && lstrsResult.size()>0){
				strFlag="True";
				Iterator <?> iorder  = lstrsResult.iterator();
				String s ="";
				int corderno=0;
	%>
	<br>
	<div >
		<table width="96%" align="center"  border="0" cellpadding="0" cellspacing="0" >
			<tr>
			<td width="6%"  align="center" style="border-right:1px solid #333333;  border-left:1px solid #000000;   border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Invoice No.</b></div></td>
			
			  <td width="23%"  align="center" style="border-right:1px solid #333333;border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Product Name</b></div></td>
			
			<td width="5%"  align="center" style="border-right:1px solid #333333;border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Ordered Qty</b></div></td>
			
			<td width="6%"  align="center" style="border-right:1px solid #333333;border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Dispatched Qty</b></div></td>
			
			<td width="7%"  align="center" style="border-right:1px solid #333333;border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Dispatching Qty</b></div></td>
			
			<td width="12%"  align="center" style="border-right:1px solid #333333;   border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Rate</b></div></td>
                
                <td width="7%" align="right" style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Qty</b></div></td>
                
                <td align="right"  style="border-right:1px solid #333333;border-top:1px solid #000000; border-bottom:1px solid #333333; background:#007CF9">
<div   align="center" style="color:#FFFFFF;font-size:14px;" class="labels"> 
				<b>Amendment Cost</b></div></td>
			
			<td width="16%"  align="center" style="border-right:1px solid #333333;   border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>Amount</b></div></td>
			
			<td width="10%"  align="center" style="border-right:1px solid #333333;   border-top:1px solid #000000;  border-bottom:1px solid #333333;  background:#007CF9">
			<div  style="color:#FFFFFF;font-size:14px; " class="labels">
			<b>View </b></div></td>
			</tr>
			<% String invoiceno1 = "No invoice";
				while(iorder.hasNext())
				{
					intsno++;
					Object []  p1 = (Object[]) iorder.next();
					if(p1[9]!=null)
					{
						invoiceno1 = p1[9].toString();
					}
					else
					{
						invoiceno1 = "-";
					}
					if(!s.equals(p1[3].toString())){
						intsno=1;
						s= (String) p1[3];	
				%>
				<tr>
						<tr>
						<td colspan="12"  align="left" style="background:#B9B9B9;height:22px;border-right:1px solid #000000; border-left:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-top:5px;margin-bottom:5px; font-size:15px;" class="labels">
					<b>	Customer Order No : <input type="text" name="s_orderid2"   class="labels"  value="<%= p1[10] %>"style="border: 0px; background:#B9B9B9; font-weight: bold; font-size:15px;" readonly="readonly"> </b> </div></td>
						</tr>	
						<% } 
					if(corderno!=(Integer)p1[1]){
						intsno=1;
						corderno= (Integer) p1[1];	%>
						
						<tr>
						<td colspan="6"  align="left" style="background:#E9E9E9;height:22px; border-left:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px; margin-top:5px;" class="labels">
						<b>Customer Name : <%= s  %></b></div></td>
						
						<td colspan="6"  align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;margin-top:5px" class="labels">
						<b>Order date : <% String s1,s2;

					s1=(p1[4].toString()).substring(0,10);
					s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
							%>
						<%= s2  %>	</b> </div></td>
						</tr>
                        	<tr>
						<td colspan="6"  align="left" style="background:#E9E9E9;height:22px; border-left:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px; margin-top:5px;" class="labels">
						<b>Amendment No :<% if(p1[16]==null){ %>
						Not Available	 						
					<% }else{ %>
					 <%= p1[16]  %>
                     <% } %></b></div></td>
						
						<td colspan="6"  align="left" style="background:#E9E9E9;height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px;margin-top:5px" class="labels">
						<b>Amendment Date :   <% if(p1[17]==null){ %>
						Not Available	 						
					<% }else{ %>
         				<% String amend1,amend2;
						amend1=(p1[17].toString()).substring(0,10);
						amend2=  amend1.substring(0,2)+"/"+amend1.substring(3,5)+"/"+amend1.substring(6,10);
							%>
						<%= amend2  %>	<% } %></b> </div></td>
						</tr>
							<%} else {
					if(corderno!=(Integer)p1[1]){
						intsno=1;
						corderno= (Integer) p1[1];	%>
						<tr>
						
						<td colspan="6"  align="left" style="background:#E9E9E9;height:22px; border-left:1px solid #000000; border-bottom:1px solid #000000;">
			<div align="left" style="margin-left:5px;margin-bottom:5px; margin-top:5px;" class="labels">
						<b>Customer Name : <%= s  %></b></div></td>
						
						<td colspan="6"  align="right" style="background:#E9E9E9;height:22px;border-right:1px solid #000000;  border-bottom:1px solid #000000;">
			<div align="right" style="margin-left:5px;margin-bottom:5px;margin-top:5px;" class="labels">
						<div align="left"><b>Order date : 
						  <% String s1,s2;
					s1=(p1[4].toString()).substring(0,10);
					s2=  s1.substring(8,10)+"/"+s1.substring(5,7)+"/"+s1.substring(0,4);
							%>
					      <%= s2  %></b> </div>
			</div>
			</td><% } %>
						</tr>
                        
				<%} %>
				<tr>						
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-left:1px solid #000000; border-bottom:1px solid #000000 ;">
			<div style="margin-right:2px;" class="labels">
			  <div align="left">
			    <input type="text" name="s_invoiceno" value="<%= invoiceno1 %>"  style="border: 0px; text-align: right; width:50px;" readonly="readonly">
			    </div>
			</div></td>
						
							<td align="left" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-left:5px;" class="labels">
						<%= p1[6]  %> 	</div></td>
						
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
						<%= p1[8]  %> </div></td>
					
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				<% if(p1[11]==null){ %>-
					<% }else { %>
						<%= p1[11]  %> <%} %>
							</div></td>
						
							<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
						<% if(p1[11]==null){ %>-
					<% }else { %>
						<%= p1[12]  %> <%} %>
						</div></td>
						
							<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
			<% Double formatcost3 = (Double)p1[7];
							NumberFormat formatter1 = new DecimalFormat("#0.00");
							p1[7] =(formatter1.format(formatcost3)); %> 
						<%= p1[7]  %> </div></td>
                        
                        
                  
                  
			 	  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
				  <% if(p1[14]==null){ %>
						- 						
						<% }else{ %>
         				 <%= p1[14]  %>
                     <% } %>
						</div></td>
                  
                        
               	  <td width="8%" align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
<div style="margin-right:5px;" class="labels">
				<% if(p1[15]==null){ %>
						- 						
						<% }else{ %>
								<% Double formatcost22 = (Double)p1[15];
						NumberFormat formatter22 = new DecimalFormat("#0.00");
						p1[15] =(formatter22.format(formatcost22));%>
				  <%= p1[15]  %>
						<% 	} %>
				  </div></td>
						
				  <td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000 ;">
			<div style="margin-right:5px;" class="labels">
			<% if(p1[12]==null){%>
			-
			<%}else{ %>
			<% Double formatcost4 = (Double)p1[13];
							NumberFormat formatter4 = new DecimalFormat("#0.00");
							p1[13] =(formatter4.format(formatcost4)); %> 
						<%= p1[13]  %> 
						<% } %>
				</div></td>
						
						<td align="right" style="height:22px;border-right:1px solid #000000 ;border-bottom:1px solid #000000; ">
			<% if(invoiceno1!="-")
				{
				%>
			<div style="margin-right:5px; cursor: pointer;" onclick="javascript:OpenPopup('<%= myval %>','<%= textdata %>','<%= p1[9] %>','<%= p1[1] %>');" class="links">
						<div align="center"><img src="images/view.png" width="32" height="32"> </div>
			</div>
						  <%}else {%>
						  
						  <div align="center" style="margin-right:5px; cursor: pointer;"  class="links">
			  - </div><%} %>		</tr>
				 <%} %>
				 </table> </div>
				  <% } else {   %> 
				 <br> 
				 <div >
				 <table align="center"  width="96%" border="0" cellpadding="0" cellspacing="0">
				 <tr>
				 <td align="right" style="height:22px; border-bottom:1px solid #000000; 
				border-left:1px solid #000000; border-top:1px solid #000000;  ">
			<div style=" margin-left:50px;"  align="right" class="labels">
				 <img src="images/Cfthrow.gif" style="margin-top:5px; margin-bottom:5px;"></img></div></td>
				
				<td align="left" style="height:22px;border-right:1px solid #000000; border-bottom:1px solid #000000; 
				border-top:1px solid #000000; ">
			<div style=" margin-left:5px;"  align="left" class="labels">
			
			<b><font color="red">No Data Found </font> </b> </div></td>
				 </tr></table> </div>
				 	 <% } %></div></td></tr>
				 <%} %>
				 <% 
				 	
				 	if( itotalpages>0 && !strFlag.equals("False"))
				 	{ 
				 		strFlag= "False";
				%>
				 <tr>
        <td colspan="5"  align="right">
        &nbsp;
        <div align="right" style="margin-right:15px;" >
        <a href="#" onclick="javascript: callPagination('<%=1%>')" class="links">First</a> 
        <a href="#"  onclick="javascript: callPagination('<%=cPageNo-1%>')"   class="links">&nbsp;Previous</a>
           <% 
			for(int i=1; i<= itotalpages; i++)
				{
				%> 
				 <a href="#" onclick="javascript: callPagination('<%=i%>')" class="links" ><%=i%></a>
             <% } %>  
              <a href="#" onclick="javascript: callPagination('<%=cPageNo+1%>')"   class="links">&nbsp;Next</a> 
    <a href="#"  onclick="javascript: callPagination('<%=itotalpages%>')"  class="links">&nbsp;Last</a>   </div></tr> 
   <tr>
	<td colspan="5"  align="right"><div align="right" style="margin-right:25px;" class="labels">
		<% 
			int i = Integer.parseInt(str);
			%> 
			Rows <%=((cPageNo - 1)*ilength)+1%> - 
			<% if((i-(cPageNo*ilength)) < 0){ %> <%= i %>   
			<% } else { %>
			<%= cPageNo*ilength %> <%} %>
			Total Result  <%= str %>
		</div>	</td>
</tr>
   <% } %>
   <tr>
  <td colspan="10">&nbsp;</td>
</tr>
</table>
</form>
<%@ include file="includes/footer.jsp" %>
<% 
	  if(request.getAttribute("result")!=null){
	%>
	<script type="text/javascript">
	   alert("Tax added successfully.");
	   </script>
	   <%} %>				 
					
				