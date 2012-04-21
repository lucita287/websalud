		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <div id="tabs">
	<ul>
		<li><a href="#tabs-1">Categoria</a></li>
		<li><a href="#tabs-2">Ponderaci&oacute;n de Categorias</a></li>
		<li><a href="#tabs-3">Menu de Categoria</a></li>
	</ul>
	<div id="tabs-1" style="width:700px; ">
				<jsp:include page="categoria.jsp" />
	</div>
	<div id="tabs-2" style="width:700px; ">
				<jsp:include page="ponderacion_categoria.jsp" />		
	</div>
	<div id="tabs-3" style="width:700px; ">
				<jsp:include page="categoria_menu.jsp" />		
	</div>
</div>