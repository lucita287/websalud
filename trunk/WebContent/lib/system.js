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

		$(document).ready(
		        function() {
		        	initMenu();
		            // translate validator error msg
		            $.extend($.validator.messages, {
		            	required: "Campo Obligatorio",
		        		remote: "Por favor componga este campo.",
		        		email: "Por favor ingrese un correo electronico valido",
		        		url: "Por favor ingrese una URL valida",
		        		date: "Por favor ingrese una fecha valida.",
		        		dateISO: "Please enter a valid date (ISO).",
		        		dateDE: "Bitte geben Sie ein gültiges Datum ein.",
		        		number: "Por favor ingrese un numero validor.",
		        		numberDE: "Bitte geben Sie eine Nummer ein.",
		        		digits: "Por favor ingrese solo digitos",
		        		creditcard: "Por favor ingrese un numero de tarjeta de credito.",
		        		equalTo: "Por favor ingrese el mismo valor otra vez.",
		        		accept: "Please enter a value with a valid extension.",
		        		maxlength: $.format("Por favor no ingrese no mas de {0} caracteres."),
		        		minlength: $.format("Por favor ingrese almenos {0} caracteres."),
		        		rangelength: $.format("Por favor ingrese los valores entre {0} y {1} longitud de caracteres."),
		        		range: $.format("Please enter a value between {0} and {1}."),
		        		max: $.format(" Por favor ingrese un valor menor o igual a  {0}."),
		        		min: $.format("Por favor ingrese un valor mayor o igual a {0}.")
		            });                          
		 
		            $.extend($.validator.passwordRating.messages , {
		            		"similar-to-username": "Muy similar al nombre de usuario",
		            		"too-short": "Muy corto",
		            		"very-weak": "Muy debil",
		            		"weak": "Debil",
		            		"good": "Bueno",
		            		"strong": "Fuerte"
		            	}
		            );
		        }
		    );