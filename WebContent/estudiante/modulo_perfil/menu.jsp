<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="framework.CValidation" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("estudiante")!=null){
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("portal")));
%>
	
<ul id="menu"  >
	<li >
		<a >PASO 1</a>
			<ul id="personal">
				<li >
					<a href="index.jsp?portal=1">Datos Generales</a>
				</li>
				<li>
					<a href="index.jsp?portal=3">Estatus del trabajador</a>
				</li>
				
			</ul>	
	</li>
	<li >
		<a >PASO 2</a>
			<ul id="examen_fa">
				<li >
					<a href="index.jsp?portal=5">EXAMEN MULTIF&Aacute;SICO</a>
				</li>
				<li >
					<a href="index.jsp?portal=6">EXAMEN AUTOEVALUACI&Oacute;N</a>
				</li>
			</ul>	
	</li>
	<li >
		<a >PASO 3</a>
			<ul id="cita">
				<li >
					<a href="index.jsp?portal=7">Resultado</a>
				</li>
				<li>
					<a href="index.jsp?portal=9">Dash</a>
				</li>
				<li >
					<a href="index.jsp?portal=8">Citas</a>
				</li>
				
			</ul>	
	</li>
	
	<li>
	<a  href="../SunLogin">Salir</a>
			
	</li>
</ul>
	<script>
	$('#menu').hover(function() {
		
		$(this).css('cursor','pointer');
		
		}, function() {
		
		$(this).css('cursor','auto');
		
	});		

	
	function initMenu() {
	  $('#menu ul').hide();
	  
	  <% if(portal>0 && portal<5){%>
	  $('#personal').show();
	  <% }%>
	  <% if((portal>4 && portal<7)|| (portal==10)){%>
	  $('#examen_fa').show();
	  <% }%>
	  <% if(portal>6 && portal<10){%>
	  $('#cita').show();
	  <% }%>
	  $('#menu li a').click(
	    function() {
	    	
	    	var checkElement = $(this).next();
	      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
	        return false;
	        }
	      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
	        $('#menu ul:visible').slideUp('normal');
	        checkElement.slideDown('normal');
	        return false;
	        }
	      
	      }
	    );
	  }
	$(document).ready(function() {initMenu();});
	</script>
<% } %>