<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="java.util.ArrayList" %>

	
<ul id="menu"  >
	<li >
		<a >PASO 1</a>
			<ul id="admin">
				<li >
					<a id="1">Datos personales</a>
				</li>
				<li>
					<a id="2">Estatus del estudiante</a>
				</li>
			</ul>	
	</li>
	<li >
		<a >PASO 2</a>
			<ul id="admin">
				<li >
					<a id="3">CABEZA</a>
				</li>
				<li>
					<a id="2">OJO</a>
				</li>
				<li>
					<a id="3">ODÍDOS, NARIZ y GARGANTA</a>
				</li>
				<li>
					<a id="3">ALERGÍAS</a>
				</li>
			</ul>	
	</li>
	<li >
		<a >PASO 2</a>
			<ul id="admin">
				<li >
					<a id="3">Salud Oral</a>
				</li>
				<li>
					<a id="2">H&aacute;bitos Higi&eacute;nicos</a>
				</li>
				<li>
					<a id="2">Salud Mental</a>
				</li>
				<li >
					<a id="3">CABEZA</a>
				</li>
				<li>
					<a id="2">OJO</a>
				</li>
				<li>
					<a id="3">ODÍDOS, NARIZ y GARGANTA</a>
				</li>
				<li>
					<a id="3">ALERGÍAS</a>
				</li>
			</ul>	
	</li>
	<li >
		<a >PASO 3</a>
			<ul id="admin">
				<li >
					<a id="3">Citas</a>
				</li>
				<li>
					<a id="2">Reportes</a>
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
