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
<%} %>
</div>
<div style="clear: both;"></div>

</div>	
<!--content ends -->
</div>
<!--footer begins -->



<div id="footer">
<p>Copyright &copy; 2011. <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a> | <a href="http://validator.w3.org/check/referer" title="This page validates as XHTML 1.0 Transitional"><abbr title="eXtensible HyperText Markup Language">XHTML</abbr></a> | <a href="http://jigsaw.w3.org/css-validator/check/referer" title="This page validates as CSS"><abbr title="Cascading Style Sheets">CSS</abbr></a></p> 
	<p><!-- Do not remove -->Designed by <a href="http://www.metamorphozis.com/" title="Free Web Templates">Free Web Templates</a>, coded by <a href="http://www.myfreecsstemplates.com/" title="Free CSS Templates">Free CSS Templates</a><!-- end -->               
		</p>
	</div>
</div>

<!-- footer ends-->

</div>
</body>
</html>