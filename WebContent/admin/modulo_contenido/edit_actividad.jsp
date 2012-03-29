
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuario" %>
<%@ page import="data.CResponsable" %>
<%@ page import="data.CEdificio" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

	if (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1){

	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CUsuario> list_usuario=data.getListaUsuarios();
		ArrayList<CResponsable> list_respon=data.getListaResponsables();
		ArrayList<CEdificio> list_edificio=data.getListaEdificio();
		data.Close();
%>
		
		
		<script  type="text/javascript">
			
		var idactividad=0;
			  $(document).ready(function () {
				  $("#descripcion_actividad").cleditor({
					    width:        450,
					    height:       200,
					    controls:     // controls to add to the toolbar
	                        "bold italic underline strikethrough subscript superscript | font size " +
	                        "style | color highlight removeformat | bullets numbering | outdent " +
	                        "indent | alignleft center alignright justify | undo redo | " +
	                        "rule image link unlink | cut copy paste pastetext | print"
				      });
				  $("#descripcion_actividad").cleditor()[0].focus();
			      $("#actividad").flexigrid
					({
						method: 'POST',
						 url: '../SActividadTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idactividad', width: 40, sortable: true, align: 'left' },
						{ display: 'Titulo', name: 'titulo', width: 100, sortable: true, align: 'left' },
						{ display: 'Area', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'Lugar', name: 'lugar', width: 100, sortable: true, align: 'left' }
						],
						usepager: true,
					    sortname: "idactividad",
						sortorder: "desc",
					    title: 'ACTIVIDADES',
					    useRp: true,
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200,
					    searchitems : [
						{display: 'titulo', name : 'titulo'},
						{display: 'lugar', name : 'lugar'},
						{display: 'area', name : 'area', isdefault: true}
						]
					});
			  });
			  $( function(){
					
				  var cledit = $("#descripcion_actividad").cleditor()[0];
				  $(cledit.$frame[0]).attr("id","cleditCool");

				  var cleditFrame;
				  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
				  else cleditFrame = document.frames["cleditCool"].document;
				    
			  $(cleditFrame).contents().find('body').bind('paste', function(){
				  
			        setTimeout(function() {
			            mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
			        	$("#descripcion_actividad").cleditor()[0].clear();
			        	$("#descripcion_actividad").cleditor()[0].focus();
			        }, 100);
			       
			  });
			  } );
			  function RecargarResponsable(){
				  cadena = [ 'a=show_list',].join('&');
					 
					 $.ajax({
					        url: "../SResponsable",
					        data: cadena,
					  	    type: 'post',
					  	  	success: function(data){
					        	result=eval("("+data+")");
					        	var array=result.rows;
					        	$('#respon_actividad').empty();
					        	for (var x = 0 ; x < array.length ; x++) {
						        	$('#respon_actividad').append('<option value="'+array[x].value+'" >'+array[x].text+'</option>');
					        	}
					        }
					    });
			  }
			  function RecargarEdificio(){
				  cadena = [ 'a=show_list',].join('&');
					 
					 $.ajax({
					        url: "../SEdificio",
					        data: cadena,
					  	    type: 'post',
					  	  	success: function(data){
					        	result=eval("("+data+")");
					        	var array=result.rows;
					        	$('#lugar_actividad').empty();
					        	for (var x = 0 ; x < array.length ; x++) {
						        	$('#lugar_actividad').append('<option value="'+array[x].value+'" >'+array[x].text+'</option>');
					        	}
					        }
					    });
			  }
			  function editaractividad(id){
				  $("#fe_ini_buscar").val("");
				  $("#fe_fin_buscar").val("");	
				  $('#fecha_actividad').flexOptions({ params : [{name: 'idactividad', value: id},{name: 'f_ini', value: ''},{name: 'f_fin', value: ''} ]});
				  $('#fecha_actividad').flexReload();
				  $("#descripcion_actividad").cleditor()[0].clear();
				  $("#respon_actividad").attr('selectedIndex', '-1').children("option:selected").removeAttr("selected");
				  $('#id_actividad').text(id);
				  idactividad=id;					 
					 cadena = [ 'a=show_actividad',
					            'idactividad='     + id,
					        ].join('&');
					 $.ajax({
					        url: "../SActividad",
					        data: cadena,
					  	    type: 'post',
					        success: function(data){
					        	var data_desc=Base64.decode( data );
					        	result=eval("("+ data_desc+")");
					        	$("#titulo_actividad").val(result.titulo);
					        	$("#descripcion_actividad").cleditor()[0].execCommand("inserthtml",result.descripcion,null,null);
								$("#descripcion_actividad").cleditor()[0].focus();
								$("#lugar_actividad").val(result.idedificio);
								$("#salon_actividad").val(result.salon);
								$("#area_actividad").val(result.idarea);
								$("#id_actividad_f").text(idactividad);
								$("#titulo_actividad_f").text(result.titulo);
								var responsable=result.responsables;
								
					        	for (var x = 0 ; x < responsable.length ; x++) {
					        		var id=responsable[x].idresponsable; 
					        		$('#respon_actividad').find('option').each( function() {
					        		      var $this = $(this);
					        		      if ($this.val() == id) {
					        		         $this.attr('selected','selected');
					        		         return false;
					        		      }
					        		 });
					        	}
					        }
					    });
			  }
			  function GuardarActividad(){
				  
				  var titulo=convertirCaracter($.trim($("#titulo_actividad").val()));
					var descripcion=convertirCaracter($.trim($("#descripcion_actividad").val()));
				    var action="new_noticia";
				if(idactividad==0){
					action="new_actividad";
				}else{
					action="safe_actividad";						
				}
				cadena = [ 'a='+action,
				            'idactividad='     + idactividad,
				            'idedificio='   + $("#lugar_actividad").val(),
				            'titulo='+Base64.encode(titulo),
				            'descripcion='+Base64.encode(descripcion),
				            'idarea='+$("#area_actividad").val(),
				            'responsable='+$("#respon_actividad").val(),
				            'salon='+$("#salon_actividad").val(),
				        ].join('&');
				$.ajax({
			        url: "../SActividad",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		LimpiarActividad();
			        	}
			        }
			    });
				
			  }
			  function LimpiarActividad(){
				  $("#fe_ini_buscar").val("");
				  $("#fe_fin_buscar").val("");
				  $("#actividad").flexReload();
				  $("#id_actividad").text("NEW");
				  $("#titulo_actividad").val("");
				  $("#descripcion_actividad").cleditor()[0].clear();
				  $("#descripcion_actividad").cleditor()[0].focus();
				  $("#lugar_actividad").val(1);
				  $("#salon_actividad").val("");
				  $("#area_actividad").val(1);
				  $("#respon_actividad").attr('selectedIndex', '-1').children("option:selected").removeAttr("selected");
				  idactividad=0;
				  $('#fecha_actividad').flexOptions({ params : [{name: 'idactividad', value: idactividad},{name: 'f_ini', value: ''},{name: 'f_fin', value: ''} ]});
				  $('#fecha_actividad').flexReload();
				  $("#id_actividad_f").text("NEW");
				  $("#titulo_actividad_f").text("SELECCIONE UNA ACTIVIDAD");
			  }
			  function EliminarActividad(){
				  cadena = [ 'a=eliminar_actividad',
					            'idactividad='     + idactividad,
					        ].join('&');
					 
					 $.ajax({
					        url: "../SActividad",
					        data: cadena,
					  	    type: 'post',
					  	  	dataType: 'json',
					        success: function(data){
					        	mensaje(data.mensaje);
					        	if(data.resultado=='OK'){
					        		LimpiarActividad();
					        	}
					        }
					    });
			  }
			</script>
			
			<table id="actividad" style="display:none"></table>			
			
			
			
			
			<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_actividad">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Titulo</div>
								<div class="col"><input id="titulo_actividad" type="text" size="50" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><textarea id="descripcion_actividad" rows="4" cols="50"></textarea></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Lugar</div>
								<div class="col">
												<select id="lugar_actividad" >
													<% for(int j=0; j<list_edificio.size();j++){ 
														CEdificio edi=list_edificio.get(j);%>
														<option value="<%=edi.getIdedificio()%>" ><%=edi.getNombre()%></option>
													<% } %>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Salon</div>
								<div class="col"><input id="salon_actividad" type="text" size="30" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Area</div>
								<div class="col">
										<select id="area_actividad" >
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
													<% } %>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Responsable</div>
								<div class="col">
								<select id="respon_actividad" size="7"  multiple="multiple">
													<% for(int j=0; j<list_respon.size();j++){ 
														CResponsable respon=list_respon.get(j);%>
														<option value="<%=respon.getIdresponsable()%>" ><%=respon.getAreaidarea().getnombre()+"/"+respon.getNombre()+" "+respon.getApellido()%></option>
													<% } %>
												</select>
								</div>
							</div>
							
					</div>
			</div>				
					<div class="center_button_2">
										<a  class="ui-state-default ui-corner-all button-save" onclick="LimpiarActividad()"> <img  width="24px"  height="24px" src="../images/add.png" />Nuevo</a>
									<%if (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
										<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarActividad()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<%} if (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
										<a  class="ui-state-default ui-corner-all button-delete" onclick="EliminarActividad()"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
									<% } %>	
					</div>
								
			
<%	}	} %>	