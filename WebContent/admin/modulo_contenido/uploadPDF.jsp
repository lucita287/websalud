<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CUsuarioPermiso" %>
	<%

	HttpSession sessiones = request.getSession(false);
	if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
							
							<form id="file_uploadPDF" action="../uploadpdf" method="POST" enctype="multipart/form-data">
							    			<h2>Subir PDF</h2>
											<div id="validacion_pdf" class="validacion"></div>
											<table id="pdfs" style="display:none"></table>
											
											
									<div class="perfil">
											<div class="tabla">
														<div class="fila">
															<div class="col_titulo">ID</div>
															<div class="col"><label id="idpdf">NEW</label></div>
														</div>
														<div class="fila">
															<div class="col_titulo">*Titulo</div>
															<div class="col"><input id="titulopdf" type="text" size="40"/></div>
														</div>
														<div class="fila">
															<div class="col_titulo">Descripci&oacute;n</div>
															<div class="col"><textarea id="descripcionpdf" rows="4" cols="40"></textarea></div>
														</div>
														<div class="fila">
															<div class="col_titulo">*Imagen</div>
															<div class="col">
															<input id="fileupload_pdf" type="file" name="files[]" ><BR/>
															<label id="pathpdf">NO SE HA SUBIDO PDF</label><br>
															</div>
														</div>
											
											</div>
									</div>			
															
											<div class="center_button_2">
													<a href="#validacion_pdf"  onclick="limpiar()" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
													<% if (user_permiso.getIdpermiso().indexOf(222)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
													<a href="#validacion_pdf" onclick="guardarPDF()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
													<% } %>
													<% if (user_permiso.getIdpermiso().indexOf(223)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
													<a href="#validacion_pdf"  onclick="eliminar_Contenido(2)"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
													<% }%>	
											</div>
								
							    
							</form>
							<script  type="text/javascript">
							$(document).ready(function () {
								$("#pdfs").flexigrid
								({
									dataType : 'json',
								    colModel: [
									{display: 'Seleccionar', name : 'chkimagen', width : 30, sortable : false, align: 'left'},           
									{ display: 'ID', name: 'idcontenido', width: 40, sortable: true, align: 'left' },
									{ display: 'Titulo', name: 'titulo', width: 150, sortable: true, align: 'left' },
									{ display: 'Archivo', name: 'direccion', width: 250, sortable: true, align: 'left' }
									],
								    title: 'PDF',
								    width: 600,
								    height: 200
								});
								
							});
							function CargarPDF(){
								$.post("../SContenidoTable", {ptipo:2,pmenu:editidmenu},
								          function (data) {                    
								              var arr = Array();
								              arr = eval("(" + data + ")");                    
								              $('#pdfs').flexAddData(arr);                    
								       });  	 							
							}
							function LimpiarPDF(){
											data="{total: 0, page: 1,rows: [] }";
								              var arr = Array();
								              arr = eval("(" + data + ")");                    
								              $('#pdfs').flexAddData(arr);                    
								        	 							
							}
							function editar_conte2(idconte){
								$("#idpdf").text(idconte);
								idmultimedia2=idconte;
								 cadena = [ 'idcontenido='     + idconte,
								            'a=editconte',
								        ].join('&');
								
								$.ajax({
							       url: "../SContenido",
							       data: cadena,
							 	    type: 'post',
							       success: function(data){
							    	   var data_desc= data ;
							       		result=eval("("+data_desc+")");
							    	   idpdf=result.idimagen;
							    	   $('#titulopdf').val(result.titulo);
							    	   $('#descripcionpdf').val(result.descripcion);
							    	   $('#pathpdf').text(result.direccion);
							       }});	
							
							}
							var idpdf=0;
							var idmultimedia2=0;
							$(function () {
								 $('#fileupload_pdf').fileupload({
							        dataType: 'json',
							        url: '../uploadpdf',
							        done: function (e, data) {
							        	
							        	cadena="";
							        	ok=false;
							            $.each(data.result, function (index, file) {
							            	if(index=='result' ){
							            		cadena=cadena+file+"<br/>";	
							            		if(file=='OK')ok=true;
							            	}
							            	if(index=='name'&&ok==true){
							            		$('#pathpdf').text(file);
							            	}
							            	if(index=='idsafe'&&ok==true){
							            		idpdf=file;
							            	}
							            	if(index=='Mensaje'&&ok==false){
							            		cadena=cadena+file+"<br/>";	
							            	}
							            	
							            });
							            $("#validacion_pdf").html(cadena);
							        },
							        change: function (e, data) {
							        	$("#pathpdf").text("Subiendo imagen por favor espere");
							        }
							    });
							});
							
							function guardarPDF(){
								
								var titulo=($.trim($("#titulopdf").val()));
								var descripcion=($.trim($("#descripcionpdf").val()));	
								b=editidmenu<1;
								if(b) $("#validacion_pdf").html("Debe seleccionar un item");
								else{ b=titulo=="";
									if(b) $("#validacion_pdf").html("Debe ingresar el titulo");
										
									}
								
								if(!b){
									
									$("#validacion_pdf").html("");	
									cadena ="";	
									action="guardaredit";
									if(idmultimedia2==0){
										action="guardaredit";
											}else{
												action="updateedit";		
										}
									cadena = [ 	'idimagen='   + idpdf,
								             	'a='+action,
									            'titulo='+titulo,
									            'contenido='+descripcion,
									            'idmenu='     + editidmenu,
									            'idconte='+idmultimedia2
									        ].join('&');
									 $.ajax({
									        url: "../SContenido",
									        data: cadena,
									  	    type: 'post',
									        dataType: 'json',
									        success: function(data){
									        	mensaje(data.mensaje);
									        	if(data.resultado=='OK'){
									        		CargarPDF();
									        		limpiar();
									        	}	
									        }
									    });
										
								}
							}
							
							
							
							</script>
		<%}
} %>