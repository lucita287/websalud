<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CValidation" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <html>
<head>
<jsp:include page="modulo_secre/top.jsp" />
<title>CITAS/SECRETARIAS</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>
<body>
			<%
	 HttpSession sessiones=request.getSession(false); 		 	
    if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
    	
			CValidation valid=new CValidation();
			int portal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("portal")));
			%>
			<div class="back_all">
			<div id="content">
			
			<div id="back" class="ui-widget-content ui-corner-all">
			<!-- header begins -->
			
			 <div id="main" >
			
			<jsp:include page="modulo_secre/menu.jsp" />
			<% if(portal==1){ %>
			<jsp:include page="modulo_secre/weekcalendar.jsp" />
			<% }else if(portal==2){ %>
			<jsp:include page="modulo_secre/citas.jsp" />
			<% } else if(portal==3){ %>
			<jsp:include page="modulo_secre/estudiante.jsp" />
			<% } else if(portal==4){ %>
			<jsp:include page="modulo_secre/reporte.jsp" />
			<% } else if(portal==10){ %>
			<jsp:include page="modulo_secre/lista_paciente.jsp" />
			<% } %>
			</div>
			</div>
			</div>
			</div>
	<%	} %>		
			
</body>
</html>