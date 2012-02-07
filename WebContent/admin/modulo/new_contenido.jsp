<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		data.Close();
%>

			<script  type="text/javascript">
			  $(document).ready(function () {
			              
			      $('.editor').elrte({
						cssClass : 'el-rte',
						lang     : 'es',
						width	 : 600,
					    height	 : 200,
					    toolbar  : 'complete',
						cssfiles : ['../css/elrte-inner.css']
					});
			  });
			  
			</script>
				Titulo: <input type="text" size="60" /><br/>
				Area Pertenece:
					<select id="new-area" onchange="cambiarArea()">
						<% for(int j=0; j<list.size();j++){ 
							CArea area=list.get(j);
						%>
							<option value="<%= area.getidarea()%> "><%= area.getdescripcion()%></option>
						<% } %>
					</select><br/>
				Sub Parte: <select id="new-submenu"></select><br/>
				<div id="cont-text" class="editor"></div>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>	
				<div style="clear: both;"></div>