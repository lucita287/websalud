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
<h2>PASO 1 / OPCIONAL, ACTUALIZACI&Oacute;N DE DATOS</h2>
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
									<div class="col"><%= pac.getNombre() %></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Cedula</div>
									<div class="col">
									
										<select id="cedt_general" name="cedt_general" >
										<option value="0">SOY MAYOR DE EDAD</option>
									<%
										Iterator<CParentesco> it_paren=lista_paren.iterator();
										while(it_paren.hasNext()){
											CParentesco paren= it_paren.next();
											out.println("<option value=\""+paren.getIdparentesco()+"\">"+paren.getNombre()+" Responsable </option>");
										}
									%>	</select>
									<input type="text" id="ced_general" name="ced_general" class="required" value="<%= pac.getCedula() %>" size="25"/>
									
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Telefono</div>
									<div class="col"><input type="text" id="tel_general" name="tel_general"  value="<%= pac.getTelefono() %>"  size="30"/></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Telefono Movil</div>
									<div class="col"><input type="text" id="movil_general" name="movil_general"  size="30" value="<%= pac.getMovil() %>"/></div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Direcci&oacute;n</div>
									<div class="col">
									<textarea id="dir_general" class="required" name="dir_general"  rows="3" cols="50"  class="required"><%=pac.getDireccion() %></textarea>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">*Sexo</div>
									<div class="col">
									<input type="radio" id="genero_1"  name="genero_general" value="1" class="required genero check" <%= 1 ==pac.getSexo()?"checked=\"checked\"":"" %> />
									<label for="genero_1">MASCULINO</label>
									<input type="radio" id="genero_2"  name="genero_general" value="2" class="required genero check" <%= 2 ==pac.getSexo()?"checked=\"checked\"":"" %> />
									<label for="genero_2">FEMENINO</label>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Correo Electronico</div>
									<div class="col">
									<input type="text" id="correo_electronico" name="email_general" value="<%= pac.getEmail() %>" class="email" size="50"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Contrase&ntilde;a anterior</div>
									<div class="col">
									<input type="text" class="required" id="pass_ant_general" name="pass_ant"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Nueva Contrase&ntilde;a</div>
									<div class="col">
									<input type="text" id="pass_ant" name="pass_new_general"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
							<div class="border">
							
									<div class="col_titulo">Confirmar Nueva Contrase&ntilde;a</div>
									<div class="col">
									<input type="text" id="pass_ant" name="pass_conf_general"  size="20"/>
									</div>
									
								<div style="clear: both;"></div>
							</div>
					</div>
				</div>	
</div>
	</form>
<%  data.Close(); }	%>				