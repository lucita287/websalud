		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CUsuarioPermiso" %>
<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(240)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>
				
						<script>
						var idtsangre=0;
						  $(document).ready(function () {
						      $("#tipo_sangre").flexigrid
								({
									method: 'POST',
									url: '../SPropiedadTable',
									dataType : 'xml',
								    colModel: [
									{display: 'Seleccionar', name : 'chktipo_sangre', width : 30, sortable : false, align: 'left'},           
									{ display: 'ID', name: 'idtipo_sangre', width: 40, sortable: true, align: 'left' },
									{ display: 'Descripcion', name: 'nombre', width: 250, sortable: true, align: 'left' }
									],
									sortname: "idtipo_sangre",
									sortorder: "desc",
								    title: 'TIPO DE SANGRE',
								    showTableToggleBtn: true,
								    width: 600,
								    height: 200,
								    params : [ {name: 'a', value: 'tsangre'} ]
								});
						  });  
						  function Editartsangre(id,nombre){
							  $("#id_tsangre").text(id);
							  $("#nombre_tsangre").val(nombre);
							  idtsangre=id;
						  }
						  function limpiartsangre(){
							  $("#id_tsangre").text("NEW");
							  $("#nombre_tsangre").val("");
							  idtsangre=0;
							  $('#tipo_sangre').flexReload();
						  }
						  function Guardartsangre(){
							  var action="guardartsangre";
							  if(idtsangre<=0){
								  action="newtsangre";
							  }
							  cadena = [ 	'id_tsangre='   + idtsangre,
							             	'a='+action,
								            'nombre='+$("#nombre_tsangre").val(),
								        ].join('&');
							  $.ajax({
							        url: "../SPropiedad",
							        data: cadena,
							  	    type: 'post',
							        dataType: 'json',
							        success: function(data){
							        	mensaje(data.mensaje);
							        	if(data.resultado=='OK'){
							        		limpiartsangre();
							        	}
							        }
							    });
						  }
						  function Eliminartsangre(){
							  var action="deletetsangre";
							  
							  cadena = [ 	'id_tsangre='   + idtsangre,
							             	'a='+action
							            ].join('&');
							  $.ajax({
							        url: "../SPropiedad",
							        data: cadena,
							  	    type: 'post',
							        dataType: 'json',
							        success: function(data){
							        	mensaje(data.mensaje);
							        	if(data.resultado=='OK'){
							        		limpiartsangre();
							        	}
							        }
							    });
						  }
						  
						  
						</script>
						<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
						<table id="tipo_sangre" style="display:none"></table>
						
						
						<div class="perfil">
								<div class="tabla">
											<div class="fila">
												<div class="col_titulo">ID</div>
												<div class="col"><label id="id_tsangre">NEW</label></div>
											</div>
											<div class="fila">
												<div class="col_titulo">*Descripci&oacute;n</div>
												<div class="col"><input id='nombre_tsangre' type="text" size="40"/></div>
											</div>
								</div>
						</div>				
									<div class="center_button_2">
														<a href="#" onclick="limpiartsangre()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
														<a href="#" onclick="Guardartsangre()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
														<a href="#" onclick="Eliminartsangre()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									</div>
<%	}	} %>