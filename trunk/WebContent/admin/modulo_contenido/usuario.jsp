<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		
		data.Close();
		
		
		HttpSession sessiones = request.getSession(false);
		if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
			CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

				if (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>

			<div class="centerd">
			<H2>USUARIOS</H2>
			</div>
			<script  type="text/javascript">
			var editiduser=0;
			  $(document).ready(function () {
			      $("#flex1").flexigrid
					({
						method: 'POST',
						 url: '../SUsuarioTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chk', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idusuario', width: 40, sortable: true, align: 'left' },
						{ display: 'Nombre', name: 'nombre', width: 100, sortable: true, align: 'left' },
						{ display: 'Apellido', name: 'apellido', width: 100, sortable: true, align: 'left' },
						{ display: 'Usuario', name: 'nick', width: 100, sortable: true, align: 'left' },
						{ display: 'Email', name: 'email', width: 100, sortable: true, align: 'left' },
						{ display: 'Telefono', name: 'telefono', width: 100, sortable: true, align: 'left' }
						],
					    sortname: "idmenu",
					    sortorder: "asc",
					    usepager: true,
					    title: 'Contenido',
					    useRp: true,
					    rp: 30,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200,
					    searchitems : [
										{display: 'Nombre', name : 'nombre'},
										{display: 'Apellido', name : 'apellido'},
										{display: 'Usuario', name : 'nickname', isdefault: true}
										]
					});
			      $('.pSearch').click();
			  });  
			  $(function() {
					$( ".datepicker" ).datepicker();
				});
			  function editarUser(iduser){
				  editiduser=iduser;
				  $("#idusuario").text(iduser);
					cadena = ['iduser='   + iduser,
				             	'a=show',
					        ].join('&');	  
				  $.ajax({
				        url: "../SUsuario",
				        data: cadena,
				  	    type: 'post',
				        //dataType: 'json',
				        success: function(data){
				        	result=eval("("+data+")");
				        	$("#user_name").val(result.nombre);
				        	$("#user_last_name").val(result.apellido);
				        	$("#nick").val(result.nick);
				        	$("#user_phone").val(result.telefono);
				        	$("#user_email").val(result.email);
				        	$("#no_personal").val(result.no_personal);
				        	$('#user_estado').val(result.estado);
				        }
					
				    });
			  }
			  
			  function guardaUser(){
				  var action="guardaredit";
				  if(editiduser<=0){
					  action="newedit";
				  }
		
					cadena = [ 	'idusuario='   + editiduser,
				             	'a='+action,
					            'name='+$("#user_name").val(),
					            'apellido='+$("#user_last_name").val(),
					            'nick='     + $("#nick").val(),
					            'phone='     + $("#user_phone").val(),
					            'email='     + $("#user_email").val(),
					            'no_personal='     + $("#no_personal").val(),
					            'password='+$("#user_pass").val(),
					            'password2='+$("#user_pass2").val(),
					            'estado='+$('#user_estado').val(),
					            'no_personal='+$("#no_personal").val(),
					            
					        ].join('&');
					
					$.ajax({
				        url: "../SUsuario",
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
			  function limpiar(){
				  	$("#user_name").val("");
		        	$("#user_last_name").val("");
		        	$("#nick").val("");
		        	$("#user_phone").val("");
		        	$("#user_email").val("");
		        	$("#no_personal").val("");
		        	$("#user_pass").val("");
		        	$("#user_pass2").val("");
		        	$("#idusuario").text("NEW");
		        	$('#flex1').flexReload();
		        	$('#user_estado').val(1);
		        	editiduser=0;
			  }
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<table id="flex1" style="display:none"></table>			
			
			
			<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="idusuario"></label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Nombre</div>
								<div class="col"><input id="user_name" type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Apellido</div>
								<div class="col"><input id="user_last_name" type="text" size="40" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Usuario</div>
								<div class="col"><input id="nick" type="text" size="20" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">No Personal</div>
								<div class="col"><input id="no_personal" type="text" size="20" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Password</div>
								<div class="col"><input id="user_pass" type="password" autocomplete="off" size="20" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Confirmar Password</div>
								<div class="col"><input id="user_pass2" type="password" autocomplete="off" size="20" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Telefono</div>
								<div class="col"><input id="user_phone" type="text"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Email</div>
								<div class="col"><input id="user_email" type="text"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Estado</div>
								<div class="col"><select id="user_estado" >
																<option value="1" selected>ACTIVO</option>
																<option value="2" >DESACTIVADO</option>
														</select>
												</div>
							</div>
					</div>
				</div>					
									
									<div class="center_button">
										<a  class="ui-state-default ui-corner-all button-save" onclick="limpiar()"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
									<%if (user_permiso.getIdpermiso().indexOf(234)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
										<a  class="ui-state-default ui-corner-all button-save" onclick="guardaUser()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<%} %>		
									</div>
								

	<div style="clear: both;"></div>	
	<%			} } %>