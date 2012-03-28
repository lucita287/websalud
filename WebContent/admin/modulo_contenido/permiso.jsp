<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CPermiso" %>
<%@ page import="data.CCategoria_permiso" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		
		ArrayList<CPermiso> list_permisos=data.getListaPermiso();
		ArrayList<CCategoria_permiso> list_cate=data.getListaCategoriaPermisos();
		
%>
	<style type="text/css">

.format { margin-top: 0.2em; }
.titulo_permiso {font-weight:normal;color:blue; text-transform:uppercase; font-size:1em;}
	
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
				        	backall_permiso(false);
				        	backall_area();
				        	var permisos=result.permisos;
				        	for (var x = 0 ; x < permisos.length ; x++) {
				        		var id=permisos[x].idpermiso;
				        		$("#idpermiso_"+id).attr('checked', true);
				        		$("#idpermiso_"+id).button('refresh');
				        	}
				        	var areas=result.areas;
				        	for (var x = 0 ; x < areas.length ; x++) {
				        		var id=areas[x].idarea;
				        		$("#area_"+id).attr('checked', true);
				        		$("#area_"+id).button('refresh');
				        	}
				        }
					
				    });
			  } 
			 function backall_permiso(estado){
				 
				<%
				for(int i=0; i<list_permisos.size();i++){ 
					CPermiso per=list_permisos.get(i);
				%>
				$("#idpermiso_<%=per.getIdpermiso()%>").attr('checked', estado);	
				$("#idpermiso_<%=per.getIdpermiso()%>").button('refresh');
				<%}%>
				
			 }
			 function backall_area(){
				 <%for(int i=0; i<list.size();i++){ 
						CArea area=list.get(i);%>
					$("#area_<%=area.getidarea()%>").attr('checked', false);	
					$("#area_<%=area.getidarea()%>").button('refresh');
					<%}%> 
			 }
			 function limpiar(){
				 
				 $("#user_name").text('');
		        	$("#user_last_name").text('');
		        	$("#nick").text('');
		        	editiduser=0;
					$("#idusuario").text('');
					$('#flex1').flexReload();
					backall_area();
					backall_permiso(false);
					
			 }
			 function GuardarUser(){
				  $('select#userpermiso').find('option').each(function() {
					  $('#userpermiso option[value=' + $(this).val() + ']').attr('selected', true); 
		        	});
				  cadena = ['iduser='   + editiduser,
			             	'a=privileges',
			             	<%for(int i=0; i<list_permisos.size();i++){ 
								CPermiso per=list_permisos.get(i);%>							
							'id_permiso_<%=per.getIdpermiso()%>='+(($('#idpermiso_<%=per.getIdpermiso()%>').is(':checked')==true)?1:0),
							<%}%>
							<% for(int j=0; j<list.size();j++){ 
								CArea area=list.get(j);%>
							'id_area<%=area.getidarea()%>='+(($('#area_<%=area.getidarea()%>').is(':checked')==true)?1:0),
							<% } %>
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

				$(function() {
					$( ".check" ).button();
					$( ".check2" ).button();
					$( ".format" ).buttonset();
				});
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<table id="flex1" style="display:none"></table>			
					<table cellpadding="4" cellspacing="4">
									<tr >
										<td><div class="titulo_permiso"> ID</div></td><td><label id="idusuario"></label></td>
									</tr>
									<tr >
										<td><div class="titulo_permiso">Nombre</div></td><td><label id="user_name" ></label></td>
									</tr>
									<tr>
										<td><div class="titulo_permiso">Apellido</div></td><td><label id="user_last_name" ></label></td>
									</tr>
									<tr>
										<td><div class="titulo_permiso">Nick</div></td><td><label id="nick" ></label></td>
									</tr>
									<tr>
										<td><div class="titulo_permiso">Areas</div> </td>
										<td>
											<div class="format">
											<% for(int j=0; j<list.size();j++){ 
																CArea area=list.get(j);
															%>
																<input type="checkbox" class=".check" id="area_<%=area.getidarea()%>" /><label for="area_<%=area.getidarea()%>"><%=area.getnombre() %></label>
																
											<% } %>
											</div> 
										</td>
									</tr>
					</table>				
									
	<div id="tabs">
			<ul>
				<% for(int j=0; j<list_cate.size();j++){ 
					CCategoria_permiso cate=list_cate.get(j);
					
					%>
				<li><a href="#tabs-<%= cate.getIdcategoria_permiso() %>"><%= cate.getNombre() %></a></li>
				<% } %>
			</ul>
			
			<% for(int j=0; j<list_cate.size();j++){ 
					CCategoria_permiso cate=list_cate.get(j);
					ArrayList<CPermiso> list_perm=data.getListaPermisoCate(cate.getIdcategoria_permiso());				
					%>
					<div id="tabs-<%= cate.getIdcategoria_permiso() %>" style="width:600px; ">
						<center>
						<%  int x=0;
						for(int i=0; i<list_perm.size();i++){ 
							CPermiso per=list_perm.get(i);
								if(i%2==0){
									out.print("<div class=\"format\">");
									x++; 
								} %>
							<input type="checkbox"  id="idpermiso_<%=per.getIdpermiso() %>" /><label for="idpermiso_<%=per.getIdpermiso() %>"><%=per.getDescripcion() %></label>	
						<% 
								if(i%2!=0){
									out.println("</div>"); x--;
								}
						} 
							if(x>0)out.println("</div>");
						%>
						</center>
					</div>
			<% } %>
	</div>					
											
										

							
								<BR/>
								<BR/>	
									<center>
											<a class="ui-state-default ui-corner-all button-save" onclick="GuardarUser()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
											
									</center>
								<BR/>
								<BR/>
			
	<div style="clear: both;"></div>	
	<%data.Close(); %>