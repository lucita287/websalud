<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="framework.CValidation" %> 
<%@ page import="data.CPaciente" %>
<%@ page import="data.CParentesco" %>
<%@ page import="data.CEstado_Civil" %>
<%@ page import="data.CTipo_Sangre" %>
<%@ page import="data.CTitulo_Secundaria" %>
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
	ArrayList<CParentesco> paren=data.getListaParentesco();
	ArrayList<CTitulo_Secundaria> secu=data.getListaTitulo_Secundaria();
%>
    <script  type="text/javascript">
			  $(document).ready(function () {
				  $("#MainForm").validate({
								rules: {
									emer_par_personal: {
										min:1
									}
								}, messages: {
									emer_par_personal: {
										min:"Seleccione un parentesco"
									}
								}	
				  });
			  });
			  $(function() {
					var secundaria=
						[
						 	<% Iterator<CTitulo_Secundaria> it_secu= secu.iterator();
						 	while(it_secu.hasNext()){
						 		CTitulo_Secundaria secundaria=it_secu.next();
						 		out.println("'"+secundaria.getNombre()+"'"+((it_secu.hasNext())?",":""));
						 	}%>
						 ];
					$( "#tit_secun_personal" ).autocomplete({
						source: secundaria
					});
					$( ".check" ).button();	
					$(".siguiente").button();
				});

	</script>		  
	<form id="MainForm" name="MainForm" action="../SDatoPersonal" method="post">
<div style="float:left;">
<h2>PASO 1</h2>
</div>
	<%
	CValidation valid=new CValidation();
String error=valid.ValidarRequest(request.getParameter("e"));
    
	if(!error.isEmpty()){
		out.println("<div class='ui-state-default ui-corner-all  ui-state-error'><h3>"+error+"</h3></div>");
	}
	 %>
<div class="button-sig">

<input type="submit" id="button_sig" class="large button red" value="Siguiente"/> 
</div>
<div style="clear: both;"></div>
<input type="hidden" name="idestatus" value="1" id="idestatus"/>
<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Datos Personales</h3>
				
				<div class="perfil">
					<div class="tabla">
						<div class="border">
							
									<div class="col_titulo">Nombre</div>
									<div class="col"><%= pac.getNombre()+", "+pac.getApellido() %></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							
									<div class="col_titulo">Fecha Nacimiento</div>
									<div class="col"><%= pac.getFormatoFechaDes(pac.getFecha_nacimiento()) %></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
								<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>							
									<div class="col_titulo">*Estado Civil</div>
									<div class="col">
										<% 
										Iterator<CEstado_Civil> it=estado.iterator();
										while(it.hasNext()){
											CEstado_Civil civil=it.next();	
										%>
										<input type="radio" id="civil_<%=civil.getIdestado_civil()%>" name="civil_personal" value="<%=civil.getIdestado_civil()%>" class="check required" 
										 <%= civil.getIdestado_civil()==pac.getEstado_civilidestado_civil() ?"checked=\"checked\"":"" %>  />
										<label for="civil_<%=civil.getIdestado_civil()%>"><%= civil.getNombre() %></label>
										<% } %>									
									</div>
									
							<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>
						</div>
						<div class="border">
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Tipo de Sangre</div>
									<div class="col">
										<% 
										Iterator<CTipo_Sangre> it2=tsangre.iterator();
										while(it2.hasNext()){
											CTipo_Sangre tsg=it2.next();	
										%>
										<input type="radio" id="tsangre_<%=tsg.getIdtipo_sangre() %>" name="tsangre_personal" value="<%=tsg.getIdtipo_sangre() %>" class="check required" name="tsangre" <%= tsg.getIdtipo_sangre() ==pac.getIdtipo_sangre()?"checked=\"checked\"":"" %>  /><label for="tsangre_<%=tsg.getIdtipo_sangre() %>"><%=tsg.getNombre()%></label>
										<% } %>									
									</div>
									
								<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>	
						</div>
						<div class="border">
							
									<div class="col_titulo">Titulo Secundaria</div>
									<div class="col"><input id="tit_secun_personal" name="tit_secun_personal" value="<%= pac.getTitulo_secundaria()%>" type="text" size="80"  ></div>
									
							<div style="clear: both;"></div>
						</div>
						<div class="border">
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Crecio en</div>
									<div class="col"><input type="text" id="crecio_en_personal" name="crecio_en_personal" size="40" value="<%= pac.getCrecio_en() %>" class="required" /><br/><span>Lugar</span></div>
									
								<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>		
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
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Nombre</div>
									<div class="col"><input type="text" name="emer_nombre_personal" id="emer_nombre_personal" value="<%= pac.getEmer_nombre() %>" size="60" class="required" /></div>
									
								<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>	
						</div>
						<div class="border">
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Parentesco</div>
									<div class="col">
											<select id="emer_par_personal" name="emer_par_personal">
												<option value="0">SELECCIONE SU PARENTESCO</option>	
												<%	Iterator<CParentesco> it3=paren.iterator();
												while(it3.hasNext()){
													CParentesco par=it3.next();
													
													%>
													<option value="<%= par.getIdparentesco() %>" <%= (par.getIdparentesco()==pac.getIdemer_parentesco()?"SELECTED":"") %> ><%= par.getNombre() %></option>
												<% } %>
											</select>
									</div>
									
							<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>
						</div>
						<div class="border">
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Telefono casa</div>
									<div class="col"><input type="text" id="tel_personal" name="tel_personal" value="<%=pac.getEmer_telefono() %>"  size="20"/></div>
									
								<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>	
						</div>
						<div class="border">
							<%if(!error.isEmpty()) out.println("<div class='ui-state-default ui-corner-all  ui-state-highlight '>"); %>
									<div class="col_titulo">*Telefono movil</div>
									<div class="col"><input type="text" id="movil_personal" name="movil_personal" value="<%=pac.getEmer_movil() %>" size="20"/></div>
									
							<div style="clear: both;"></div>
							<%if(!error.isEmpty()) out.println("</div>"); %>	
						</div>
					</div>
				</div>	
		<div style="clear: both;"></div>
</div>
	</form>
<% 
	data.Close();
	}%>	