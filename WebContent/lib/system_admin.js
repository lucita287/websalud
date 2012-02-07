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
 