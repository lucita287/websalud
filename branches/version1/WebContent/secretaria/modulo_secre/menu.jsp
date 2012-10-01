<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CValidation" %>      
<% 
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
	String user=(String)sessiones.getAttribute("username");	
%>
<style>
	.unlogin{
			background: #CCC;  width:710px;
			border-bottom-right-radius: 4px;
			border-bottom-left-radius: 4px;
			border-top-right-radius: 4px;
			border-top-left-radius: 4px;
			width:450px;
			float:left;
		}
</style>
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
<div style="float:left; width:450px;" >
<a class="menu" href="index.jsp?portal=1">CALENDARIO</a>
<a class="menu" href="index.jsp?portal=3">ESTUDIANTE</a>
<a class="menu" href="index.jsp?portal=4">REPORTE</a>
<a class="menu" href="index.jsp?portal=2">GESTION CITA</a>
</div>
<div class="unlogin">
						<div style="float:left;">
							<h1> CITAS EXAMEN SALUD</h1>
						</div>
						<div style="float:right;">
						<img src="../images/icon_online.png" />
						Bienvenido | <%=user %> |
						<a Style="color:#0000CD;" href="../SunLogin">(Salir)</a>	
						</div>
						<div style="clear: both;"></div>
</div>
<% if(portal==1){ %>

<div style="float:left">
<div id="message" class="ui-corner-all">
	<h4>CITAS:</h4>
	<div id="citas_calendario"></div>
</div> 
</div>
<div style="float:right">
<div id="datepicker"></div>
</div>
<% } %>
</div>
<div style="clear: both;"></div>
<HR/>
<%	} %>
