<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="framework.CValidation" %>    
<%@page import="framework.CDataExam" %>
<%@page import="data.CCita" %>
<%
	CValidation valid=new CValidation();

	int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
	CDataExam dbo=new CDataExam();
	
	
	if(dbo.Connect()){
		
		CCita cita= dbo.getCita(idcita);
		if(cita!=null){%>
							<table>	
									<tr>
										<td>Fecha</td>
										<td> <%= cita.getFormatoFechaddmmyy(cita.getFecha()) %></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" id="r_hora_inicio1" type="text" value="<%= cita.getFormatoFechahhmm2(cita.getHora_inicio()) %>" class="time"/> 
											
										</td>
										<td>Hora Fin</td>
										<td><input size="10" id="r_hora_fin1" type="text" class="time"  value="<%= cita.getFormatoFechahhmm2(cita.getHora_fin()) %>" /> 
										</td>
									</tr>	
										
									<tr>	
										<td>Cupo</td>
										<td><input size="10" id="r_cupo1" type="text" value="<%= cita.getCupo() %>" /></td>
										<td>Tipo de Examen</td>
										<td><select id="r_tipo_examen1">
											<option value="0" >SELECCIONE EXAMEN</option>
											<option value="1" <%=(cita.getTipo_examen()==1)?"SELECTED":""%>>AutoEvaluacion</option>
											<option value="2" <%=(cita.getTipo_examen()==1)?"SELECTED":""%>>Multifásico</option>
											</select>
										</td>
									</tr>
									<tr>	
										<td>Estado</td>
										<td>
											<select id="r_estado1">
											<option value="1" <%=(cita.getEstado()==1)?"SELECTED":""%>>HABILITADAS</option>
											<option value="2" <%=(cita.getEstado()==2)?"SELECTED":""%>>HABILITADAS EN LINEA</option>
											<option value="0" <%=(cita.getEstado()==3)?"SELECTED":""%> >DESHABILITADAS</option>
											</select>
										</td>
									</tr>
								</table>
		<%}
	}
%>    