/**
 * 
 */
	$(function(){
		$('#panel-texto-c').jScrollPane();			
	});

	$(function() {
		$(".jCarouselLite2").jCarouselLite({
		vertical: true,
		btnNext: "#next_info",
		btnPrev: "#prev_info",
		visible: 3
	});
	});
	$(function() {	
	$(".news-inicio").click(function() {

		$("#widget-info").html($(this).attr("name"));
	});
	});
	function Actualizar(idmenu){
		 cadena = [
		           'idmenu='     + idmenu,
		        ].join('&');

		    	$('#Cont-Panel-texto').load("portal/contenido.jsp?idmenu="+idmenu);
	    

		
	}
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
    $(window).load(function() {

        $('#slider').nivoSlider();

    });

	$(function() {
		$(".menu_header").jCarouselLite({
			hoverPause:true,
			visible: 5,
			auto:500,
			speed:1000,
			scroll:1
			});
		});	