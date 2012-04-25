<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%String area=request.getParameter("idarea");%>
<title>Unidad de Salud / USAC</title>
<jsp:include page="portal/top.jsp" />
<meta name=description content="Divisi&oacute;n de Bienestar EstudiantiL, USAC. Dentro de las actividades de servicio, se encuentra la realizaci&oacute;n del examen obligatorio de salud a todos los estudiantes de primer ingreso." />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="portal/titulo.jsp">
<jsp:param name="titulo" value="Portal" />	
</jsp:include>
</div>

<div id="back" class="ui-widget-content ui-corner-all">
<!-- header begins -->

 <div id="main">

<jsp:include page="portal/header.jsp" />	
<div style="clear: both;"></div>
<div id="menu-principal" >

	<%if(area==null || area.equalsIgnoreCase("1") ){ %>
	<div id="menu-salud" class="ui-widget-content ui-corner-all">
	<jsp:include page="portal/menu.jsp" />
	</div>
	
	<%}else { %>
	<div id="menu-salud"  class="ui-widget-content ui-corner-all">
	<jsp:include page="portal/menu_area.jsp" />
	</div>
	<% }%>
	<jsp:include page="portal/login.jsp" />
</div>
     <div id="noticias">
<div id="Cont-Panel-texto" class="ui-widget-content ui-corner-all">
<jsp:include page="portal/inicio.jsp" />				
</div>
<jsp:include page="portal/noticias/noticias.jsp" />						
</div>
<div style="clear: both;"></div>

</div>	
<!--content ends -->
</div>
<!--footer begins -->

<jsp:include page="portal/addInfo.jsp" />				
	<div style="clear: both;"></div>
<jsp:include page="portal/footer.jsp" />
</div>

<!-- footer ends-->

</div>
</body>
</html>