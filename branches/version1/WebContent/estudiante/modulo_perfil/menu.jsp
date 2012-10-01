<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="data.CPaciente" %>
<%@ page import="data.CConfiguracion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="framework.CValidation" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("portal")));
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
	CDataExam dbo=new CDataExam();
	dbo.Connect();
	CConfiguracion config2=dbo.getConfiguracion();
	dbo.Close();
%>

<div id="menu-logo" >
	<a href="index.jsp">
	<img src="../images/logousalud2.gif" width="300px"  alt="bt_1" onmouseout="this.src='../images/logousalud2.gif';"  />
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
				<% if(pac.getEstado()==3){ %>
				<li >
					<a href="index.jsp?portal=3">EXAMEN MULTIF&Aacute;SICO</a>
				</li>
				<% }  if(pac.getEstado()==2){ %>
				<li >
					<a href="index.jsp?portal=4">EXAMEN AUTOEVALUACI&Oacute;N</a>
				</li>
				<% } %>
			</ul>	
	</li>
	<li >
		<a >PASO 3</a>
			<ul id="cita">
				<% if(pac.getEstado()==3){ %>
				<li>
					<a href="index.jsp?portal=5">Dash Multif&aacute;sico</a>
				</li>
				<% }  if(pac.getEstado()==2){ %>
				<li>
					<a href="index.jsp?portal=6">Cuestionario AutoEvaluaci&oacute;n</a>
				</li>
				<% } 
				if(config2.getImpresion_salud()==1){
				if(pac.getEstado()==3){ %>
				<li >
					<a href="index.jsp?portal=7">Citas Multif&aacute;sico</a>
				</li>
				<% }  if(pac.getEstado()==2){ %>
				<li>
					<a href="index.jsp?portal=8">Citas AutoEvaluaci&oacute;n</a>
				</li>
				<% }
				}
				%>
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
	  
	  <% if(portal>0 && portal<3){%>
	  $('#personal').show();
	  <% }%>
	  <% if((portal>2 && portal<5)|| (portal==10)){%>
	  $('#examen_fa').show();
	  <% }%>
	  <% if(portal>=5 && portal<10){%>
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