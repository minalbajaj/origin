<%@ include file="includes/header.jsp" %>
<%session.invalidate();%>
<% 
   response.sendRedirect("Login.jsp");
%>
<%@ include file="includes/footer.jsp" %>