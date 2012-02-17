<script  type="text/javascript">
$(document).ready(function () {
$("#editconte").cleditor({
    width:        600,
    height:       250
    });
$("#editconte").cleditor()[0].focus();
});

function CargarImagenes(){
	$.post("../SContenidoTable", {ptipo:1,pmenu:editidmenu},
	          function (data) {                    
	              var arr = Array();
	              arr = eval("(" + data + ")");                    
	              $('#imagenes').flexAddData(arr);                    
	       });  	 							
}

function Guardaredit(){
	  if(editidmenu>0){
		  if($.trim($('#edit-titulo').val())!=""){
			  var contenido=convertirCaracter($('#editconte').val());
			  var data_cont=Base64.encode(contenido);
			  var titulo=Base64.encode($('#edit-titulo').val());
				cadena = [ 	'idmenu='   + editidmenu,
				             	'a=guardaredit',
					            'titulo='+titulo,
					            'contenido='+data_cont,
					            'size='+$('#edit-tam').val()
					        ].join('&');
				 $("#validacion").html("No se ha actualizado"); 
				  $.ajax({
				        url: "../SMenu",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	
				        }
					
				    }); 
				  
				  
		  }else{
			  $("#validacion").html("El titulo no puede estar vacio");
		  }
	  }else{
		  $("#validacion").html("Debe Seleccionar un item");
		    }
}

		function editar(idmenu){
			$("#editconte").cleditor()[0].clear();
			editidmenu=idmenu;
			var $tabs = $('#tabs').tabs();
			$tabs.tabs('select', 0);
			$('#edit-id').text(idmenu);
			 cadena = [ 'idmenu='     + idmenu,
			            'a=show',
			        ].join('&');
			$.ajax({
		        url: "../SMenu",
		        data: cadena,
		  	    type: 'post',
		  	  	success: function(data){
		  	  		var data_desc=Base64.decode( data );
		        	result=eval("("+data_desc+")");
		        	$('#edit-area').text(result.areanombre);	
					$('#edit-submenu').text(result.submenu);
		        	$('#edit-titulo').val(result.descripcion);
					editarea=result.idarea;
					contenido=replaceAll(result.contenido,"'","\"");
					$("#editconte").cleditor()[0].execCommand("inserthtml", contenido,null,null);
					$("#editconte").cleditor()[0].focus();
		        }});	

			CargarImagenes();
			limpiar();		    
			
		}
		
</script>
				
				ID:  <label id="edit-id"></label><br/>
				Titulo: <input id="edit-titulo" type="text" size="60" /><br/>
				Area Pertenece: <label id="edit-area"></label><br/>
				Sub Menu: <label id="edit-submenu"></label><br/>
				Tama&ntilde;o:<select id="edit-tam"> 
						<option value="3">Grande</option>
						<option value="2">Mediano</option>
						<option value="1">Peque&ntilde;o</option>
						<option value="0">Sin Texto</option>
				</select>
				<textarea o id="editconte" class="editor"></textarea>
				
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>