<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CMenu" %>
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
	


if (user_permiso.getIdpermiso().indexOf(224)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
			<script type="text/javascript" src="../lib/system_admin.js" charset="utf-8"></script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<div class="centerd">
			<H2>Nuevo Contenido</H2>
			</div>
				<div id="validacion_conte" class="validacion"></div>
				
				<div class="perfil">
						<div class="tabla">
									<div class="fila">
												<div class="col_titulo">*Titulo</div>
												<div class="col"><input id="new-titulo" type="text" size="60" /></div>
									</div>
									<div class="fila">
												<div class="col_titulo">*Area Pertenece</div>
												<div class="col"><select id="new-area" onchange="cambiarArea()">
																		<option value="0" selected>SELECCIONE UN AREA</option>
																		<% for(int j=0; j<list.size();j++){ 
																			CArea area=list.get(j);
																		%>
																			<option value="<%=area.getidarea()%>" ><%= area.getnombre()%></option>
																		<% } %>
																	</select>
												</div>
									</div>
									<div class="fila">
												<div class="col_titulo">*Sub Parte</div>
												<div class="col">
													 <select id="new-submenu">
													
													</select>
												</div>
									</div>
									<div class="fila">
												<div class="col_titulo">*Tama&ntilde;o</div>
												<div class="col">
													<select id="new-tam"> 
															<option value="4">Enorme</option>
															<option value="3">Grande</option>
															<option value="2">Mediano</option>
															<option value="1">Peque&ntilde;o</option>
															<option value="0">Sin Texto</option>
													</select>
												</div>
									</div>
						</div>
				</div>											
				<div style="clear: both;"></div>
				
				<textarea id="cont-text" class="editor"></textarea>
				<div class="center_button">
						<a href="#validacion_conte" class="ui-state-default ui-corner-all button-save" onclick="Guardarnew()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#validacion_conte" class="ui-state-default ui-corner-all button-delete" onclick="limpiar()"> <img  width="24px"  height="24px" src="../images/add.png" /> Limpiar</a>	
				</div>
				<div style="clear: both;"></div>
				
				<script  type="text/javascript">

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
			  });
			  $( function(){
					
				  var cledit = $("#cont-text").cleditor()[0];
				  $(cledit.$frame[0]).attr("id","cleditCool");

				  var cleditFrame;
				  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
				  else cleditFrame = document.frames["cleditCool"].document;
				    
			$(cleditFrame).contents().find('body').bind('paste', function(){
				  
			      setTimeout(function() {
			          mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
			      	$("#cont-text").cleditor()[0].clear();
			      }, 100);
			     
			});
			} );
			  
			  function Guardarnew(){

					  if($.trim($('#new-titulo').val())!=""){
						  if($('#new-submenu').val()>0 && $('#new-area').val()>0){	
								  var data_cont=Base64.encode(($('#cont-text').val()));
								  var titulo=Base64.encode(($('#new-titulo').val()));
								  var submenu=$('#new-submenu').val();
									cadena = [ 	'a=guardarnew',
										            'titulo='+titulo,
										            'contenido='+data_cont,
										            'size='+$('#new-tam').val(),
										            'area='+$('#new-area').val(),
										            'submenu='+submenu
										        ].join('&');
									 $("#validacion_conte").html("No se ha actualizado"); 
									  $.ajax({
									        url: "../SMenu",
									        data: cadena,
									  	    type: 'post',
									        dataType: 'json',
									        success: function(data){
									        	mensaje(data.mensaje);
									        	if(data.resultado=="OK"){
									        		limpiar();
									        	}
									        }
										
									    }); 
						  }else{
							  $("#validacion_conte").html("Debe seleccionar un SubMenu ó Menu");
						  }		  
							  
					  }else{
						  $("#validacion_conte").html("El titulo no puede estar vacio");
					  }
			  }
			function limpiar(){
				$("#cont-text").cleditor()[0].clear();
        		$('#new-titulo').val('');
        		 $("#validacion_conte").html("");
			}
			</script>
	<% 	} } %>			