<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CPaciente" %>
<%@ page import="data.CParentesco" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>

<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
		
	CDataExam	data=new CDataExam();
	data.Connect();
	ArrayList<CParentesco> lista_paren=data.getListaParentesco(0,1,0);
%>	
<script>
$(function() {
	$( ".check" ).button();
});
$(document).ready(function () {
	  $("#MainForm").validate();
});
</script>
	<form id="MainForm" name="MainForm" action="../SDatoPersonal" method="post">
<div style="float:left;">
<h2>PASO 1</h2>
</div>
<div class="button-sig">
<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Guardar"/> 
</div>
<div style="clear: both;"></div>	

<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Datos Personales</h3>
				
				<div class="perfil">
					<div class="tabla">
							<div class="border">
							
									<div class="col_titulo">Nombre</div>
									<div class="col"><input type="text" class="required" value="<%= pac.getNombre() %>" size="60" /></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Cedula</div>
									<div class="col">
									
										<select id="paren_usuario" name="paren_usuario" >
										<option value="0">SOY MAYOR DE EDAD</option>
									<%
										Iterator<CParentesco> it_paren=lista_paren.iterator();
										while(it_paren.hasNext()){
											CParentesco paren= it_paren.next();
											out.println("<option value=\""+paren.getIdparentesco()+"\">"+paren.getNombre()+" Responsable </option>");
										}
									%>	</select>
									<input type="text" id="ced_usuario" name="ced_usuario" class="required" value="<%= pac.getCedula() %>" size="25"/>
									
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Telefono</div>
									<div class="col"><input type="text" id="tel_usuario" name="tel_usuario"  value="<%= pac.getTelefono() %>"  size="30"/></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Telefono Movil</div>
									<div class="col"><input type="text" id="movil_usuario" name="movil_usuario"  size="30" value="<%= pac.getMovil() %>"/></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Direcci&oacute;n</div>
									<div class="col">
									<textarea id="direccion" class="required" name="direccion"  rows="3" cols="50"  class="required"><%=pac.getDireccion() %></textarea>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">*Fecha de Nacimiento</div>
									<div class="col">
									<input type="text" id="datepicker" class="required" name="datepicker" class="required" size="10"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">*Sexo</div>
									<div class="col">
									<input type="radio" id="genero_1" class="required" name="genero" value="1" class="check"/><label for="genero_1">MASCULINO</label>
										<input type="radio" id="genero_2" class="required" name="genero" value="2" class="check" checked="checked" /><label for="genero_2">FEMENINO</label>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Correo Electronico</div>
									<div class="col">
									<input type="text" id="correo_electronico" name="correo_electronico" value="<%= pac.getEmail() %>" size="50"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Contrase&ntilde;a anterior</div>
									<div class="col">
									<input type="text" class="required" id="pass_ant" name="pass_ant"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Nueva Contrase&ntilde;a</div>
									<div class="col">
									<input type="text" id="pass_ant" name="pass_ant"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Confirmar Nueva Contrase&ntilde;a</div>
									<div class="col">
									<input type="text" id="pass_ant" name="pass_ant"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
					</div>
				</div>	
</div>
	</form>
<%  data.Close(); }	%>				