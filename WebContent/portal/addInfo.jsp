<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CConfiguracion" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
CConfiguracion temp=dbo.getConfiguracion();
dbo.Close();
%>
<div class="row-top">
					<div class="row-padding">
									<table>
										<tr>
											<td><b>DIRECCI&Oacute;n:</b></td > <td colspan=4><%=temp.getdireccion()%></td>
										</tr>
										<tr >
											<td><b>TELEFONO:</b></td><td><%=temp.gettelefono()%></td>
											<td><b>CORREO ELECTRONICO:</b></td><td><%=temp.getcorreo_electronico()%></td>
										</tr>
										<tr>
											<td><b>FAX:</b></td><td><%=temp.getfax()%></td>
											
										</tr>
									</table>	
							</div>
							
</div>