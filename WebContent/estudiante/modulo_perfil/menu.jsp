<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="framework.CValidation" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("portal")));
%>

<div id="menu-logo" >
	<a href="index.jsp">
	<img src="../images/logousalud.gif" width="250px" alt="bt_1" onmouseout="this.src='../images/logousalud.gif';" onmouseover="this.src='../images/logousac.png';" />
	</a>
<div id="menu-principal" class="ui-widget-content ui-corner-all">	
<ul id="menu"  >
	<li>
		<a href="index.jsp" >INSTRUCCIONES</a>
	</li>
	<li >
		<a  >PASO 1</a>
		
			<ul id="personal">
				<li >
					<a href="index.jsp?portal=1">Datos Generales</a>
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
				<li>
					<a href="index.jsp?portal=9">Dash Multif&aacute;sico</a>
				</li>
				<li>
					<a href="index.jsp?portal=7">Dash AutoEvaluaci&oacute;n</a>
				</li>
				<li >
					<a href="index.jsp?portal=8">Citas</a>
				</li>
				
			</ul>	
	</li>
	
	<li>
	<a  href="../SunLogin">SALIR</a>
			
	</li>
	
</ul>
</div>
</div>
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
	  <% if((portal>4 && portal<7)|| (portal==10)|| (portal==11)){%>
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