<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
%>
<div id="tabs">
	<ul>
	<% if (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
		<li><a href="modulo_examen/estado_civil.jsp">Estado Civil</a></li>
	<% } if (user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
		<li><a href="modulo_examen/tipo_sangre.jsp">Tipo de Sangre</a></li>
	<% } if (user_permiso.getIdpermiso().indexOf(241)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
		<li><a href="modulo_examen/parentesco.jsp">Parentesco</a></li>
	<%} if (user_permiso.getIdpermiso().indexOf(242)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
		<li><a href="modulo_examen/titulo_secundaria.jsp">Titulo de Secundaria</a></li>
	<% } %>
	</ul>
</div>
<% } %>