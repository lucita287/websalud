<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(256)>-1  || user_permiso.getIdusuario().getidusuario()==1){

%>
			
					<%@ page language="java" contentType="text/html; charset=UTF-8"
			    pageEncoding="UTF-8" %>
			
					<script>
					var idtipo=0;
					  $(document).ready(function () {
					      $("#inter_tipo").flexigrid
							({
								method: 'POST',
								url: '../SInterpretacionTable',
								dataType : 'xml',
							    colModel: [
								{display: 'Seleccionar', name : 'chkinter_tipo', width : 30, sortable : false, align: 'left'},           
								{ display: 'ID', name: 'idinter_tipo', width: 40, sortable: true, align: 'left' },
								{ display: 'Orden', name: 'orden', width: 40, sortable: true, align: 'left' },
								{ display: 'Descripcion', name: 'nombre', width: 250, sortable: true, align: 'left' }
								],
								usepager: true,
								sortname: "idinter_tipo",
								sortorder: "desc",
							    title: 'TIPO DE INTERPRETACION',
							    showTableToggleBtn: true,
							    width: 600,
							    height: 200,
							    params : [ {name: 'a', value: 'tipo'} ],
								rp: 30,
							    searchitems : [
								{display: 'Nombre', name : 'nombre'}
								]
							});
					     
					  });
					  $('.pSearch').click();
					  function EditarInter_tipo(id,nombre,orden){
						  $("#id_tipo").text(id);
						  $("#nombre_tipo").val(nombre);
						  idtipo=id;
						  $("#orden_tipo").val(orden);
					  }
					  function limpiartipo(){
						  $("#id_tipo").text("NEW");
						  $("#nombre_tipo").val("");
						  idtipo=0;
						  $("#orden_tipo").val("");
						  $('#inter_tipo').flexReload();
					  }
					  function Guardartipo(){
						  var action="guardartipo";
						  if(idtipo<=0){
							  action="newtipo";
						  }
						  cadena = [ 	'id_tipo='   + idtipo,
						             	'a='+action,
							            'nombre='+$("#nombre_tipo").val(),
							            'orden='+$("#orden_tipo").val()
							        ].join('&');
						  $.ajax({
						        url: "../SInterpretacion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        	if(data.resultado=='OK'){
						        		limpiartipo();
						        	}
						        }
						    });
					  }
					  function Eliminartipo(){
						  var action="deletetipo";
						  
						  cadena = [ 	'id_tipo='   + idtipo,
						             	'a='+action
						            ].join('&');
						  $.ajax({
						        url: "../SInterpretacion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        	if(data.resultado=='OK'){
						        		limpiartipo();
						        	}
						        }
						    });
					  }
					  
					  
					</script>
					<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
					<table id="inter_tipo" style="display:none"></table>
					
					
					<div class="perfil">
							<div class="tabla">
										<div class="fila">
											<div class="col_titulo">ID</div>
											<div class="col"><label id="id_tipo">NEW</label></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Descripci&oacute;n</div>
											<div class="col"><input id='nombre_tipo' type="text" size="40"/></div>
										</div>
										<div class="fila">
											<div class="col_titulo">*Orden</div>
											<div class="col"><input id='orden_tipo' type="text" size="10"/></div>
										</div>
							</div>
					</div>				
								<div class="center_button_2">
													<a href="#" onclick="limpiartipo()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
													<a href="#" onclick="Guardartipo()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
													<a href="#" onclick="Eliminartipo()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
								</div>
<%	}	} %>