<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("estudiante")!=null){
	Integer portal=1;
	try{
	portal=(Integer)(sessiones.getAttribute("examen")==null?1:sessiones.getAttribute("examen"));
	}catch (Exception e){
		
	}
%>
<head>
<jsp:include page="modulo_perfil/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="../admin/modulo_contenido/titulo.jsp">
<jsp:param name="titulo" value="Estudiante" />
<jsp:param name="usuario" value="Prueba" />	
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

<% if(portal==1){ %>
<jsp:include page="modulo_perfil/dato_personal.jsp" />
<% }else if(portal==2){ %>
<jsp:include page="modulo_perfil/estatus_estudiante.jsp" />
<% } %>
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