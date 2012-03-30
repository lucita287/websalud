<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuarioPermiso" %>
<%

		
		HttpSession sessiones = request.getSession(false);
		if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
			
			CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

			CDataBase	data=new CDataBase();
			data.Connect();
			ArrayList<CArea> list=data.getAreaLista(user_permiso.getIdarea());
			data.Close();
			
			if (user_permiso.getIdpermiso().indexOf(225)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		

			<div class="centerd">
			<H2>Noticias</H2>
			</div>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>			
			
			<table id="flex1" style="display:none"></table>
					
			
			
			
			
			<div class="perfil">
							<div class="tabla">
										<div class="fila">
											<div class="col_titulo">ID</div>
											<div class="col"><label id="idnew">NEW</label></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Titulo</div>
											<div class="col"><input id="titulo_noticia" type="text" size="50" /></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Estado</div>
											<div class="col">
																<select id="selec-estado">
																	<option value="1" selected>ACTIVO</option>
																	<option value="0" >DESACTIVADO</option>
																</select>
											</div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Descripci&oacute;n Corta</div>
											<div class="col"><textarea id="descripcion_noti" rows="3" cols="50"></textarea></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Descripci&oacute;n</div>
											<div class="col"><textarea id="editnoti" ></textarea></div>
										</div>
										
										<div class="fila">
										
										<div id="validacion_imagen" class="validacion"></div>
											<div class="col_titulo">Imagen</div>
											<div class="col">
													<input id="fileupload" type="file" name="files[]" ><BR/>
													<img  id="hiddenimg" onclick="EliminarImagen()" width="24px"  height="24px" src="../images/delete.png"/> 
													<label id="pathimagen">NO SE HA SUBIDO IMAGEN</label><br/>
											</div>
											<div class="col">
											<h3 style="color:red;">Tama&ntilde;o recomendado,  ancho = 750px </h3>
											</div>
										</div>
										<div class="fila">
											<div class="col_titulo">PDF</div>
											<div class="col">
													<input id="fileupload_pdf" type="file" name="files[]" ><BR/>
													<img  id="hiddenpdf" onclick="EliminarPDF()" width="24px"  height="24px" src="../images/delete.png"/> 
													<label id="pathpdf">NO SE HA SUBIDO PDF</label><br/>
											</div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Area</div>
											<div class="col">
													<select id="selec-area">
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
													<% } %>
													</select>
											</div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Fecha de Inicio</div>
											<div class="col"><input id="start_date" type="text" class="datepicker"/></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Fecha de Fin</div>
											<div class="col"><input id="end_date" type="text" class="datepicker"/></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Prioridad</div>
											<div class="col">
														<select id="prioridadnoti" > 
																<option value="1">BAJA</option>
																<option value="2">MEDIA</option>
																<option value="3">ALTA</option>
														</select>
											</div>
										</div>
							</div>
				</div>			
								
									
								<div class="center_button_2">	 	
										<a href="#validacion_imagen"  class="ui-state-default ui-corner-all button-new" onclick="limpiar()"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
									<%if (user_permiso.getIdpermiso().indexOf(226)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
										<a href="#validacion_imagen" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<% }%>
									<%if (user_permiso.getIdpermiso().indexOf(227)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
										<a href="#validacion_imagen"  onclick="eliminarnoti()"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<% }%>	
								</div>
								
											
								<div style="clear: both;"></div>	
				<script  type="text/javascript">
				var idimagen=0;
				var idpdf=0;
				var idnoticia=0;
				$(function() {
					$( "#tabs" ).tabs();
				});
		
			  $(document).ready(function () {
				  $("#editnoti").cleditor({
					    width:        450,
					    height:       200,
					    controls:     // controls to add to the toolbar
	                        "bold italic underline strikethrough subscript superscript | font size " +
	                        "style | color highlight removeformat | bullets numbering | outdent " +
	                        "indent | alignleft center alignright justify | undo redo | " +
	                        "rule image link unlink | cut copy paste pastetext | print"
				      });
				  $("#editnoti").cleditor()[0].focus();
				  $("#flex1").flexigrid
					({
						method: 'POST',
						 url: '../SNoticiaTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idnoticia', width: 40, sortable: true, align: 'left' },
						{ display: 'Titulo', name: 'titulo', width: 100, sortable: true, align: 'left' },
						{ display: 'Area', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'Fecha Inicio', name: 'fecha', width: 150, sortable: true, align: 'left' },
						{ display: 'Estado', name: 'estado', width: 100, sortable: true, align: 'left' }
						],
					    usepager: true,
					    sortname: "idnoticia",
						sortorder: "desc",
					    title: 'Noticia',
					    useRp: true,
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200,
					    searchitems : [
						{display: 'titulo', name : 'titulo'},
						{display: 'area', name : 'area', isdefault: true}
						]
					});

			  }); 
			  $(function() {
					$( ".datepicker" ).datepicker();
					$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
					$(".datepicker").mask("99/99/9999");
				});
			  $( function(){
	
				  var cledit = $("#editnoti").cleditor()[0];
				  $(cledit.$frame[0]).attr("id","cleditCool");

				  var cleditFrame;
				  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
				  else cleditFrame = document.frames["cleditCool"].document;
				    
			  $(cleditFrame).contents().find('body').bind('paste', function(){
				  
			        setTimeout(function() {
			            mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
			        	$("#editnoti").cleditor()[0].clear();
			        	$("#editnoti").cleditor()[0].focus();
			        }, 100);
			       
			  });
			  } );
			  
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
				        }
				    });		 
				});
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
				            $("#validacion_imagen").html(cadena);
				        }
				    });
				});
			  function EliminarImagen(){
				  $("#pathimagen").text("NO SE HA SUBIDO IMAGEN");
				  idimagen=0;
			  }
			  function EliminarPDF(){
				  $("#pathpdf").text("NO SE HA SUBIDO IMAGEN");
				  idpdf=0;
			  }
			  function limpiar(){
				  $("#titulo_noticia").val('');
				  $("#editnoti").cleditor()[0].clear();
				  $("#editnoti").cleditor()[0].focus();
				  $("#start_date").val('');
				  $("#end_date").val('');
				  EliminarImagen();
				  EliminarPDF();
				  $('#idnew').text('NEW');
				  $("#prioridadnoti").val('1');
				  idnoticia=0;
				  $("#flex1").flexReload(); 
				  $("#descripcion_noti").val('');
				  $("#selec-estado").val(1);
				  $("#validacion_imagen").html('');
			  }
			  function Guardaredit(){
					var titulo=convertirCaracter($.trim($("#titulo_noticia").val()));
					var descripcion=convertirCaracter($.trim($("#editnoti").val()));
				    var descripcion_corta=convertirCaracter($.trim($("#descripcion_noti").val()));
				    var action="new_noticia";
				if(idnoticia==0){
					action="new_noticia";
				}else{
					action="safe_noticia";						
				}
				cadena = [ 'a='+action,
				            'idnoticia='     + idnoticia,
				            'idimagen='   + idimagen,
				            'idpdf='   + idpdf,
				            'titulo='+Base64.encode(titulo),
				            'contenido='+Base64.encode(descripcion),
				            'fecha_inicio='+Base64.encode($("#start_date").val()),
				            'fecha_fin='+Base64.encode($("#end_date").val()),
				            'idarea='+$("#selec-area").val(),
				            'prioridad='+$("#prioridadnoti").val(),
				            'descripcion='+Base64.encode(descripcion_corta),
				            'estado='+$('#selec-estado').val()
				        ].join('&');
				$.ajax({
			        url: "../SNoticia",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiar();
			        	}
			        }
			    });
			  }
			 function editarnoticia(idnnew){
				 $("#editnoti").cleditor()[0].clear();
				 cadena = [ 'a=show_news',
				            'idnoticia='     + idnnew,
				        ].join('&');
				 $('#idnew').text(idnnew);
				 $.ajax({
				        url: "../SNoticia",
				        data: cadena,
				  	    type: 'post',
				        success: function(data){
				        	idnoticia=idnnew;
				        	var data_desc=Base64.decode( data );
				        	result=eval("("+ data_desc+")");
				        	$("#titulo_noticia").val(result.titulo);
							$("#start_date").val(result.fecha_inicio);
							$("#end_date").val(result.fecha_fin);
							$("#prioridadnoti").val(result.prioridad);
							$("#pathimagen").text(result.idimagendir);
							$("#pathpdf").text(result.idpdfdir);
							$("#descripcion_noti").val(result.descripcion_corta);
							$("#editnoti").cleditor()[0].execCommand("inserthtml",result.descripcion,null,null);
							$("#editnoti").cleditor()[0].focus();
							$('#selec-estado').val(result.estado);
							$("#selec-area").val(result.idarea);
							//$("#grid_list").flexOptions({url: newurl/'}); 
							idimagen=result.idimagen;
							idpdf=result.idpdf;
				        }
				    });
			 }
			  function eliminarnoti(){
				 cadena = [ 'a=eliminar_noticia',
				            'idnoticia='     + idnoticia,
				        ].join('&');
				 
				 $.ajax({
				        url: "../SNoticia",
				        data: cadena,
				  	    type: 'post',
				  	  	dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		limpiar();
				        	}
				        }
				    });
			 }
			</script>
<%			}		
	} %>			