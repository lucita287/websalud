<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<% 
HttpSession sessiones = request.getSession(false);
Integer portal=(Integer)(sessiones.getAttribute("portal")==null?1:sessiones.getAttribute("portal"));
%>

<jsp:include page="modulo/top.jsp" />
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
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">
<div style="clear: both;"></div>
<div id="menu-principal" >
<jsp:include page="modulo/menu.jsp" />
</div>
<div id="contenido">
<% if(portal==1){ %>
<jsp:include page="modulo/perfil.jsp" />
<% }else if(portal==2){ %>
<jsp:include page="modulo/edit_contenido.jsp" />
<% }else if(portal==3){ %>
<jsp:include page="modulo/new_contenido.jsp" />
<% }else if(portal==6){ %>
<jsp:include page="modulo/header_area.jsp" />
<% }else if(portal==4){ %>
<jsp:include page="modulo/noticia.jsp" />
<% }else if(portal==5){ %>
<jsp:include page="modulo/actividad.jsp" />
<% }else if(portal==7){ %>
<jsp:include page="modulo/usuario.jsp" />
<% }else if(portal==8){ %>
<jsp:include page="modulo/permiso.jsp" />
<% }else if(portal==9){ %>
<jsp:include page="modulo/exam_auto.jsp" />
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
</html>