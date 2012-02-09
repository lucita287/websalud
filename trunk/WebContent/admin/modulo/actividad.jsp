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
			<H2>Actividades</H2>
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
						{ display: 'Titulo', name: 'titulo', width: 100, sortable: true, align: 'left' },
						{ display: 'Area', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'Fecha', name: 'fecha', width: 100, sortable: true, align: 'left' }
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
				<li><a href="#tabs-1">Nueva Actividad</a></li>
				<li><a href="#tabs-2">Editar Actividad</a></li>
			</ul>
			<div id="tabs-1" style="width:1000px; ">
			<table width="80%" CELLSPACING="8">
								<tr>
									<td>Titulo</td><td><input type="text" size="50" /></td>
								</tr>
								<tr>
									<td>Lugar</td><td><textarea rows="4" cols="50"></textarea></td>
								</tr>	
								<tr>
									<td>Area</td><td>
												<select id="new-area" onchange="cambiarArea()">
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);
													%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getdescripcion()%></option>
													<% } %>
												</select>
												</td>
								</tr>
								<tr>
									<td>Fecha de Inicio</td><td><input type="text" class="datepicker"></td>
								</tr>
								<tr>
									<td>Fecha de Fin</td><td><input type="text" class="datepicker"></td>
								</tr>
								<tr>
									<td>Hora</td><td><input type="text" ></td>
								</tr>
								<tr>
									<td>Responsable</td><td><textarea rows="4" cols="50"></textarea></td>
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
								<tr>
									<td>Titulo</td><td><input type="text" size="50" /></td>
								</tr>
								<tr>
									<td>Lugar</td><td><textarea rows="4" cols="50"></textarea></td>
								</tr>	
								<tr>
									<td>Area</td><td>
												<select id="new-area" onchange="cambiarArea()">
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);
													%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getdescripcion()%></option>
													<% } %>
												</select>
												</td>
								</tr>
								<tr>
									<td>Fecha de Inicio</td><td><input type="text" class="datepicker"></td>
								</tr>
								<tr>
									<td>Fecha de Fin</td><td><input type="text" class="datepicker"></td>
								</tr>
								<tr>
									<td>Hora</td><td><input type="text" ></td>
								</tr>
								<tr>
									<td>Responsable</td><td><textarea rows="4" cols="50"></textarea></td>
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
	