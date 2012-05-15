<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CConfiguracion" %>
<%@ page import="data.CAnuncio" %>    
<% 	
	CDataExam dbo=new CDataExam();
	if(dbo.Connect()){
	CConfiguracion configu=dbo.getConfiguracion();
	CAnuncio anuncio=dbo.getAnuncioEspecifico(1);
	dbo.Close();
%>
	<h2>EXAMEN DE SALUD, PARA LOS CARNE <%=configu.getCiclo() %></h2>
	<%= anuncio.getContenido() %>
<% } %>
