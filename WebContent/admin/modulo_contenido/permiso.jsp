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
			  function next_permiso(){
				  var array=$('#allpermiso').val();
				  for (i=0;i<array.length;i++){ 
					  var id=array[i];
					  var value=$("#allpermiso option[value="+id+"]").text();
					  $('#userpermiso').append('<option value="'+id+'" selected="selected">'+value+'</option>');
					  $("#allpermiso option[value="+id+"]").remove();
				  }
				  
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
			</script>

			<table id="flex1" style="display:none"></table>			
					<table cellpadding="4" cellspacing="4">
									<tr >
										<td>ID</td><td>NUM</td>
									</tr>
									<tr >
										<td>Nombre</td><td>NOMBRE</td>
									</tr>
									<tr>
										<td>Apellido</td><td>APELLIDO</td>
									</tr>
									<tr>
									
										<td colspan="2" >
										<div class="tabla">
										<div class="col">
											TODOS LOS PERMISOS<BR/>
											<select  id="allpermiso" size="10" multiple="multiple">
											  <option value="1">Prueba permiso</option>
											  <option value="2">Prueba permiso2</option>
											  <option value="3">Prueba permiso4</option>
											  <option value="4">Prueba permiso4</option>
											</select>
										</div>
										<div class="col">	
											<img onclick="next_permiso()"   src="../images/next.png" width="32px" height="32px" /><br/>
											<img onclick="back_permiso()" src="../images/back.png" width="32px" height="32px" />
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
											<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
									</div>
								<BR/>
								<BR/>
			
	<div style="clear: both;"></div>	
	