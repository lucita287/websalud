<script  type="text/javascript">
$(document).ready(function () {
$("#editconte").cleditor({
    width:        600,
    height:       250
    });
$("#editconte").cleditor()[0].focus();
});


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
				 $("#validacion_data").html("No se ha actualizado"); 
				  $.ajax({
				        url: "../SMenu",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	$("#validacion_data").html("");
				        	mensaje(data.mensaje);
				        	
				        }
					
				    }); 
				  
				  
		  }else{
			  $("#validacion_data").html("El titulo no puede estar vacio");
		  }
	  }else{
		  $("#validacion_data").html("Debe Seleccionar un item");
		  
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
		        	$('#edit-tam').val(result.size);
		        	$("#editconte").cleditor()[0].execCommand("inserthtml",result.contenido,null,null);
					$("#editconte").cleditor()[0].focus();
					
					
		        }});	

			CargarImagenes(); CargarPDF();
			limpiar();		    
			
		}
		
		function eliminar_conte(){
			 if(editidmenu>0){
					if(confirm("Confirma que desea eliminar, tambien las imagenes y pdf ")) {
						cadena = [ 'idmenu='     + editidmenu,
						            'a=deletemenu',
						        ].join('&');
						$.ajax({
					        url: "../SMenu",
					        data: cadena,
					  	    type: 'post',
					  	  	dataType: 'json',
					  	  	success: function(data){
					  	  		mensaje(data.mensaje);
					  	  		if(data.resultado=='OK'){
						  	  		editidmenu=0;
							  	  	$("#editconte").cleditor()[0].clear();
						  	  		$('#flex1').flexReload();
						  	  		limpiar();
							  	  	$('#edit-area').text('');	
									$('#edit-submenu').text('');
						        	$('#edit-titulo').val('');
						        	$('#edit-id').text('');
						        	LimpiarImagenes();
					  	  		}	
					        }});
						
					}
			 }else{
				  $("#validacion_data").html("Debe Seleccionar un item");
				  
			}
				
		}
		
</script>
				<div id="validacion_data" class="validacion"></div>
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
						<a href="#validacion_data" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#validacion_data"  class="ui-state-default ui-corner-all button-delete" onclick="eliminar_conte()"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>