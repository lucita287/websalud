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
						<div class="wrapper">
							<div id="contactanos">
								<h2>CONTACTANOS</h2>
									<table>
										<tr>
											<td><span>Direccion:</span></td> <td><%=temp.getdireccion()%></td>
										</tr>
										<tr>
											<td><span>Telefono:</span></td><td><%=temp.gettelefono()%></td>
										</tr>
										<tr>
											<td><span>Fax:</span></td><td><%=temp.getfax()%></td>
										</tr>	
									 	<tr>
											<td><span>Email:</span></td><td><%=temp.getcorreo_electronico()%></td>
										</tr>
									</table>	
							</div>
							<div id="ppivs">
								<img src="images/final_user/PPIVS.png" width="450px" heigth="158px"/>
							</div>	
						</div>
					</div>
				</div>