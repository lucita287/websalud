<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CConfiguracion" %>
<%@ page import="data.CAnuncio" %>    

<% 	
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CDataExam dbo=new CDataExam();
	if(dbo.Connect()){
	CConfiguracion configu=dbo.getConfiguracion();
	CAnuncio anuncio=dbo.getAnuncioEspecifico(1);
	dbo.Close();
%>
	<script>
	$(function() {
		$(".siguiente").button();
	});
	</script>
	<div style="float:right;">
	<a href="index.jsp?portal=1" class="siguiente">SIGUIENTE</a>
	</div>
	<h2>PARA LOS CARNE <%=configu.getCiclo() %></h2>
	<div class="instruccion">
	<%= anuncio.getContenido() %>
	</div>
<% }
	
}%>
	