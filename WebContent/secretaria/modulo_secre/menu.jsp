<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CValidation" %>      
<% 
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){

%>

<script>
	$(function() {
		$( "a.menu" ).button();
		
	});
	</script>
<%
CValidation valid=new CValidation();
int portal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("portal")));
%>	
<div id="menu_derecho">	
<div style="float:right">
<a class="menu" href="index.jsp?portal=1">CALENDARIO CITAS</a>
<a class="menu" href="index.jsp?portal=3">ESTUDIANTES</a>
<a class="menu" href="index.jsp?portal=4">REPORTES</a>
<a class="menu" href="index.jsp?portal=2">CITAS</a>
</div>
<% if(portal==1){ %>
<div style="float:right">
<div id="datepicker"></div>
</div>
<% } %>
</div>
<div style="clear: both;"></div>
<HR/>
<%	} %>