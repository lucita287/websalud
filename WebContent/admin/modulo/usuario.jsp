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
			$(function() {
				$( "#tabs" ).tabs();
			});
			  $(document).ready(function () {
			      $("#flex1").flexigrid
					({
					    dataType: 'json',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idnoticia', width: 40, sortable: true, align: 'left' },
						{ display: 'Nombre', name: 'titulo', width: 100, sortable: true, align: 'left' },
						{ display: 'Apellido', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'Nick', name: 'fecha', width: 100, sortable: true, align: 'left' }
						],
					    sortname: "idmenu",
					    sortorder: "asc",
					    usepager: true,
					    title: 'Contenido',
					    useRp: true,
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200
					});
			  });  
			  $(function() {
					$( ".datepicker" ).datepicker();
				});
			</script>
	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Nuevo Usuario</a></li>
				<li><a href="#tabs-2">Editar Usuario</a></li>
			</ul>
			<div id="tabs-1" style="width:1000px; ">
								<table width="80%" CELLSPACING="8">
									<tr >
										<td>Nombre</td><td><input type="text" size="40"/></td>
									</tr>
									<tr>
										<td>Apellido</td><td><input type="text" size="40" /></td>
									</tr>
									<tr>
										<td>Nick Name</td><td><input type="text" size="20" /></td>
									</tr>	
									<tr>
										<td>Password</td><td><input type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Confirmar Password</td><td><input type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Telefono</td><td><input type="text"/></td>
									</tr>
									<tr>
										<td>Email</td><td><input type="text"/></td>
									</tr>
								</table>
		
								<BR/>
								<BR/>	
									<div class="centerd">
											<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									</div>
								<BR/>
								<BR/>
			
			</div>
			<div id="tabs-2" style="width:1000px; ">
			<table id="flex1" style="display:none"></table>			
					<table width="80%" CELLSPACING="8">
									<tr >
										<td>ID</td><td>NUM</td>
									</tr>
									<tr >
										<td>Nombre</td><td><input type="text" size="40"/></td>
									</tr>
									<tr>
										<td>Apellido</td><td><input type="text" size="40" /></td>
									</tr>
									<tr>
										<td>Nick Name</td><td><input type="text" size="20" /></td>
									</tr>	
									<tr>
										<td>Password</td><td><input type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Confirmar Password</td><td><input type="password" size="20" /></td>
									</tr>
									<tr>
										<td>Telefono</td><td><input type="text"/></td>
									</tr>
									<tr>
										<td>Email</td><td><input type="text"/></td>
									</tr>
					</table>		
								<BR/>
								<BR/>	
									<div class="centerd">
											<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
									</div>
								<BR/>
								<BR/>
			</div>
	</div>	
	<div style="clear: both;"></div>	
	