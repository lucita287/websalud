<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CSubcategoria" %>
<%@ page import="data.CCategoria" %>
<%
		CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CCategoria> list=data.getListaCategoria();
		ArrayList<CSubcategoria> list_sub=data.getListaSubCategoria();
		data.Close();
%>

<style>
.div_cate {
background-color:#EBDDE2;
width:250px;
border:1px solid #FFF8DC;
margin-left:20px;
}
.div_preguntas {

width:600px;
border:1px solid #FFF8DC;

}
</style>
<script  type="text/javascript">
			  $(document).ready(function () {
			      $("#flex1").flexigrid
					({
					    dataType: 'json',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idpregunta', width: 40, sortable: true, align: 'left' },
						{ display: 'Descripcion', name: 'descripcion', width: 250, sortable: true, align: 'left' },
						{ display: 'Categoria', name: 'categoria', width: 100, sortable: true, align: 'left' },
						{ display: 'Subcategoria', name: 'subcategoria', width: 100, sortable: true, align: 'left' }
						],
					    
					    title: 'Preguntas',
					    useRp: true,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200
					});
			      $("#flex2").flexigrid
					({
					    dataType: 'json',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idrango_exa_auto', width: 40, sortable: true, align: 'left' },
						{ display: 'MIN', name: 'minimo', width: 80, sortable: true, align: 'left' },
						{ display: 'MAX', name: 'maximo', width: 80, sortable: true, align: 'left' },
						{ display: 'Categoria', name: 'categoria', width: 100, sortable: true, align: 'left' }
						],
					    
					    title: 'Preguntas',
					    useRp: true,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200
					});
			  });  
			  function selec_categoria(id){
				  cadena = [ 	'a=show',
				             	'categoria='+id,
					            
					        ].join('&');
				  $.ajax({
				        url: "../SCategoria",
				        data: cadena,
				  	    type: 'post',
				        success: function(data){
				        	
				        	var arr = Array();
				              arr = eval("(" + data + ")");                    
				              $('#flex1').flexAddData(arr);
				               
				        }
					
				    });

			  }
			  function rango_categoria(id){
				  
			  }
			</script>
<H2>Examen de AutoEvaluaci&oacute;n</H2>

		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Nueva Pregunta</a></li>
				<li><a href="#tabs-2">Editar Pregunta</a></li>
				<li><a href="#tabs-4">Nuevo Rango de evaluaci&oacute;n</a></li>
				<li><a href="#tabs-3">Editar Rango de evaluaci&oacute;n</a></li>
			</ul>
			<div id="tabs-2" style="width:1000px; ">

			<h3>Categor&iacute;a</h3>
			<div id="categoria" class="div_cate">
			<%	for(int j=0; j<list.size();j++){ 
				CCategoria cat=list.get(j);	
				%>
				<input type="radio" name="categoria" onclick="selec_categoria(<%=cat.getidcategoria()%>)" value="<%=cat.getidcategoria()%>" default><%=cat.getdescripcion()%><br>
			<%  }%>
					
			</div>
			<table id="flex1" style="display:none"></table>
			<br/>
			
			
			<div class="div_preguntas">
				<table>
					<tr>
						<td>DESCRIPCION</td><td><textarea rows="4" cols="50"></textarea></td>
					</tr>
					<tr>
						<td>CATEGORIA</td>
						<td>
								<select  >
									<% for(int j=0; j<list.size();j++){ 
										CCategoria area=list.get(j);
									%>
										<option value="<%=area.getidcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
					</tr>
					<tr>
						<td>SUBCATEGORIA</td>
						<td>
								<select id="new-categoria" >
								<option value="0" >NINGUNA</option>
									<% for(int j=0; j<list_sub.size();j++){ 
										CSubcategoria area=list_sub.get(j);
									%>
										<option value="<%=area.getidsubcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
					</tr>
					<tr>
						<td>SIEMPRE</td><td><input type="text" size="5"/></td>
					</tr>
					<tr>
						<td>ALGUNAS VECES</td><td><input type="text" size="5"/></td>
					</tr>
					<tr>
						<td>NUNCA</td><td><input type="text" size="5"/></td>
					</tr>
				</table> 
					<br/>
					<br/>
							<div class="centerd">
									<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
							</div>
					<br/>
					<br/>
				
			</div>
		</div>
		<div id="tabs-1" style="width:1000px; ">
		
				<table>
					<tr>
						<td>ID</td><td>ID</td>
					</tr>
					<tr>
						<td>DESCRIPCION</td><td><textarea rows="4" cols="50"></textarea></td>
					</tr>
					<tr>
						<td>CATEGORIA</td>
						<td>
								<select id="new-categoria" >
									<% for(int j=0; j<list.size();j++){ 
										CCategoria area=list.get(j);
									%>
										<option value="<%=area.getidcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
					</tr>
					<tr>
						<td>SUBCATEGORIA</td>
						<td>
								<select id="new-categoria" >
									<% for(int j=0; j<list_sub.size();j++){ 
										CSubcategoria area=list_sub.get(j);
									%>
										<option value="<%=area.getidsubcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
					</tr>
					<tr>
						<td>SIEMPRE</td><td><input type="text" size="5"/></td>
					</tr>
					<tr>
						<td>ALGUNAS VECES</td><td><input type="text" size="5"/></td>
					</tr>
					<tr>
						<td>NUNCA</td><td><input type="text" size="5"/></td>
					</tr>
				</table> 
					<br/>
					<br/>
							<div class="centerd">
									<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								
							</div>
					<br/>
					<br/>
		
		
		</div>
		<div id="tabs-3" style="width:1000px; ">
			<h3>Categor&iacute;a</h3>
			<div class="div_cate">
			<%	for(int j=0; j<list.size();j++){ 
				CCategoria cat=list.get(j);	
				%>
				<input type="radio" name="categoria-rango" onclick="rango_categoria(<%=cat.getidcategoria()%>)" value="<%=cat.getidcategoria()%>" default><%=cat.getdescripcion()%><br>
			<%  }%>
					
			</div>
			<table id="flex2" style="display:none"></table>
			<table>
				<tr>
					<td>ID</td><td>ID</td>
					
				</tr>
				<tr>
					<td>Minimo</td><td><input type="text"  size="5"/></td>
				</tr>
				<tr>
					<td>Maximo</td><td><input type="text"  size="5"/></td>
				</tr>
				<tr>
					<td>Interpretaci&oacute;n</td><td><textarea rows="4" cols="50"></textarea></td>
				</tr>
				<tr>
						<td>CATEGORIA</td>
						<td>
								<select  >
									<% for(int j=0; j<list.size();j++){ 
										CCategoria area=list.get(j);
									%>
										<option value="<%=area.getidcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
				</tr>
			</table>
					<br/>
					<br/>
							<div class="centerd">
									<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
							</div>
					<br/>
					<br/>
		</div>
		<div id="tabs-4" style="width:1000px; ">
			
			<table>
				<tr>
					<td>Minimo</td><td><input type="text"  size="5"/></td>
				</tr>
				<tr>
					<td>Maximo</td><td><input type="text"  size="5"/></td>
				</tr>
				<tr>
					<td>Interpretaci&oacute;n</td><td><textarea rows="4" cols="50"></textarea></td>
				</tr>
				<tr>
						<td>CATEGORIA</td>
						<td>
								<select  >
									<% for(int j=0; j<list.size();j++){ 
										CCategoria area=list.get(j);
									%>
										<option value="<%=area.getidcategoria()%>" ><%= area.getdescripcion()%></option>
									<% } %>
								</select>
						</td>
				</tr>
			</table>
					<br/>
					<br/>
							<div class="centerd">
									<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
							</div>
					<br/>
					<br/>
			
		</div>
	</div>
