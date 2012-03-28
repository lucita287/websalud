		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CDepartamento" %>
<%@ page import="java.util.ArrayList" %>
<% 
CDataExam dbo=new CDataExam();
dbo.Connect();
ArrayList<CDepartamento> list_dep=dbo.getListaDepartamentos();
dbo.Close();

%>

		<script>
		var iddepart=0;
		  $(document).ready(function () {
		      $("#centro_uni").flexigrid
				({
					method: 'POST',
					// url: '../SdepartsableTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcentro_uni', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcentro_uni', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 100, sortable: true, align: 'left' },
					{ display: 'Departamento', name: 'departamento', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idcentro_uni",
					sortorder: "desc",
				    title: 'CENTRO UNIVERSITARIO',
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					]
				});
		  });  
		  
		  
		</script>
		<table id="centro_uni" style="display:none"></table>
		<table>
					<tr>
						<td>ID</td>
						<td><label id="id_depart">NEW</label></td>
					</tr>
					<tr>
						<td>Descripci&oacute;n</td>
						<td><input id='nombre_depart' type="text" size="40"/></td>
					</tr>
					<tr>
						<td>Departamento</td>
						<td>
											<select id="dep-centro">
													<option value="0"  SELECTED>INDEFINIDO</option>
													<% for(int j=0; j<list_dep.size();j++){ 
														CDepartamento dep=list_dep.get(j);%>
														<option value="<%=dep.getIddepartamento() %>"  ><%= dep.getNombre() %></option>
													<% } %>
												</select>
						</td>
					</tr>	
				</table>
			<center>
									<br/><br/>
										<a href="#" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<br/><br/>		
			</center>