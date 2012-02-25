<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%String area=request.getParameter("idarea");%>
<jsp:include page="portal/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<div style="float:left">
<img src="images/usalud.png" width="100px" height="100px" />
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

<jsp:include page="portal/header.jsp" />	
<div style="clear: both;"></div>
<div id="menu-principal" >

	<%if(area==null){ %>
	<jsp:include page="portal/menu.jsp" />
	<jsp:include page="portal/login.jsp" />
	<%}else { %>
	<jsp:include page="portal/menu_area.jsp" />
	<% }%>
</div>
     <div id="noticias">
<div id="Cont-Panel-texto" class="ui-widget-content ui-corner-all">
<jsp:include page="portal/inicio.jsp" />				
</div>
<jsp:include page="portal/noticias.jsp" />						
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