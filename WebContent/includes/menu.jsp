<script language="javascript">
function Openmypage(menuid){
	if(menuid=="3"){
		document.getElementById("myname").value="AddProduct1";
		document.frmMenus.submit();
	}else if (menuid=="5"){
		document.getElementById("myname").value="updatetax";
		document.frmMenus.submit();
	}else if (menuid=="6"){
		document.getElementById("myname").value="gntinvoice";
		document.frmMenus.submit();
	}else if (menuid=="7"){
		document.getElementById("myname").value="order2";
		document.frmMenus.submit();
	}else if (menuid=="8"){
		document.getElementById("myname").value="searchpage";
		document.frmMenus.submit();
	}else if (menuid=="9"){
		document.getElementById("myname").value="printreceipt";
		document.frmMenus.submit();
	}else if (menuid=="10"){
		document.getElementById("myname").value="advancepaymentafter";
		document.frmMenus.submit();
	}else if (menuid=="11"){
		document.getElementById("myname").value="paymentStatus";
		document.frmMenus.action="Payment";
		document.frmMenus.submit();
	}
}
</script>
<form name="frmMenus" action="CommonServlet" method="post">
<div style="float: left" id="my_menu" class="sdmenu">
<input type="hidden" id="myname" name="myname" value=""></input>
	<div align="left">
	    <a href="addUser.jsp" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Users</div></a>
		<a href="addMember.jsp" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;"> Member Registration</div></a>
		<a href="#" onclick="javascript:Openmypage('3');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Card</div></a>
		
		<a href="email.jsp"  style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Email</div></a>
			
		<a href="#" onclick="javascript:Openmypage('7');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Sms</div></a>
		<a href="#" onclick="javascript:Openmypage('8');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Search</div></a>
		<a href="#" onclick="javascript:Openmypage('6');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Reports </div></a>
		<a href="#"  onclick="javascript:Openmypage('8');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Setting</div></a>
		<a href="changePassword.jsp" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Change Password</div></a>	

	</div>
</div>
</form>