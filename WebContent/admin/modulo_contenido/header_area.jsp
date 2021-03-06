<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.Iterator" %>
    <%@ page import="data.CUsuarioPermiso" %>
    <%@ page import="data.CArea" %>
    <%@ page import="framework.CDataBase" %>
    <%

	HttpSession sessiones = request.getSession(false);
	if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1){
			CDataBase dbo=new CDataBase();
			dbo.Connect();
			ArrayList<CArea> list_area=dbo.getAreaListaMenu();
			dbo.Close();
		%>		
			
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<div class="centerd">
			<h2>Editar Areas Profesionales</h2>
			
			</div>
			<div style="width: 600px; margin:0 auto 0 auto;">
			
			<table id="flex1" style="display:none"></table>
			</div>
			
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Editar Area</a></li>
				<li><a href="#tabs-2">Encabezado de Imagenes</a></li>
				
			</ul>
			
			<div id="tabs-1" style="width:750px; ">
			<div id="validacion_prin" class="validacion"></div>
						<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="idarea"></label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Nombre</div>
								<div class="col"><label id="tituloarea"></label></div>
							</div>
							
							<div class="fila">
								<div class="col_titulo">*Tama&ntilde;o:</div>
								<div class="col">
									<select id="edit-tam"> 
									<option value="4">Enorme</option>
									<option value="3">Grande</option>
									<option value="2">Mediano</option>
									<option value="1">Peque&ntilde;o</option>
									<option value="0">Sin Texto</option>
									</select>
								</div>
							</div>
							<div class="fila">
							<h3 style="color:red;">Tama&ntilde;o recomendado,  ancho = 550px, alto =440px </h3>
								<div class="col_titulo">Imagen Principal</div>
								<div class="col">
									<input id="fileup_prin" type="file" name="files[]" ><BR/>
									<img  id="hiddenimg" onclick="EliminarImagen()" width="24px"  height="24px" src="../images/delete.png"/>
									<label id="pathimagen_prin">NO SE HA SUBIDO IMAGEN</label><br/>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripcion de imagen</div>
								<div class="col"><input id="descr_imagen" type="text" size="50px" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Area donde Pertence</div>
								<div class="col">
										<select id="subarea">
											<option value="0">AREA PROFESIONAL</option>
										<% Iterator<CArea> it=list_area.iterator();
											while(it.hasNext()){
											CArea area=it.next();
										%>
											<option value="<%= area.getidarea() %>"><%= area.getnombre() %></option>
										<% } %>
										</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Etiqueta en buscadores</div>
								<div class="col">
										<textarea rows="2" cols="50" id="palabras_buscador"></textarea>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Descripcion en buscadores</div>
								<div class="col">
										<textarea rows="2" cols="50" id="descripcion_buscador"></textarea>
								</div>
							</div>		
						</div>
						
				</div>
				<div style="clear: both;"></div>		
							<textarea id="cont-text" class="editor"></textarea>
							<div class="center_button">
									<%if (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
									<a  onclick="GuardarArea()" class="ui-state-default ui-corner-all button-save" onclick="GuardarArea()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<% } %>
							</div>
			</div>
			<div id="tabs-2" style="width:750px; ">
				<jsp:include page="uploadencabezado.jsp" />
			</div>	
			</div>				
				<div style="clear: both;"></div>
				
			<script  type="text/javascript">

			var editiarea=0;
			var idmultimedia=0;
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
				            		$("#pathimagen_prin").text("No se ha subido imagen");
				            	}
				            	
				            });
				            $("#validacion_prin").html(cadena);
				        },
				        change: function (e, data) {
				        	$("#pathimagen_prin").text("Subiendo imagen por favor espere");
				        }
				    });
				});
			  $(document).ready(function () {
				  $("#cont-text").cleditor({
					    width:        600,
					    height:       250,
					    controls:     // controls to add to the toolbar
					    	                        "bold italic underline strikethrough subscript superscript | font size " +
					    	                        "style | color highlight removeformat | bullets numbering | outdent " +
					    	                        "indent | alignleft center alignright justify | undo redo | " +
					    	                        "rule image link unlink | cut copy paste pastetext | print"					    
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
				 $( function(){
						
					  var cledit = $("#cont-text").cleditor()[0];
					  $(cledit.$frame[0]).attr("id","cleditCool");

					  var cleditFrame;
					  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
					  else cleditFrame = document.frames["cleditCool"].document;
					    
				  $(cleditFrame).contents().find('body').bind('paste', function(){
					  
				        setTimeout(function() {
				            mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
				        	$("#cont-text").cleditor()[0].focus();
				        }, 100);
				       return false;
				  });
				  } );	
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
							$("#subarea").val(result.subarea);
							$("#descr_imagen").val(result.descr_imagen);
							$("#palabras_buscador").val(result.palabras_buscador);
							$("#descripcion_buscador").val(result.descripcion_buscador);
							limpiar();
							
				        }});
			  }
			  function EliminarImagen(){
				  $("#pathimagen_prin").text("NO SE HA SUBIDO IMAGEN");
				  idmultimedia=0;
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
						         'descr_imagen='+Base64.encode( convertirCaracter($("#descr_imagen").val())),
						         'palabras_buscador='+Base64.encode( convertirCaracter($("#palabras_buscador").val())),
						         'descripcion_buscador='+Base64.encode( convertirCaracter($("#descripcion_buscador").val())),
						         'subarea='+$("#subarea").val()
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
	<% }	} %>			