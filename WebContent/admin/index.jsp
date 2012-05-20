<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("username")!=null&& sessiones.getAttribute("user_permiso")!=null){

	Integer portal=1;
	try{
	portal=Integer.parseInt(request.getParameter("portal"));
	}catch (Exception e){}
	String user=(String)sessiones.getAttribute("username");
	
%>

<head>
<jsp:include page="modulo_contenido/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="modulo_contenido/titulo.jsp">
<jsp:param name="titulo" value="Administraci&oacute;n" />
<jsp:param name="usuario" value="<%=user%>" />	
</jsp:include>
</div>

<div id="back" class="ui-widget-content ui-corner-all">
<!-- header begins -->

 <div id="main" >
<div style="clear: both;"></div>
<div id="menu-principal" class="ui-widget-content ui-corner-all">
<jsp:include page="modulo_contenido/menu.jsp" />
</div>
<div id="contenido">
<% if(portal==1){ %>
<jsp:include page="modulo_contenido/perfil.jsp" />
<% }else if(portal==2){ %>
<jsp:include page="modulo_contenido/new_contenido.jsp" />

<% }else if(portal==3){ %>
<jsp:include page="modulo_contenido/edit_contenido.jsp" />
<% }else if(portal==4){ %>
<jsp:include page="modulo_contenido/noticia.jsp" />
<% }else if(portal==5){ %>
<jsp:include page="modulo_contenido/actividad.jsp" />
<% }else if(portal==6){ %>
<jsp:include page="modulo_contenido/header_area.jsp" />
<% }else if(portal==7){ %>
<jsp:include page="modulo_contenido/usuario.jsp" />
<% }else if(portal==8){ %>
<jsp:include page="modulo_contenido/permiso.jsp" />
<% }else if(portal==9){ %>
<jsp:include page="modulo_contenido/configuracion.jsp" />
<% }else if(portal==10){ %>
<jsp:include page="modulo_contenido/multimedia.jsp" />
<% }else if(portal==11){ %>
<jsp:include page="modulo_examen/propiedades.jsp" />
<% }else if(portal==12){ %>
<jsp:include page="modulo_examen/mant_categorias.jsp" />
<% }else if(portal==13){ %>
<jsp:include page="modulo_examen/categoria_menu.jsp" />
<% }else if(portal==14){ %>
<jsp:include page="modulo_examen/mant_preguntas.jsp" />
<% }else if(portal==15){ %>
<jsp:include page="modulo_examen/menu_preguntas.jsp" />
<% }else if(portal==16){ %>
<jsp:include page="modulo_examen/carne.jsp" />
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