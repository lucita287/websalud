<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
	<form id="MainForm" name="MainForm" action="SLogin" method="post">
    <div class="header-inicio">
						
								<div class="toggler">
									<div id="Panel-login" class="ui-widget-content ui-corner-all">
									
										<h3 class="ui-widget-header ui-corner-all">Ingreso</h3>
										<br/>
										
												<% if(request.getParameter("e")!=null && request.getParameter("e").toString().compareTo("1")==0){ %>
										 		<span class="error_label">Error en el usuario y/o password</span>
										 		<br/>
										 <% } %>
										
											<table>
												<tr>	
													<td>Usuario</td>
													<td><input id="user" name="user" autocomplete="off" type="text" value="" size="13"/></td>
												</tr>
												<tr>	
													<td>Contraseña</td>
													<td><input id="pass" name="pass" type="password" autocomplete="off" value="" size="13"/></td>
												</tr>
												<tr>	
													<td>Perfil</td>
													<td> <select id="perfil" name="perfil">
														  <option value="1">Estudiante</option>
														  <option value="2">Trabajador</option>
														</select> 
													</td>
												</tr>	
											</table>		
										<br/>
										<div style="clear: both;"></div>
										<div class="divbutton_login">
											<input type="submit" id="button_login" class="ui-state-default ui-corner-all" value="Entrar"/> 
										</div>	
										<hr/>
										 <div id="button-login">
										<br/> <a href="registrarse.jsp?a=get_pass">¿Olvid&oacute; su contraseña?</a>
 										<br/> <a href="registrarse.jsp?a=registrarse">Obtener Usuario</a> 
										</div>
									</div>
								</div>
		</div>
		</form>