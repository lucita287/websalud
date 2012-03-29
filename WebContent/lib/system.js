/**
 * 
 */
	  $(function() {
		$( "#tabs" ).tabs();
	});
	function menuarea(idarea){
		$("#menu-salud").load("portal/menu_area.jsp?idarea="+idarea);
		$("#header_carousel").load("portal/header.jsp?idarea="+idarea);
		$('#Cont-Panel-texto').load("portal/inicio.jsp?idarea="+idarea);
	}




	function Actualizar(idmenu){

		    	$('#Cont-Panel-texto').load("portal/contenido.jsp?idmenu="+idmenu);
	}
	function ppivs(){
		    	$('#Cont-Panel-texto').load("portal/ppivs.jsp");
	}

	$('#menu').hover(function() {
		
		$(this).css('cursor','pointer');
		
		}, function() {
		
		$(this).css('cursor','auto');
		
	});	
	
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

