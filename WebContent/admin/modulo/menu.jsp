<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="java.util.ArrayList" %>
<% 
HttpSession sessiones = request.getSession(false);
Integer portal=(Integer)(sessiones.getAttribute("portal")==null?1:sessiones.getAttribute("portal"));
%>
	<style type="text/css">
#contenido {width:75%; float:left; }
		#menu-principal {  width:25%;  float:left; }
ul#menu, ul#menu ul {
  list-style-type:none;
  margin: 0;
  padding: 0;
  width: 20em;
}

ul#menu a {
  display: block;
  text-decoration: none;	
}

ul#menu li {
  margin-top: 1px;
}

ul#menu li a {
  background: #333;
  color: #fff;	
  padding: 0.5em;
}

ul#menu li a:hover {
  background: #000;
}

ul#menu li ul li a {
  background: #ccc;
  color: #000;
  padding-left: 20px;
}

ul#menu li ul li a:hover {
  background: #aaa;
  border-left: 5px #000 solid;
  padding-left: 15px;
}


	</style>
	
<ul id="menu"  >
	<li >
	<a id="1">Perfil</a>
	</li>

	<li>
	<a   >Administrar Contenido</a>
			
			
			<ul id="admin_conte">
				<li  >
					<a id="2" >Editar Contenido</a>
				</li>
				<li >
					<a  id="3" >Nuevo Contenido</a>
				</li>
				<li>
					<a id="4">Gestionar Noticias</a>
				</li>
				<li>
					<a id="5">Gestionar Actividades</a>
				</li>
				<li>
					<a  id="6">Gestionar Areas</a>
				</li>
			</ul>
	</li>
	<li >
	<a >Administrar </a>
			<ul id="admin">
				<li >
					<a id="7">Gestionar Usuarios</a>
				</li>
				<li>
					<a id="8">Gestionar Permisos</a>
				</li>
			</ul>	
	</li>
	<li>
		<a >Examen de Salud</a>
			<ul id="exam">
				<li>
					<a id="9" >Examen de autoevaluaci&oacute;n</a>
				</li>
				<li>
					<a id="10">Examen Multif&aacute;setico</a>
				</li >
			</ul>
	
	</li>
	<li>
	<a >Reportes</a>
			<ul id="report">
				<li>
					<a id="11">Reportes</a>
				</li>
				<li>
					<a id="12" >Dashboard</a>
				</li>
			</ul>	
	</li>
</ul>
	<script>
		

	
	function initMenu() {
	  $('#menu ul').hide();
	  
	  <% if(portal>1 && portal<7){%>
	  $('#admin_conte').show();
	  <% }else if(portal>6 && portal<9){ %>
	  $('#admin').show();
	  <% }else if(portal>8 && portal<11){ %>
	  $('#exam').show();
	  <% }else if(portal>10 && portal<13){ %>
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