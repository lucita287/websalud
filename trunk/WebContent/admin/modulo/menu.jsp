<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="java.util.ArrayList" %>
<%  

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
	
<ul id="menu">
	<li>
	<a >Perfil</a>
	</li>

	<li>
	<a >Administrar Contenido</a>
			
			
			<ul>
				<li>
					<a >Gestionar Contenido</a>
				</li>
				<li>
					<a >Gestionar Noticias</a>
				</li>
				<li>
					<a >Gestionar Actividades</a>
				</li>
			</ul>
	</li>
	<li>
	<a >Administrar </a>
			<ul>
				<li>
					<a >Gestionar Usuarios</a>
				</li>
				<li>
					<a >Gestionar Permisos</a>
				</li>
			</ul>	
	</li>
	<li>
		<a >Examen de Salud</a>
			<ul>
				<li>
					<a >Examen de autoevaluaci&oacute;n</a>
				</li>
				<li>
					<a >Examen Multif&aacute;setico</a>
				</li>
			</ul>
	
	</li>
	<li>
	<a >Reportes</a>
			<ul>
				<li>
					<a >Reportes</a>
				</li>
				<li>
					<a >Dashboard</a>
				</li>
			</ul>	
	</li>
</ul>
	<script>
		

	function initMenu() {
	  $('#menu ul').hide();
	  $('#menu ul:first').show();
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