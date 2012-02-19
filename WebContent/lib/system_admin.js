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
		caracter=replaceAll(caracter,"á","&aacute;");
		caracter=replaceAll(caracter,"é","&eacute;");
		caracter=replaceAll(caracter,"í","&iacute;");
		caracter=replaceAll(caracter,"ó","&oacute;");
		caracter=replaceAll(caracter,"ú","&uacute;");
		caracter=replaceAll(caracter,"Á","&Aacute;");
		caracter=replaceAll(caracter,"É","&Eacute;");
		caracter=replaceAll(caracter,"Í","&Iacute;");
		caracter=replaceAll(caracter,"Ó","&Oacute;");
		caracter=replaceAll(caracter,"Ú","&Uacute;");
		caracter=replaceAll(caracter,"ñ","&ntilde;");
		caracter=replaceAll(caracter,"Ñ","&Ntilde;");
		return caracter;
	}
  function replaceAll( text, busca, reemplaza ){
	  while (text.toString().indexOf(busca) != -1)
	      text = text.toString().replace(busca,reemplaza);
	  return text;
	}