<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CUsuarioPermiso" %>
	<%

	HttpSession sessiones = request.getSession(false);
	if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
		
						<form id="file_upload" action="../uploadimagen" method="POST" enctype="multipart/form-data">
						    			<h2>Subir Imagenes</h2>
						    			<h3 style="color:red;">Tama&ntilde;o recomendado,  ancho = 550px </h3>
										<div id="validacion_imagen" class="validacion"></div>
										<table id="imagenes" style="display:none"></table>


								<div class="perfil">
									<div class="tabla">
												<div class="fila">
													<div class="col_titulo">ID</div>
													<div class="col"><label id="idimagen">NEW</label></div>
												</div>
												<div class="fila">
													<div class="col_titulo">*Titulo</div>
													<div class="col"><input id="tituloimagen" type="text" size="40"/></div>
												</div>
												<div class="fila">
													<div class="col_titulo">Descripci&oacute;n</div>
													<div class="col"><textarea id="descripcionimagen" rows="4" cols="40"></textarea></div>
												</div>
																								<div class="fila">
													<div class="col_titulo">*Imagen</div>
													<div class="col">
														<input id="fileupload" type="file" name="files[]" ><BR/>
														<label id="pathimagen">NO SE HA SUBIDO IMAGEN</label><br/>
													</div>
												</div>
									</div>
							</div>		
										<div class="center_button_2">
												<a href="#validacion_imagen"  onclick="limpiar()" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
												<% if (user_permiso.getIdpermiso().indexOf(222)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
														<a href="#validacion_imagen" onclick="guardarImagen()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
												<%	} %>
												<% if (user_permiso.getIdpermiso().indexOf(223)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
												<a href="#validacion_imagen"  onclick="eliminar_Contenido(1)"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
												<% }%>	
										</div>
										<br/><br/>
							
						    
						</form>
						<script  type="text/javascript">
						$(document).ready(function () {
							$("#imagenes").flexigrid
							({
								dataType : 'json',
							    colModel: [
								{display: 'Seleccionar', name : 'chkimagen', width : 30, sortable : false, align: 'left'},           
								{ display: 'ID', name: 'idcontenido', width: 40, sortable: true, align: 'left' },
								{ display: 'Titulo', name: 'titulo', width: 150, sortable: true, align: 'left' },
								{ display: 'Archivo', name: 'direccion', width: 250, sortable: true, align: 'left' }
								],
							    title: 'IMAGENES',
							    width: 600,
							    height: 200
							    
							});
							
							
						});
						function CargarImagenes(){
							$.post("../SContenidoTable", {ptipo:1,pmenu:editidmenu},
							          function (data) {                    
							              var arr = Array();
							              arr = eval("(" + data + ")");                    
							              $('#imagenes').flexAddData(arr);                    
							       });  	 							
						}
						function LimpiarImagenes(){
										data="{total: 0, page: 1,rows: [] }";
							              var arr = Array();
							              arr = eval("(" + data + ")");                    
							              $('#imagenes').flexAddData(arr);                    
							        	 							
						}
						function editar_conte1(idconte){
							$("#idimagen").text(idconte);
							idmultimedia=idconte;
							 cadena = [ 'idcontenido='     + idconte,
							            'a=editconte',
							        ].join('&');
							
							$.ajax({
						       url: "../SContenido",
						       data: cadena,
						 	    type: 'post',
						       success: function(data){
						    	   var data_desc=Base64.decode( data );
						      		result=eval("("+data_desc+")");
						    	   idimagen=result.idimagen;
						    	   $('#tituloimagen').val(result.titulo);
						    	   $('#descripcionimagen').val(result.descripcion);
						    	   $('#pathimagen').text(result.direccion);
						       }});	
						
						}
						var idimagen=0;
						var idmultimedia=0;
						$(function () {
							 $('#fileupload').fileupload({
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
						            		$('#pathimagen').text(file);
						            	}
						            	if(index=='idsafe'&&ok==true){
						            		idimagen=file;
						            	}
						            	if(index=='Mensaje'&&ok==false){
						            		cadena=cadena+file+"<br/>";	
						            	}
						            	
						            });
						            $("#validacion_imagen").html(cadena);
						        },
						        change: function (e, data) {
						        	$("#pathimagen").text("Subiendo imagen por favor espere");
						        }
						    });
						});
						function limpiar(){
							   idimagen=0;
							   idmultimedia=0;
							   $('#idimagen').text('NEW');
							   $('#tituloimagen').val('');
							   $('#descripcionimagen').val('');
							   $('#validacion_prin').html("");
							   $("#validacion_data").html("");
							   $('#pathimagen').text('NO SE HA SUBIDO IMAGEN');
							   $("#validacion_imagen").html("");
							   idpdf=0;
							   idmultimedia2=0;
							   $('#idpdf').text('NEW');
							   $('#titulopdf').val('');
							   $('#descripcionpdf').val('');
							   $('#pathpdf').text('NO SE HA SUBIDO PDF');
							   $("#validacion_pdf").html("");
						}
						function guardarImagen(){
							var titulo=($.trim($("#tituloimagen").val()));
							var descripcion=($.trim($("#descripcionimagen").val()));	
							b=editidmenu<1;
							if(b) $("#validacion_imagen").html("Debe seleccionar un item");
							else{ b=titulo=="";
								if(b) $("#validacion_imagen").html("Debe ingresar el titulo");
								}
							if(!b){
							
								$("#validacion_imagen").html("");
							var cadena="";
							var action="guardaredit";
									if(idmultimedia==0){
										action="guardaredit";
									}else{
										action="updateedit";							
									}
									cadena = [ 	'idimagen='   + idimagen,
								             	'a='+action,
									            'titulo='+Base64.encode(titulo),
									            'contenido='+Base64.encode(descripcion),
									            'idmenu='     + editidmenu,
									            'idconte='+idmultimedia
									        ].join('&');
									
									  $.ajax({
									        url: "../SContenido",
									        data: cadena,
									  	    type: 'post',
									        dataType: 'json',
									        success: function(data){
									        	mensaje(data.mensaje);
									        	if(data.resultado=='OK'){
									        		CargarImagenes();
									        		limpiar();
									        	}
									        }
									    });
							}
						}
						
						function eliminar_Contenido(id){
							var idenviar=0;
							if(id==1)
								idenviar=idmultimedia;
							else
								idenviar=idmultimedia2;
							
							
							 if(idenviar>0){
									if(confirm("Confirma que desea eliminar el archivo ")) {
										cadena = [ 'idcontenido='     + idenviar,
										            'a=deleteconte',
										        ].join('&');
										$.ajax({
									        url: "../SContenido",
									        data: cadena,
									  	    type: 'post',
									  	  	dataType: 'json',
									  	  	success: function(data){
									  	  		mensaje(data.mensaje);
									  	  		if(data.resultado=='OK'){
										  	  		limpiar();
										  	  		CargarImagenes(); CargarPDF();
									  	  		}	
									        }});
										
									}
							 }else{
								 mensaje("Debe Seleccionar un archivo");
						
							}
								
						}
						
						</script>
	<%}
} %>				