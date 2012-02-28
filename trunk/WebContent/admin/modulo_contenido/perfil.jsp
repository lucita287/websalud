<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CUsuario" %>
<%

HttpSession ss=request.getSession(false); 
if(ss!=null && session.getAttribute("user")!=null){
CDataBase dbo=new CDataBase();
dbo.Connect();
CUsuario user=dbo.getUsuario(session.getAttribute("user").toString());
dbo.Close();
%>
		<div class="centerd">
				<h2> PERFIL</h2>
		</div>
<br/>
<table width="80%" CELLSPACING="8">
	<tr >
		<td>Nombre</td><td><input type="text" size="40" value="<%=user.getnombre() %>"/></td>
	</tr>
	<tr>
		<td>Apellido</td><td><input type="text" size="40" value="<%=user.getapellido() %>" /></td>
	</tr>
	<tr>
		<td>Nick Name</td><td><input type="text" size="20" value="<%=user.getnick()%>" /></td>
	</tr>	
	<tr>
		<td>Password</td><td><input type="password" size="20" /></td>
	</tr>
	<tr>
		<td>Confirmar Password</td><td><input type="password" size="20" /></td>
	</tr>
	<tr>
		<td>Telefono</td><td><input type="text" value="<%=user.gettelefono() %>"/></td>
	</tr>
	<tr>
		<td>Email</td><td><input type="text" value="<%=user.getemail()%>" /></td>
	</tr>
</table>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
				<br/><br/>
<% } %>				