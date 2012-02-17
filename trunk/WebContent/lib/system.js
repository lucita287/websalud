/**
 * 
 */
	
	function menuarea(idarea){
		$("#menu-principal").load("portal/menu_area.jsp?idarea="+idarea);
	}
	function back_inicio(){
		$("#menu-principal").load("portal/menu.jsp");
	}


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