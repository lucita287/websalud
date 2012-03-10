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
		<script>
		  $(document).ready(function () {
		      $("#responsable").flexigrid
				({
				    dataType: 'json',
				    colModel: [
					{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idnoticia', width: 40, sortable: true, align: 'left' },
					{ display: 'Nombre', name: 'titulo', width: 100, sortable: true, align: 'left' },
					{ display: 'Apellido', name: 'area', width: 100, sortable: true, align: 'left' },
					{ display: 'Area', name: 'area', width: 100, sortable: true, align: 'left' }
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
		</script>
		<table id="responsable" style="display:none"></table>
		<table>
					<tr>
						<td>Nombre</td>
						<td><input type="text" size="40"/></td>
					</tr>
					<tr>
						<td>Apellido</td>
						<td><input type="text" size="40"/></td>
					</tr>
					<tr>	
						<td>Area Profesional</td>
						<td>
							<select id="new-area">
									<% for(int j=0; j<list.size();j++){ 
											CArea area=list.get(j);%>
											<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
									<% } %>
							</select>
						</td>
					</tr>
					<tr>	
						<td>Usuario</td>
						<td>
							<select id="actividad-area" >
										<option value="0"  %>No tiene asignado Usuario</option>
									<% for(int j=0; j<list_usuario.size();j++){ 
											CUsuario user=list_usuario.get(j);%>
											<option value="<%=user.getidusuario()%>"  %><%= user.getnick()+"/"+user.getnombre()+" "+user.getapellido()%></option>
									<% } %>
							</select>
						</td>
					</tr>	
				</table>
				
			<center>
									<br/><br/>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<br/><br/>		
			</center>	