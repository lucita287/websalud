<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CConfiguracion" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
CConfiguracion configurar=dbo.getConfiguracion();
%>    

		<div class="centerd">
				<h2>CONFIGURACI&Oacute;N</h2>
		</div>
<br/>
<table  CELLSPACING="8">
	<tr >
		<td>Telefono</td><td><input type="text" size="15" value="<%=configurar.gettelefono() %>"/></td>
	</tr>
	<tr>
		<td>Fax</td><td><input type="text" size="15" value="<%=configurar.getfax() %>" /></td>
	</tr>	
	<tr>
		<td>Direcci&oacute;n</td><td><input type="text" size="60" value="<%=configurar.getdireccion() %>" /></td>
	</tr>
	<tr>
		<td>Direcci&oacute;n de Imagen</td><td><%=configurar.getdireccion_imagen()%></td>
	</tr>
	<tr>
		<td>Direcci&oacute;n de PDF</td><td><%=configurar.getdireccion_pdf()%></td>
	</tr>
	<tr>
		<td>Tama&ntilde;o para subir archivos</td><td><input size="10" type="text" value="<%= configurar.gettamanio_sub() %>"/></td>
	</tr>
	
</table>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
				<br/><br/>