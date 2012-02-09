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
			<H2>PERMISOS</H2>
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
											<select  size="10" multiple="multiple">
											  <option value="volvo">Volvo</option>
											  <option value="saab">Saab</option>
											  <option value="mercedes">Mercedes</option>
											  <option value="audi">Audi</option>
											</select>
											<img src="../images/next.png">
											<img src="../images/back.png">
											<select  size="10" multiple="multiple">
											  
											</select>
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
	