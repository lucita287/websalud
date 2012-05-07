  $(function() {
		$( "#tabs" ).tabs();
	});
	
  function cambiarArea(){
	 
	  cadena = [ 	'idarea='   + $("#new-area").val(),
	             	'a=showsubmenu',
		        ].join('&');

	 
	  $('#new-submenu').children().remove().end();
	  $.ajax({
	        url: "../SMenu",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	var array = eval(data.menus);
	        	for (var i = 0; i < array.length; i++)
	        	{
	        		 $('#new-submenu').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        	}
	        }
		
	       }); 
	  
  } 
	 function convertirCaracter(caracter){
			caracter=replaceAll(caracter,String.fromCharCode(225),"&aacute;");
			caracter=replaceAll(caracter,String.fromCharCode(224),"&aacute;");
			caracter=replaceAll(caracter,String.fromCharCode(233),"&eacute;");
			caracter=replaceAll(caracter,String.fromCharCode(232),"&eacute;");
			caracter=replaceAll(caracter,String.fromCharCode(236),"&iacute;");
			caracter=replaceAll(caracter,String.fromCharCode(237),"&iacute;");
			caracter=replaceAll(caracter,String.fromCharCode(242),"&oacute;");
			caracter=replaceAll(caracter,String.fromCharCode(243),"&oacute;");
			caracter=replaceAll(caracter,String.fromCharCode(249),"&uacute;");
			caracter=replaceAll(caracter,String.fromCharCode(250),"&uacute;");
			caracter=replaceAll(caracter,String.fromCharCode(192),"&Aacute;");
			caracter=replaceAll(caracter,String.fromCharCode(193),"&Aacute;");
			caracter=replaceAll(caracter,String.fromCharCode(200),"&Eacute;");
			caracter=replaceAll(caracter,String.fromCharCode(201),"&Eacute;");
			caracter=replaceAll(caracter,String.fromCharCode(204),"&Iacute;");
			caracter=replaceAll(caracter,String.fromCharCode(205),"&Iacute;");
			caracter=replaceAll(caracter,String.fromCharCode(210),"&Oacute;");
			caracter=replaceAll(caracter,String.fromCharCode(211),"&Oacute;");
			caracter=replaceAll(caracter,String.fromCharCode(217),"&Uacute;");
			caracter=replaceAll(caracter,String.fromCharCode(218),"&Uacute;");
			caracter=replaceAll(caracter,String.fromCharCode(241),"&ntilde;");
			caracter=replaceAll(caracter,String.fromCharCode(209),"&Ntilde;");
			caracter=replaceAll(caracter,String.fromCharCode(220),"&Uuml;");
			caracter=replaceAll(caracter,String.fromCharCode(252),"&uuml;");
			caracter=replaceAll(caracter,String.fromCharCode(183),"&#183;");
			caracter=replaceAll(caracter,String.fromCharCode(8211),"&#8211;");
			caracter=replaceAll(caracter,String.fromCharCode(8212),"&#8212;");
			caracter=replaceAll(caracter,String.fromCharCode(8226),"&#8226;");
			caracter=replaceAll(caracter,String.fromCharCode(8220),"&#34;");
			caracter=replaceAll(caracter,String.fromCharCode(8221),"&#34;");
			caracter=replaceAll(caracter,String.fromCharCode(8222),"&#34;");
			caracter=replaceAll(caracter,String.fromCharCode(8216),"&#34;");
			caracter=replaceAll(caracter,String.fromCharCode(8217),"&#34;");
			caracter=replaceAll(caracter,String.fromCharCode(8218),"&#44;");
			caracter=replaceAll(caracter,String.fromCharCode(8230),"&#8230;");
			caracter=replaceAll(caracter,String.fromCharCode(33),"&#33;");
			caracter=replaceAll(caracter,String.fromCharCode(161),"&#161;");
			return caracter;
		}
	  function replaceAll( text, busca, reemplaza ){
		  while (text.toString().indexOf(busca) != -1)
		      text = text.toString().replace(busca,reemplaza);
		  return text;
		}
	  function mensaje(mens){
		  
		  $( "#dialog-message" ).html(mens);
			$( "#dialog-message" ).dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$( this ).dialog( "close" );
					}
				}
			});
	  }