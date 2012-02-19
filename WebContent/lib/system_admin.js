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
		caracter=replaceAll(caracter,"�","&aacute;");
		caracter=replaceAll(caracter,"�","&eacute;");
		caracter=replaceAll(caracter,"�","&iacute;");
		caracter=replaceAll(caracter,"�","&oacute;");
		caracter=replaceAll(caracter,"�","&uacute;");
		caracter=replaceAll(caracter,"�","&Aacute;");
		caracter=replaceAll(caracter,"�","&Eacute;");
		caracter=replaceAll(caracter,"�","&Iacute;");
		caracter=replaceAll(caracter,"�","&Oacute;");
		caracter=replaceAll(caracter,"�","&Uacute;");
		caracter=replaceAll(caracter,"�","&ntilde;");
		caracter=replaceAll(caracter,"�","&Ntilde;");
		return caracter;
	}
  function replaceAll( text, busca, reemplaza ){
	  while (text.toString().indexOf(busca) != -1)
	      text = text.toString().replace(busca,reemplaza);
	  return text;
	}