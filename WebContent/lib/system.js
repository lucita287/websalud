/**
 * 
 */
	
	function menuarea(idarea){
		$("#menu-principal").load("portal/menu_area.jsp?idarea="+idarea);
		$("#header_carousel").load("portal/header.jsp?idarea="+idarea);
		$('#Cont-Panel-texto').load("portal/inicio.jsp?idarea="+idarea);
	}
	function back_inicio(){
		$("#menu-principal").load("portal/menu.jsp?idarea=1");
		$('#Cont-Panel-texto').load("portal/inicio.jsp?idarea=1");
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

		$("#widget-info").load("portal/noticia_descripcion.jsp?idnoticia="+$(this).attr("name"));
	});
	});
	function Actualizar(idmenu){

		    	$('#Cont-Panel-texto').load("portal/contenido.jsp?idmenu="+idmenu);
	}
	function ppivs(){
		

		    	$('#Cont-Panel-texto').load("portal/ppivs.jsp");
	}


