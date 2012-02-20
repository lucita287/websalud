	<script  type="text/javascript">
	
			var editiarea=0;
			var idmultimedia=0;
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
					caracter=replaceAll(caracter,"Ü","&Uuml;");
					caracter=replaceAll(caracter,"ü","&uuml;");
					return caracter;
				}
			  function replaceAll( text, busca, reemplaza ){
				  while (text.toString().indexOf(busca) != -1)
				      text = text.toString().replace(busca,reemplaza);
				  return text;
				}
			  $(function () {
					 $('#fileup_prin').fileupload({
				        dataType: 'json',
				        url: '../uploadimagen',
				        done: function (e, data) {
				        	
				        	cadena="";
				        	ok=false;
				            $.each(data.result, function (index, file) {
				            	if(index=='result' ){
				            		cadena=cadena+file+"<br/>";	
				            		if(file=='OK')ok=true;
				            	}
				            	if(index=='name'&&ok==true){
				            		$('#pathimagen_prin').text(file);
				            	}
				            	if(index=='idsafe'&&ok==true){
				            		idmultimedia=file;
				            	}
				            	if(index=='Mensaje'&&ok==false){
				            		cadena=cadena+file+"<br/>";	
				            	}
				            	
				            });
				            $("#validacion_prin").html(cadena);
				        }
				    });
				});
			  $(document).ready(function () {
				  $("#cont-text").cleditor({
					    width:        600,
					    height:       250
					    });
				  $("#cont-text").cleditor()[0].focus();
				  $( "#dialog:ui-dialog" ).dialog( "destroy" );
				  $("#flex1").flexigrid
					({
						method: 'POST',
						 url: '../SAreaTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'idarea', name: 'idmenu', width: 40, sortable: true, align: 'left' },
						{ display: 'nombre', name: 'descripcion', width: 100, sortable: true, align: 'left' },
						{ display: 'Area', name: 'menu_rec', width: 100, sortable: true, align: 'left' }
						],
					    title: 'Area',
					    width: 600,
					    height: 200
					});				  
			  
					
			  });
			  
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
			  function editararea(idarea){
				  $("#cont-text").cleditor()[0].clear();
				  editiarea=idarea;
				  var $tabs = $('#tabs').tabs();
					$tabs.tabs('select', 0);
				  $('#idarea').text(idarea);
				  cadena = [ 'idarea='     + idarea,
					            'a=show',
					        ].join('&');
				  $.ajax({
				        url: "../SArea",
				        data: cadena,
				  	    type: 'post',
				  	  	success: function(data){
				  	  		var data_desc=Base64.decode( data );
				        	result=eval("("+data_desc+")");
				        	$('#tituloarea').text(result.nombre);
				        	$('#edit-tam').val(result.size);
				        	idmultimedia=result.idimagen;
				        	$('#pathimagen_prin').text(result.direccion_relativa);
				        	$("#cont-text").cleditor()[0].execCommand("inserthtml",result.contenido,null,null);
							$("#cont-text").cleditor()[0].focus();
							limpiar();
							
				        }});
			  }
			  function GuardarArea(){
				  if(editiarea>0){
					  var contenido=convertirCaracter($('#cont-text').val());
					  var data_cont=Base64.encode(contenido);
					  cadena = [ 'idarea='     + editiarea,
						         'a=guardaredit',
						         'contenido='+data_cont,
						         'idmultimedia='+idmultimedia,
						         'size='+$('#edit-tam').val(),
						        ].join('&');
					  
					  $.ajax({
					        url: "../SArea",
					        data: cadena,
					  	    type: 'post',
					        dataType: 'json',
					        success: function(data){
					        	$("#validacion_prin").html("");
					        	mensaje(data.mensaje);
					        	
					        }
						
					    });
				  }else{
					  mensaje("Debe seleccionar un &aacute;rea");
				  }
			  }
			  
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<div class="centerd">
			<h2>Editar Areas Profesionales</h2>
			</div>
			<div style="width: 600px; margin:0 auto 0 auto;">
			<div id="validacion_prin" class="validacion"></div>
			<table id="flex1" style="display:none"></table>
			</div>
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Editar Area</a></li>
				<li><a href="#tabs-2">Encabezado de Imagenes</a></li>
				
			</ul>
			
			<div id="tabs-1" style="width:1000px; ">
							<table>
								<tr>
									<td>IDEN</td>
									<td><label id="idarea"></label> </td>	
								</tr>
								<tr>
									
									<td>Nombre</td>
									<td><label id="tituloarea"></label> </td>	
								</tr>
							<tr>
								<td>Tama&ntilde;o:</td>
								<td><select id="edit-tam"> 
									<option value="3">Grande</option>
									<option value="2">Mediano</option>
									<option value="1">Peque&ntilde;o</option>
									<option value="0">Sin Texto</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>Imagen Principal</td>
								<td>
									<input id="fileup_prin" type="file" name="files[]" ><BR/>
									<label id="pathimagen_prin">NO SE HA SUBIDO IMAGEN</label><br/>
								</td>
							</tr>
							
							</table>		
							<textarea id="cont-text" class="editor"></textarea>
							<br/><br/>
							<div class="centerd">
									<a href="#validacion_prin" onclick="GuardarArea()" class="ui-state-default ui-corner-all button-save" onclick="GuardarArea()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
							</div>
							<br/><br/>
			</div>
			<div id="tabs-2" style="width:1000px; ">
				<jsp:include page="uploadencabezado.jsp" />
			</div>	
			</div>				
				<div style="clear: both;"></div>