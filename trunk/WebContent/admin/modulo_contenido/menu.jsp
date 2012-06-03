<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="java.util.ArrayList" %>
<% 
HttpSession sessiones = request.getSession(false);
if(sessiones!=null && sessiones.getAttribute("user_permiso")!=null){

Integer portal=1;
try{
portal=Integer.parseInt(request.getParameter("portal"));
}catch (Exception e){}
CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

%>
<div id="menu-logo" >
	<a href="index.jsp">
	<img src="../images/logousalud.gif" width="250px" alt="bt_1" onmouseout="this.src='../images/logousalud.gif';" onmouseover="this.src='../images/logousac.png';" />
	</a>
<div id="menu-principal" class="ui-widget-content ui-corner-all">	
<ul id="menu"  >
	<li >
	<a href="index.jsp?portal=1">Perfil</a>
	</li>

	<%if (user_permiso.getIdpermiso().indexOf(221)>-1  
		||user_permiso.getIdpermiso().indexOf(225)>-1
		||user_permiso.getIdpermiso().indexOf(228)>-1
		||user_permiso.getIdpermiso().indexOf(231)>-1
			|| user_permiso.getIdusuario().getidusuario()==1){%>
	<li>
	<a   >Administrar Contenido</a>
			
			
			<ul id="admin_conte">
			<%if (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li  >
					<a href="index.jsp?portal=2" >Nuevo Contenido</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li  >
					<a href="index.jsp?portal=3" >Gestionar Contenido</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(225)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a href="index.jsp?portal=4">Gestionar Noticias</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a href="index.jsp?portal=5">Gestionar Actividades</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a  href="index.jsp?portal=6">Gestionar Areas</a>
				</li>
			<%}%>	
			</ul>
	</li>
	<%}%>
		<%if (user_permiso.getIdpermiso().indexOf(233)>-1  
		||user_permiso.getIdpermiso().indexOf(235)>-1
		||user_permiso.getIdpermiso().indexOf(246)>-1
		||user_permiso.getIdusuario().getidusuario()==1){%>	
	<li >
	<a >Administrar </a>
			<ul id="admin">
			<%if (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
				<li >
					<a href="index.jsp?portal=7">Gestionar Usuarios</a>
				</li>
		   <% } if (user_permiso.getIdpermiso().indexOf(235)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
				<li>
					<a href="index.jsp?portal=8">Gestionar Permisos</a>
				</li>
		 <% } if (user_permiso.getIdpermiso().indexOf(246)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		
				<li>
					<a href="index.jsp?portal=9">Configuraci&oacute;n</a>
				</li>
		 <% } if (user_permiso.getIdpermiso().indexOf(246)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		
				<li>
					<a href="index.jsp?portal=10">Archivos sin uso</a>
				</li>
		<% } %>		
			</ul>	
	</li>
	<% } %>
		<%if (user_permiso.getIdpermiso().indexOf(239)>-1  
		||user_permiso.getIdpermiso().indexOf(240)>-1
		||user_permiso.getIdpermiso().indexOf(241)>-1
		||user_permiso.getIdpermiso().indexOf(242)>-1
		||user_permiso.getIdpermiso().indexOf(250)>-1
		||user_permiso.getIdpermiso().indexOf(254)>-1
		||user_permiso.getIdpermiso().indexOf(255)>-1
		||user_permiso.getIdpermiso().indexOf(256)>-1
		||user_permiso.getIdpermiso().indexOf(257)>-1
		||user_permiso.getIdpermiso().indexOf(259)>-1
			|| user_permiso.getIdusuario().getidusuario()==1){%>
	
	<li>
		<a >Configurar Examen de Salud</a>
			<ul id="exam">
			<% if (	user_permiso.getIdpermiso().indexOf(239)>-1  
					||user_permiso.getIdpermiso().indexOf(240)>-1
					||user_permiso.getIdpermiso().indexOf(241)>-1
					||user_permiso.getIdpermiso().indexOf(242)>-1
					  || user_permiso.getIdusuario().getidusuario()==1){ %>	
				<li>
					<a href="index.jsp?portal=11" >Mantenimiento de Propiedades</a>
				</li>
			<% } if (user_permiso.getIdpermiso().indexOf(250)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>	
				<li>
					<a href="index.jsp?portal=12" >Mantenimiento de Categorias</a>
				</li>
				<li>
					<a href="index.jsp?portal=13" >Menu de Areas</a>
				</li>
			<% } if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>	
				<li>
					<a href="index.jsp?portal=14" >Gestionar Examen de Salud</a>
				</li>
			<% } if (user_permiso.getIdpermiso().indexOf(254)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
				<li>
					<a href="index.jsp?portal=15">Menu de Anuncios</a>
				</li >
			<% } if (user_permiso.getIdpermiso().indexOf(255)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
				<li>
					<a href="index.jsp?portal=16">Seleccionar Examen segun su terminaci&oacute;n</a>
				</li >
			<% } if (user_permiso.getIdpermiso().indexOf(256)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
				<li>
					<a href="index.jsp?portal=17">Resultados</a>
				</li>
			<% }if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
				<li>
					<a href="index.jsp?portal=18">Gestion de Resultados</a>
				</li>
			<% } %>
			</ul>
	
	</li>
		<% } %>
	<%if (user_permiso.getIdpermiso().indexOf(260)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>	
	<li>
		<a >Estudiantes</a>
			<ul id="estudiante">
				<li>
					<a href="index.jsp?portal=19" >Perfil de estudiantes</a>
				</li>
				
			</ul>
	</li>
	<% } %>
	<li>
	<a  href="../SunLogin">Salir</a>
			
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
	  
	  <% if(portal>1 && portal<7){%>
	  $('#admin_conte').show();
	  <% }else if(portal>6 && portal<11){ %>
	  $('#admin').show();
	  <% }else if(portal>10 && portal<19){ %>
	  $('#exam').show();
	  <% }else if(portal>18 && portal<20){ %>
	  $('#estudiante').show();
	  <% } %>
	  
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
<%} %>	