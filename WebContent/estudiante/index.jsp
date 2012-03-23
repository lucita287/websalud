<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("estudiante")!=null){
	Integer portal=(Integer)(sessiones.getAttribute("examen")==null?1:sessiones.getAttribute("examen"));
	
%>
<head>
<jsp:include page="modulo_perfil/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<div style="float:left">
<img src="../images/usalud.png" width="100px" height="100px" />
</div>
<div style="float:left">
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph">Estudiante</a></h2>
<h2><a href="#">Bienvenido </a></h2>
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
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