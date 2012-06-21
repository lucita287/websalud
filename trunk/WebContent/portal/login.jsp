<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
	<form id="MainForm" name="MainForm" action="SLogin" method="post">
    <div class="header-inicio">
						
								<div class="toggler">
									<div id="Panel-login" class="ui-widget-content ui-corner-all">
									
										<h3 class="ui-widget-header ui-corner-all">Ingreso</h3>
										<br/>
										
												<% if(request.getParameter("e")!=null){ %>
										 		<span class="error_label"><%=request.getParameter("e") %></span>
										 		<br/>
										 <% } %>
										
											<table>
												<tr>	
													<td>Usuario <br/>(Carné)</td>
													<td><input id="user" name="user" type="text" value="" size="13"/></td>
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
														  <option value="3">Secretaria</option>
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
										
										<br/> <a href="http://rye.usac.edu.gt/index.php?ring=4" TARGET = "_blank">¿Olvid&oacute; su contraseña?</a>
										</div>
										<br/> <div style="text-align:justify;"> 
										Ingresar a este sitio por medio de su carnet y pin generado en el Departamento de Registro y Estadística
										</div>
									</div>
								</div>
		</div>
		</form>
		<div class="ui-widget-content ui-corner-all">
		<div><b>Visitas</b> <a href="http://usalud.usac.edu.gt/index.jsp">
		<img src="http://www.easycounter.com/counter.php?lucita287"
			border="0" alt="Counter"></a></div>
		</div>
		<br>