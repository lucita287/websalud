<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CPermiso" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CPermiso> list_permisos=data.getListaPermiso();
		data.Close();
%>
	<style type="text/css">
div.tabla
{
	clear: none;
	overflow: auto;
}


div.col
{
	float: left;
	padding: 5px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-width: 0px;
}
	
	</style>

			<div class="centerd">
			<H2>PERMISOS</H2>
			</div>
			<style type="text/css">
				
			</style>
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
						{ display: 'Nick', name: 'nick', width: 100, sortable: true, align: 'left' },
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
										{display: 'Nick', name : 'nickname', isdefault: true}
										]
					});
			  });  
			  $(function() {
					$( ".datepicker" ).datepicker();
				});
			  function next_permiso(){
				  var array=$('#allpermiso').val();
				  for (i=0;i<array.length;i++){ 
					  var id=array[i];
					  var value=$("#allpermiso option[value="+id+"]").text();
					  $('#userpermiso').append('<option value="'+id+'" selected="selected">'+value+'</option>');
					  $("#allpermiso option[value="+id+"]").remove();
				  }
				  
			  }
			  function nextall_permiso(){
				 
				$('select#allpermiso').find('option').each(function() {
		                var value=$("#allpermiso option[value="+$(this).val()+"]").text();
		                $('#userpermiso').append('<option value="'+$(this).val()+'" >'+value+'</option>');
						$("#allpermiso option[value="+$(this).val()+"]").remove();
		        });
				  
			  }
			  function backall_permiso(){
				  $('select#userpermiso').find('option').each(function() {
		                var value=$("#userpermiso option[value="+$(this).val()+"]").text();
		                $('#allpermiso').append('<option value="'+$(this).val()+'" >'+value+'</option>');
						$("#userpermiso option[value="+$(this).val()+"]").remove();
		        	});
			  }
			  function back_permiso(){
				  var array=$('#userpermiso').val();
				  for (i=0;i<array.length;i++){ 
					  var id=array[i];
					  var value=$("#userpermiso option[value="+id+"]").text();
					  $('#allpermiso').append('<option value="'+id+'" selected="selected">'+value+'</option>');
					  $("#userpermiso option[value="+id+"]").remove();
				  }
			  }
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
				        	$("#user_name").text(result.nombre);
				        	$("#user_last_name").text(result.apellido);
				        	$("#nick").text(result.nick);
				        	backall_permiso();
				        	var permisos=result.permisos;
				        	for (var x = 0 ; x < permisos.length ; x++) {
				        		var id=permisos[x].idpermiso;
				        		var value=$("#allpermiso option[value="+id+"]").text();
				        		$('#userpermiso').append('<option value="'+id+'" selected="selected">'+value+'</option>');
								$("#allpermiso option[value="+id+"]").remove();
				        	}
				        }
					
				    });
			  }
			  function limpiar(){
				  	$("#user_name").text('');
		        	$("#user_last_name").text('');
		        	$("#nick").text('');
		        	editiduser=0;
					$("#idusuario").text('');
					$('#flex1').flexReload();
		        	backall_permiso();
			  }
			  function GuardarUser(){
				  $('select#userpermiso').find('option').each(function() {
					  $('#userpermiso option[value=' + $(this).val() + ']').attr('selected', true); 
		        	});
				  cadena = ['iduser='   + editiduser,
			             	'a=privileges',
			             	'permisos='+$('#userpermiso').val()
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
					<table cellpadding="4" cellspacing="4">
									<tr >
										<td>ID</td><td><label id="idusuario"></label></td>
									</tr>
									<tr >
										<td>Nombre</td><td><label id="user_name" ></label></td>
									</tr>
									<tr>
										<td>Apellido</td><td><label id="user_last_name" ></label></td>
									</tr>
									<tr>
										<td>Nick</td><td><label id="nick" ></label></td>
									</tr>
									<tr>
									
										<td colspan="2" >
										<div class="tabla">
										<div class="col">
											TODOS LOS PERMISOS<BR/>
											<select  id="allpermiso" size="10" multiple="multiple">
											<% for(int j=0; j<list_permisos.size();j++){ 
																CPermiso perm=list_permisos.get(j);
															%>
																<option value="<%=perm.getIdpermiso()%>" ><%= perm.getDescripcion()%></option>
											<% } %>  
											</select>
										</div>
										<div class="col">	
											<img onclick="next_permiso()"   src="../images/next.png" width="32px" height="32px" /><br/>
											<img onclick="nextall_permiso()" src="../images/next2_all.png" width="32px" height="32px" /><br/>
											<img onclick="back_permiso()" src="../images/back.png" width="32px" height="32px" /><br/>
											<img onclick="backall_permiso()" src="../images/back2_all.png" width="32px" height="32px" />
										</div>
										<div class="col">
											PERMISOS A ASIGNAR<BR/>
											<select id="userpermiso"  size="10" multiple="multiple"> 
											
											</select>
										</div>	
										</div>	
										</td>
										
									</tr>

					</table>		
								<BR/>
								<BR/>	
									<div class="centerd">
											<a href="#" class="ui-state-default ui-corner-all button-save" onclick="GuardarUser()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
											
									</div>
								<BR/>
								<BR/>
			
	<div style="clear: both;"></div>	
	