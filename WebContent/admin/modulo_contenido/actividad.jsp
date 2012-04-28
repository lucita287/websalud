<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
			<div class="centerd">
			<H2>Actividades</H2>
			</div>
	<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>		
	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Actividad</a></li>
				<li><a href="#tabs-2">Fechas Actividades</a></li>
				<li><a href="#tabs-3">Responsables</a></li>
				<li><a href="#tabs-4">Lugar</a></li>
				
			</ul>
			<div id="tabs-1" style="width:700px; ">
				<jsp:include page="edit_actividad.jsp" />
			</div>
			<div id="tabs-2" style="width:700px; ">
				<jsp:include page="fecha_actividad.jsp" />		
			</div>
			<div id="tabs-3" style="width:700px; ">
				<jsp:include page="responsable.jsp" />				
			</div>
			<div id="tabs-4" style="width:700px; ">
				<jsp:include page="edificio.jsp" />
			</div>
	</div>	
	<div style="clear: both;"></div>	
	