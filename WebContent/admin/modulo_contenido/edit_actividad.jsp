<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuario" %>
<%@ page import="data.CResponsable" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CUsuario> list_usuario=data.getListaUsuarios();
		ArrayList<CResponsable> list_respon=data.getListaResponsables();
		data.Close();
%>
		
		
		<script  type="text/javascript">
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
			  });
			  function RecargarResponsable(){
				  cadena = [ 'a=show_list',].join('&');
					 
					 $.ajax({
					        url: "../SResponsable",
					        data: cadena,
					  	    type: 'post',
					  	  	//dataType: 'json',
					        success: function(data){
					        	result=eval("("+data+")");
					        	var array=result.rows;
					        	$('#respon_actividad').empty();
					        	for (var x = 0 ; x < array.length ; x++) {
						        	$('#respon_actividad').append('<option value="'+array[x].value+'" >'+array[x].text+'</option>');
					        	}
					        }
					    });
			  }
			</script>
			
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
									<td>Area</td>
									<td>
												<select id="area_actividad" >
													<% for(int j=0; j<list.size();j++){ 
														CArea area=list.get(j);%>
														<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
													<% } %>
												</select>
									</td>
								</tr>
								<tr>
									<td>Responsable</td><td>
												<select id="respon_actividad" size="7"  multiple="multiple">
													<% for(int j=0; j<list_respon.size();j++){ 
														CResponsable respon=list_respon.get(j);%>
														<option value="<%=respon.getIdresponsable()%>" ><%=respon.getAreaidarea().getnombre()+"/"+respon.getNombre()+" "+respon.getApellido()%></option>
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
			
	