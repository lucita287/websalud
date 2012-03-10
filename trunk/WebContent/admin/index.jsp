<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("username")!=null&& sessiones.getAttribute("user_permiso")!=null){
	Integer portal=(Integer)(sessiones.getAttribute("portal")==null?1:sessiones.getAttribute("portal"));
	
	
%>

<head>
<jsp:include page="modulo_contenido/top.jsp" />
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
<h2><a href="#" id="metamorph">Administraci&oacute;n</a></h2>
<h2><a href="#">Bienvenido <%=sessiones.getAttribute("username")%></a></h2>
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">
<div style="clear: both;"></div>
<div id="menu-principal" >
<jsp:include page="modulo_contenido/menu.jsp" />
</div>
<div id="contenido">
<% if(portal==1){ %>
<jsp:include page="modulo_contenido/perfil.jsp" />
<% }else if(portal==2){ %>
<jsp:include page="modulo_contenido/edit_contenido.jsp" />
<% }else if(portal==3){ %>
<jsp:include page="modulo_contenido/new_contenido.jsp" />
<% }else if(portal==6){ %>
<jsp:include page="modulo_contenido/header_area.jsp" />
<% }else if(portal==4){ %>
<jsp:include page="modulo_contenido/noticia.jsp" />
<% }else if(portal==5){ %>
<jsp:include page="modulo_contenido/actividad.jsp" />
<% }else if(portal==7){ %>
<jsp:include page="modulo_contenido/usuario.jsp" />
<% }else if(portal==8){ %>
<jsp:include page="modulo_contenido/permiso.jsp" />
<% }else if(portal==9){ %>
<jsp:include page="modulo_contenido/exam_auto.jsp" />
<%} %>
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