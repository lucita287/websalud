<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuario" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CUsuario> list_usuario=data.getListaUsuarios();
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
						{ display: 'Lugar', name: 'area', width: 100, sortable: true, align: 'left' }
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
			      $("#fecha_actividad").flexigrid
					({
					    dataType: 'json',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idnoticia', width: 40, sortable: true, align: 'left' },
						{ display: 'Fecha', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'Hora Inicio', name: 'fecha', width: 100, sortable: true, align: 'left' },
						{ display: 'Hora Fin', name: 'fecha', width: 100, sortable: true, align: 'left' }
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
					$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
					$(".datepicker").mask("99/99/9999");
					$(".time").mask("99:99");
				});
			</script>
	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Actividad</a></li>
				<li><a href="#tabs-2">Fechas Actividades</a></li>
				<li><a href="#tabs-3">Responsables</a></li>
			</ul>
			<div id="tabs-1" style="width:700px; ">
			
			<table id="flex1" style="display:none"></table>			
										<table width="80%" CELLSPACING="8">
								<tr>
									<td>Titulo</td><td><input type="text" size="50" /></td>
								</tr>
								<tr>
									<td>Descripci&oacute;n</td><td><textarea rows="4" cols="50"></textarea></td>
								</tr>
								<tr>
									<td>Lugar</td><td><input type="text" size="50" /></td>
								</tr>
								<tr>
									<td>Salon</td><td><input type="text" size="30" /></td>
								</tr>	
								<tr>
									<td>Responsable</td><td><textarea rows="4" cols="50"></textarea></td>
								</tr>
								<tr>
									<td>Area</td><td>
												<select id="new-area" onchange="cambiarArea()">
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
													<% } %>
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
			
			</div>
			<div id="tabs-2" style="width:700px; ">
						<div style="border: 3px gray solid; width:600px;">
						<h5>PERIODOS DE FECHAS</h5>
								<table>	
									<tr>
										<td>Fecha Inicio</td>
										<td><input type="text" size="10" class="datepicker"/></td>
										<td>Fecha Fin</td>
										<td><input type="text" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" type="text" class="time"/> 
											<select id="horario">
											<option value="1">AM</option>
											<option value="2">PM</option>
											</select>
										</td>
										<td>Hora Fin</td>
										<td><input size="10" type="text" class="time"/> 
											<select id="horario">
											<option value="1">AM</option>
											<option value="2">PM</option>
											</select>
										</td>
									</tr>
									<tr>
										<td colspan="4">
												<input type="checkbox" name="option1" value="Milk"> LUNES 
												<input type="checkbox" name="option1" value="Milk"> MARTES 
												<input type="checkbox" name="option1" value="Milk"> MIERCOLES
												<input type="checkbox" name="option1" value="Milk"> JUEVES
												<input type="checkbox" name="option1" value="Milk"> VIERNES
												<input type="checkbox" name="option1" value="Milk"> SABADO
										</td>
									</tr>
									
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a href="#validacion_imagen" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
						<div style="border: 3px gray solid; width:600px;">
						<h5>FECHA ESPECIFICA</h5>
								<table>	
									<tr>
										<td>Fecha</td>
										<td><input type="text" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" type="text" class="time"/> 
											<select id="horario">
											<option value="1">AM</option>
											<option value="2">PM</option>
											</select>
										</td>
										<td>Hora Fin</td>
										<td><input size="10" type="text" class="time"/> 
											<select id="horario">
											<option value="1">AM</option>
											<option value="2">PM</option>
											</select>
										</td>
									</tr>
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a href="#validacion_imagen" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
								
					<table id="fecha_actividad" style="display:none"></table>
			</div>
			<div id="tabs-3" style="width:700px; ">
				<jsp:include page="responsable.jsp" />				
			</div>
	</div>	
	<div style="clear: both;"></div>	
	