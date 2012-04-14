<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CPaciente" %>
<%@ page import="data.CParentesco" %>
<%@ page import="data.CEstado_Civil" %>
<%@ page import="data.CTipo_Sangre" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
		
	CDataExam	data=new CDataExam();
	data.Connect();
	ArrayList<CEstado_Civil> estado=data. getListaEstadoCivil();
	ArrayList<CTipo_Sangre> tsangre=data.getListaTipo_Sangre();
	ArrayList<CParentesco> paren=data.getListaParentesco(0,0, 1);
%>
	<form id="MainForm" name="MainForm" action="../SDatoPersonal" method="post">
<script>
$(function() {
	$( ".check" ).button();
});
</script>
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
							
									<div class="col_titulo">Fecha Nacimiento</div>
									<div class="col"><%= pac.getFormatoFechaDes(pac.getFecha_nacimiento()) %></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Estado Civil</div>
									<div class="col">
										<% 
										Iterator<CEstado_Civil> it=estado.iterator();
										while(it.hasNext()){
											CEstado_Civil civil=it.next();	
										%>
										<input type="radio" id="estado_<%=civil.getIdestado_civil()%>" name="estado_civil" class="check" /><label for="estado_<%=civil.getIdestado_civil()%>"><%= civil.getNombre() %></label>
										<% } %>									
									</div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">*Tipo de Sangre</div>
									<div class="col">
										<% 
										Iterator<CTipo_Sangre> it2=tsangre.iterator();
										while(it2.hasNext()){
											CTipo_Sangre tsg=it2.next();	
										%>
										<input type="radio" id="tsangre_<%=tsg.getIdtipo_sangre() %>" name="tsangre" class="check" /><label for="tsangre_<%=tsg.getIdtipo_sangre() %>"><%= tsg.getNombre() %></label>
										<% } %>									
									</div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Titulo Secundaria</div>
									<div class="col"><input type="text" size="60"></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Crecio en</div>
									<div class="col"><input type="text" size="40"/><br/><span>Lugar</span></div>
									
							<div style="clear: both;"></div>
						</div>
					</div>
				</div>
				<div style="clear: both;"></div>
				
</div>
<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Persona a notificar en Caso de Emergencia</h3>

				<div class="perfil">
					<div class="tabla">
						<div class="border">
							
									<div class="col_titulo">Nombre</div>
									<div class="col"><input type="text" value="" size="60" /></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Parentesco</div>
									<div class="col">
											<select>
												<option value="0">SELECCIONE SU PARENTESCO</option>	
												<%	Iterator<CParentesco> it3=paren.iterator();
												while(it3.hasNext()){
													CParentesco par=it3.next();
													
													%>
													<option value="<%= par.getIdparentesco() %>"><%= par.getNombre() %></option>
												<% } %>
											</select>
									</div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Telefono casa</div>
									<div class="col"><input type="text" size="20"/></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Telefono movil</div>
									<div class="col"><input type="text" size="20"/></div>
									
							<div style="clear: both;"></div>
						</div>
					</div>
				</div>	
		<div style="clear: both;"></div>
</div>
<div class="button-sig">
<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Siguiente/Guardar"/> 
 
</div>
	</form>
<% 
	data.Close();
	}%>	