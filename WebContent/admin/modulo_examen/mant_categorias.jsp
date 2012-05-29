		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>


<div id="tabs">
	<ul>
		<li><a href="#tabs-1">Categorias</a></li>
		<li><a href="#tabs-2">Interpretaci&oacute;n de Categoria</a></li>
	</ul>
	<div id="tabs-1">
					<jsp:include page="categoria.jsp" />
	</div>
	<div id="tabs-2">
					<jsp:include page="ponderacion_categoria.jsp" />	
	</div>

</div>
    

						