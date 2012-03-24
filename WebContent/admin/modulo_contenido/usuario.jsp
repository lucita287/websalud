<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		
		data.Close();
%>
			<div class="centerd">
			<H2>Usuarios</H2>
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
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200,
					    searchitems : [
										{display: 'Nombre', name : 'nombre'},
										{display: 'Apellido', name : 'apellido'},
										{display: 'Usuario', name : 'nickname', isdefault: true}
										]
					});
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
				        	$("#user_area").val(result.idarea);
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
					            'name='+escape($("#user_name").val()),
					            'apellido='+escape($("#user_last_name").val()),
					            'nick='     + escape($("#nick").val()),
					            'phone='     + escape($("#user_phone").val()),
					            'email='     + escape($("#user_email").val()),
					            'idarea='     + escape($("#user_area").val()),
					            'password='+escape($("#user_pass").val()),
					            'password2='+escape($("#user_pass2").val()),
					            'estado='+$('#user_estado').val()
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
		        	$("#user_area").val(1);
		        	$("#user_pass").val("");
		        	$("#user_pass2").val("");
		        	$("#idusuario").text("NEW");
		        	$('#flex1').flexReload();
		        	$('#user_estado').val(1);
		        	editiduser=0;
			  }
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
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<table id="flex1" style="display:none"></table>			
					<table width="80%" CELLSPACING="8">
									<tr >
										<td>ID</td><td><label id="idusuario"></label></td>
									</tr>
									<tr >
										<td>*Nombre</td><td><input id="user_name" type="text" size="40"/></td>
									</tr>
									<tr>
										<td>*Apellido</td><td><input id="user_last_name" type="text" size="40" /></td>
									</tr>
									<tr>
										<td>*Usuario </td><td><input id="nick" type="text" size="20" /></td>
									</tr>
									<tr>
										<td>No Personal </td><td><input id="no_personal" type="text" size="20" /></td>
									</tr>	
									<tr>
										<td>Password</td><td><input id="user_pass" type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Confirmar Password</td><td><input id="user_pass2" type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Telefono</td><td><input id="user_phone" type="text"/></td>
									</tr>
									<tr>
										<td>Email</td><td><input id="user_email" type="text"/></td>
									</tr>
									<tr>
										<td>*Area</td><td><select id="user_area" >
															<% for(int j=0; j<list.size();j++){ 
																CArea area=list.get(j);
															%>
																<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
															<% } %>
														</select>
													</td>
									
									</tr>
									<tr>
										<td>*Estado</td><td><select id="user_estado" >
																<option value="1" selected>ACTIVO</option>
																<option value="2" >DESACTIVADO</option>
														</select>
													</td>
									
									</tr>
					</table>		
								<BR/>
								<BR/>	
									<div class="centerd">
										<a  class="ui-state-default ui-corner-all button-save" onclick="limpiar()"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a  class="ui-state-default ui-corner-all button-save" onclick="guardaUser()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										
									</div>
								<BR/>
								<BR/>

	<div style="clear: both;"></div>	
	