<script language="javascript">
function Openmypage(menuid){
	if (menuid=="7"){
		document.getElementById("myname").value="order2";
		document.frmMenus.submit();
	}else if (menuid=="6"){
		document.getElementById("myname").value="gntinvoice";
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
	}
}
</script>
<form name="frmMenus" action="CommonServlet" method="post">
<div style="float: left" id="my_menu" class="sdmenu">
<input type="hidden" id="myname" name="myname" value=""></input>
	<div align="left">
	<a href="#" onclick="javascript:Openmypage('7');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Order</div></a>
	<a href="#" onclick="javascript:Openmypage('10');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Advance Payment</div></a>
		<a href="#" onclick="javascript:Openmypage('6');"style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Invoice</div></a>
		
		<a href="#" onclick="javascript:Openmypage('8');"style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Search</div></a>
		<a href="#"  onclick="javascript:Openmypage('9');" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Print</div></a>
		<a href="changePassword.jsp" style="text-decoration:none;"><div align="left" style="border-bottom:1px solid;background:none;">Change Password</div></a>	
	</div>
</div>
</form>