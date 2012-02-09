			
			
			
			<script  type="text/javascript">
			
			  $(document).ready(function () {
			      $("#flex1").flexigrid
					({
					    dataType: 'json',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'idmenu', name: 'idmenu', width: 40, sortable: true, align: 'left' },
						{ display: 'descripcion', name: 'descripcion', width: 100, sortable: true, align: 'left' },
						{ display: 'area', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'menu_rec', name: 'menu_rec', width: 100, sortable: true, align: 'left' }
						],
					    sortname: "idmenu",
					    sortorder: "asc",
					    usepager: true,
					    title: 'Contenido',
					    useRp: true,
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200
					});
		      
			      $.post("../SMenu", {a:"editmenu"},
			          function (data) {                    
			              var arr = Array();
			              arr = eval("(" + data + ")");                    
			              $('#flex1').flexAddData(arr);                    
			       });            
			      $('#editconte').elrte({
						cssClass : 'el-rte',
						//lang     : 'es',
						width	 : 600,
					    height	 : 200,
					    toolbar  : 'complete',
						cssfiles : ['../css/elrte-inner.css']
					    
					});
			      
			      //Sacar un mensaje según el explorador 
			    if (navigator.appName.indexOf("Explorer") != -1) { 

			    	$("#validacion").html("POR FAVOR UTILIZAR OTRO NAVEGADOR PARA ESTA AREA");
			    } 

			      
			  });
			  var editidmenu=0;
			  function Guardaredit(){
				  if(editidmenu>0){
					  if($.trim($('#edit-titulo').val())!=""){
							
						  var data_cont=Base64.encode($('#editconte').elrte('val'));
						  var titulo=Base64.encode($('#edit-titulo').val());
							 $("#validacion").html($('#editconte').elrte('val')); 
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
							        	if(data.resultado=="OK"){
							        		$("#validacion").html(data.mensaje);
							        	}else{
							        		$("#validacion").html(data.mensaje);	
							        	}
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
					$('#edit-id').text(idmenu);
					 cadena = [ 'idmenu='     + idmenu,
					            'a=show',
					        ].join('&');
					
					$.ajax({
				        url: "../SMenu",
				        data: cadena,
				  	    type: 'post',
				        success: function(data){
				        	editidmenu=idmenu;
							var result=eval("(" +Base64.decode(data)+")");
							$('#edit-area').text(result.areanombre);	
							$('#edit-submenu').text(result.submenu);
				        	$('#edit-titulo').val(result.descripcion);
							$('#editconte').elrte('val', result.contenido);
							$('#edit-tam').val(result.size);
							//$('#editconte').elrte('updateSource');
				        }
					
				    });
					
				}	

			</script>
			<div class="centerd">
			<h2>Editar Contenido</h2>
			</div>
			<table id="flex1" style="display:none"></table>
			<div id="validacion"></div>
				ID:  <label id="edit-id"></label><br/>
				Titulo: <input id="edit-titulo" type="text" size="60" /><br/>
				Area Pertenece: <label id="edit-area"></label><br/>
				Sub Menu: <label id="edit-submenu"></label><br/>
				Tama&ntilde;o:<select id="edit-tam"> 
						<option value="4">Grande</option>
						<option value="3">Mediano</option>
						<option value="1">Peque&ntilde;o</option>
						<option value="0">Sin Texto</option>
				</select>
				<textarea id="editconte" class="editor"> Texto </textarea>
				
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>
				<h1>Subir Imagenes</h1>
				<input type="file" name="fichero"></input>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
				<br/><br/>
				
				<h1>Subir PDF</h1>
				<input type="file" name="fichero" ></input>
								<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
				<br/><br/>
			<div style="clear: both;"></div>
			
			