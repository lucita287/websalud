<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@ page import="data.CPaciente" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="framework.CEvaluarExamen"%>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

	
	CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
	
		if (user_permiso.getIdpermiso().indexOf(260)>-1  || user_permiso.getIdusuario().getidusuario()==1){
			CDataExam dbo=new CDataExam();
			dbo.Connect(); 
%>

<h2>CONSULTAR ESTUDIANTES</h2>
<form id="MainForm" name="MainForm" action="../SEstudiante" method="post">
<input type="hidden" name="a" value="estudiante_info" />
<input type="text" name="user" size="20px" id="carne" value="<%=(pac==null||pac.getCarne()==0)?"":pac.getCarne() %>" /> <input type="submit" name="enviar" id="button_login" class="ui-state-default ui-corner-all" value="Buscar"/>
<br/>
</form>

				<% 
				if(pac!=null&&pac.getExamen_linea()>=5 && pac.getEstado()==3){
					CEvaluarExamen eva=new CEvaluarExamen();
					String sql="";
				    ArrayList<Integer> list1=eva.Evaluar(pac.getIdpaciente());
				    Iterator<Integer> it1=list1.iterator();
				    while(it1.hasNext()){
				    	sql+=it1.next();
				    	if(it1.hasNext()) sql+=",";
				    }
				    %>
				    	<form id="form_report" name="form_report" action="../SGenerateReportPDF" method="post" target="_blank">
						  	<center>
						  	<input type="submit" id="enviar" value="DESCARGAR MULTIFASICO" />
						  	</center>
						  	<input type="hidden" name="report" id="report" value="Primera_parte" />
						  	<input type="hidden" name="report_name" id="report_name" value="Primera_parte" />
						  	<input type="hidden" name="parameters" id="parameters" value="idpaciente" />
						  	<input type="hidden" name="resultado" id="resultado" value="<%= sql %>" />
						  	
						  </form>
				    <% 
				} else if(pac!=null &&pac.getExamen_linea()>=6 && pac.getEstado()==2){
					CEvaluarExamen eva=new CEvaluarExamen();
			        String sql="";
			        ArrayList<Integer> list1=eva.Evaluar(pac.getIdpaciente());
			        Iterator<Integer> it1=list1.iterator();
			        while(it1.hasNext()){
			        	sql+=it1.next();
			        	if(it1.hasNext()) sql+=",";
			        }
			        %>
			        	<form id="form_report" name="form_report" action="../SGenerateReportAutoPDF" method="post" target="_blank">
					  	<center>
					  	<input type="submit" id="enviar" value="DESCARGAR AUTOEVALUACION" />
					  	</center>
					  	<input type="hidden" name="report" id="report" value="Primera_parte" />
					  	<input type="hidden" name="report_name" id="report_name" value="Primera_parte" />
					  	<input type="hidden" name="parameters" id="parameters" value="idpaciente" />
					  	<input type="hidden" name="resultado" id="resultado" value="<%= sql %>" />
					  	
					  </form>
			        <%
				}else{
					 %>
			        	<form id="form_report" name="form_report" action="../SGenerateReportInfoPDF" method="post" target="_blank">
					  	<center>
					  	<input type="submit" id="enviar" value="INFORMACION GENERAL" />
					  	</center>
					  	<input type="hidden" name="report" id="report" value="InfoEstudiante" />
					  	<input type="hidden" name="report_name" id="report_name" value="InfoEstudiante" />
					  	<input type="hidden" name="parameters" id="parameters" value="idpaciente" />
					  </form>
			        <%
					
				}
				%>
<style>
	.titulo{
		background-color: powderBlue;
		width: 120px;
	}
	.texto{
		width: 300px;
	}
</style>
<% 
	if(pac!=null){
		%>
			<table>
				<tr>	
					<td class="titulo">Nombre</td><td class="ui-widget-content ui-corner-all texto" ><%= pac.getNombre() %></td>
					<td class="titulo">Apellido</td><td class="ui-widget-content ui-corner-all texto"><%= pac.getApellido() %></td>
				</tr>
				<tr>	
					<td class="titulo" >Direccion</td><td class="ui-widget-content ui-corner-all texto"><%= pac.getDireccion() %></td>
					<td class="titulo">Movil</td><td class="ui-widget-content ui-corner-all texto"><%= pac.getMovil() %></td>
				</tr>
				<tr>	
					<td class="titulo">Telefono</td><td class="ui-widget-content ui-corner-all texto"><%= pac.getTelefono() %></td>
					<td class="titulo">Correo Electronico</td><td class="ui-widget-content ui-corner-all texto"><%= pac.getEmail() %></td>
				</tr>
				<tr>	
					<td class="titulo">Unidad Academica</td><td class="ui-widget-content ui-corner-all texto"><%= dbo.getUnidadAcademica(pac.getIdunidad_academica()) %></td>
					<td class="titulo">Sexo</td><td class="ui-widget-content ui-corner-all texto"><%= (pac.getSexo()==1)?"MASCULINO":"FEMENINO" %></td>
				</tr>
			</table>	
		<%
	}
	dbo.Close();
 } 	}%>