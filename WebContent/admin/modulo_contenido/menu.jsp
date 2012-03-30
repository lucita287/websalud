<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="java.util.ArrayList" %>
<% 
HttpSession sessiones = request.getSession(false);
if(sessiones!=null && sessiones.getAttribute("portal")!=null&& sessiones.getAttribute("user_permiso")!=null){

Integer portal=(Integer)sessiones.getAttribute("portal");
CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

%>
	
<ul id="menu"  >
	<li >
	<a id="1">Perfil</a>
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
					<a id="2" >Gestionar Contenido</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(225)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a id="3">Gestionar Noticias</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a id="4">Gestionar Actividades</a>
				</li>
			<%} if (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				<li>
					<a  id="5">Gestionar Areas</a>
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
					<a id="6">Gestionar Usuarios</a>
				</li>
		   <% } if (user_permiso.getIdpermiso().indexOf(235)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
				<li>
					<a id="7">Gestionar Permisos</a>
				</li>
		 <% } if (user_permiso.getIdpermiso().indexOf(246)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		
				<li>
					<a id="8">Configuraci&oacute;n</a>
				</li>
		 <% } if (user_permiso.getIdpermiso().indexOf(246)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		
				<li>
					<a id="9">Imagenes sin usar</a>
				</li>
		<% } %>		
			</ul>	
	</li>
	<% } %>
	
	<%if (user_permiso.getIdpermiso().indexOf(239)>-1  
		||user_permiso.getIdpermiso().indexOf(240)>-1
		||user_permiso.getIdpermiso().indexOf(241)>-1
		||user_permiso.getIdpermiso().indexOf(242)>-1
		||user_permiso.getIdusuario().getidusuario()==1){%>	
	<li>
		<a >Configurar Examen de Salud</a>
			<ul id="exam">
				<li>
					<a id="10" >Mantenimiento de Propiedades</a>
				</li>
				<li>
					<a id="11" >Mantenimiento de Carreras</a>
				</li>
				<li>
					<a id="12" >Gestionar Examen de Autoevaluaci&oacute;n</a>
				</li>
				<li>
					<a id="13">Gestionar Examen Multif&aacute;setico</a>
				</li >
			</ul>
	
	</li>
	<%	} %>
	<li>
		<a >Estudiantes</a>
			<ul id="estudiante">
				<li>
					<a id="14" >Perfil de estudiantes</a>
				</li>
				
			</ul>
	
	</li>
	<%if (user_permiso.getIdpermiso().indexOf(237)>-1  
		||user_permiso.getIdpermiso().indexOf(238)>-1
		||user_permiso.getIdusuario().getidusuario()==1){%>	
	<li>
	<a >Reportes</a>
			<ul id="report">
				<li>
					<a id="15">Reportes</a>
				</li>
				<li>
					<a id="16" >Dashboard</a>
				</li>
			</ul>	
	</li>
	<% }%>
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
	  
	  <% if(portal>1 && portal<6){%>
	  $('#admin_conte').show();
	  <% }else if(portal>5 && portal<10){ %>
	  $('#admin').show();
	  <% }else if(portal>9 && portal<14){ %>
	  $('#exam').show();
	  <% }else if(portal>13 && portal<15){ %>
	  $('#estudiante').show();
	  <% }else if(portal>14 && portal<16){ %>
	  $('#report').show();
	  <%} %>
	  
	  
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
	      cadena = [ 'idmenu='     + $(this).attr("id"),
		             'a=admin'
		  		        ].join('&');
	      
		  $.ajax({
			  url: "../SMenu",
		        data: cadena,
		  	    type: 'post',
		        success: function(data){
		        	window.location.href="index.jsp";
		        }
			
		    });

	      }
	    );
	  }
	$(document).ready(function() {initMenu();});
	</script>
<%} %>	