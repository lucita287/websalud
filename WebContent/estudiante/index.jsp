<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="framework.CValidation" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("estudiante")!=null){
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(request.getParameter("portal"));
	String user=(String)sessiones.getAttribute("estudiante");
	
%>
<head>
<jsp:include page="modulo_perfil/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="../admin/modulo_contenido/titulo.jsp">
<jsp:param name="titulo" value="Examen de Salud" />
<jsp:param name="usuario" value="<%=user %>" />	
</jsp:include>
</div>

<div id="back"  class="ui-widget-content ui-corner-all">
<!-- header begins -->

 <div id="main">
<div style="clear: both;"></div>
<div id="menu-principal" >
<jsp:include page="modulo_perfil/menu.jsp" />
</div>
<div id="contenido">
<div id="cont_dato_personal">
<% if(portal==1){ %>

<jsp:include page="modulo_perfil/dato_personal.jsp" />
<% }else if(portal==2){ %>
<jsp:include page="modulo_perfil/estatus_estudiante.jsp" />
<% }else if(portal==3){ %>
<jsp:include page="modulo_perfil/estatus_trabajador.jsp" />
<% }else if(portal==4){ %>
<jsp:include page="modulo_perfil/dato_general.jsp" />
<% }else if(portal==4){ %>
<jsp:include page="modulo_perfil/dato_general.jsp" />
<% }else if(portal==5){ %>
<jsp:include page="modulo_perfil/multi.jsp" />
<% }else if(portal==6){ %>
<jsp:include page="modulo_perfil/auto_eva.jsp" />
<% }else if(portal==9){ %>
<jsp:include page="modulo_perfil/examen_categoria.jsp" />
<% }else if(portal==7){ %>
<jsp:include page="modulo_perfil/report.jsp" />
<% } %>
</div>
</div>
<div style="clear: both;"></div>

</div>	
<!--content ends -->
</div>
<!--footer begins -->




<jsp:include page="../portal/footer.jsp" />

</div>

<!-- footer ends-->

</div>
</body>
<% }else{
	response.sendRedirect("../index.jsp");
	
} %>
</html>