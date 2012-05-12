<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@page import="framework.CValidation" %>
    <%@page import="java.util.Date" %>
    <%@page import="data.CCita" %>
    <%@page import="java.util.ArrayList" %>
    <%@page import="java.util.Iterator" %>
    <%@page import="framework.CDataExam" %>
      <%@ page import="data.CPaciente" %>
<%
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null){
CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
ArrayList<CCita> list=(ArrayList<CCita>)sessiones.getAttribute("paci_list");
if(list==null) list=new ArrayList<CCita>();
CValidation valid=new CValidation();
String action=valid.ValidarRequest(request.getParameter("a"));
if(action.equalsIgnoreCase("especifico_calendar")){
	CDataExam dbo=new CDataExam();
	if(dbo.Connect()){
				Long start=valid.ConvertLong(valid.ValidarRequest(request.getParameter("start")));
				Date fecha_inicio=valid.ConvertoDate(start);
				Long end=valid.ConvertLong(valid.ValidarRequest(request.getParameter("end")));
				Date fecha_fin=valid.ConvertoDate(end);
		
				ArrayList<CCita> cita= dbo.getDetalleCita(fecha_inicio,fecha_fin);
				%>
		<link rel='stylesheet' type='text/css' href="../css/system_secre.css" />		
		<div style="float:left;">
		<button class="mybutton" onclick="BuscarNombre('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">BUSCAR NOMBRE</button>
		<button class="mybutton" onclick="BuscarCarne('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">BUSCAR CARNE</button>		
		</div>
		  <div style="float:right;">			
			<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cerrar</a>
		  </div>
		<div style="clear: both;"></div>  
		<div class="ui-widget-content ui-corner-all">
			<div style="float:left; width:400px;">
			<%=(pac==null)?"":pac.getCarne()%><br/>
			<%=(pac==null)?"":pac.getIdpaciente()+ ")"+(pac.getNombre()+" "+pac.getApellido()) %><br/>
			<%=(pac==null)?"":(pac.getddmmyyFecha()) %>
			</div>
			<div style="float:left; width:300px;">
			<% 
			Iterator<CCita> it3=list.iterator();
			while(it3.hasNext()){
				CCita cc=it3.next();
				%>
				<%= cc.getFormatoFechaddmmyy(cc.getFecha()) %> <%= cc.getFormatoFechahhmm(cc.getHora_inicio()) %> <%= cc.getTipo_examenD() %>
			<%}%>
			</div>
			<div style="clear: both;"></div>
		</div>
				<table> 
					<tr>
						<td class="tab_cita" style="width:50px;">ID</td>
						<td class="tab_cita" style="width:120px;">FECHA</td>
						<td class="tab_cita" style="width:120px;">HORA</td>
						<td class="tab_cita" style="width:120px;">TIPO DE EXAMEN</td>
						<td class="tab_cita" style="width:150px;">CUPO</td>
						<td class="tab_cita" style="width:150px;">CUPO ASIGNADO</td>
					</tr>
				<%
				Iterator<CCita> it=cita.iterator();
						while(it.hasNext()){
							CCita cc=it.next();	
							int citaact=cc.getCupo()-cc.getCupo_disp();
						%>	
							
							<tr>
							<td><%=cc.getIdcita() %></td> 
							<td><%=cc.getFormatoFechaddmmyy(cc.getFecha()) %></td> 
							<td><%=cc.getFormatoFechahhmm(cc.getHora_inicio()) %></td>
							<td><%=cc.getTipo_examenD()%></td>  
							<td><%=citaact%> <% if(citaact>0){%><a class="mybutton" onclick="asignar('<%=cc.getIdcita()%>','<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">(ASIGNAR)</a><% } %></td>
							<td>
							<a class="mybutton"> VER <%=cc.getCupo_disp() %></a><br/>
							<a class="mybutton" onclick="r_dia_examen_<%=cc.getIdcita()%>()">(VER PDF)</a><br/>
							<a class="mybutton" onclick="Er_dia_examen_<%=cc.getIdcita()%>()">(VER EXCEL)</a><br/>
							</td>
							</tr>
							<tr>
								<td colspan="6"><hr/></td>
							</tr>
						<%
						}
				%></table>
				<script>
				function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					 document.location.href="index.jsp?portal=1&start="+<%=request.getParameter("start") %>+"&end="+<%=request.getParameter("end") %>;
				}
				$(function() {
					$( ".mybutton" ).button();
					$( ".button-save" ).button();
				});
					function BuscarNombre(init,end){
						$( "#dialog-form" ).dialog( "close" );
						$( "#dialog-form" ).load("modulo_secre/bnombre.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
						$( "#dialog-form" ).dialog( "open" );
						
					}
					function BuscarCarne(init,end){
						$( "#dialog-form" ).dialog( "close" );
						$( "#dialog-form" ).load("modulo_secre/bcarne.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
						$( "#dialog-form" ).dialog( "open" );
					}
					function asignar(id,init,end){
						cadena = [ 'a=asignar_cita','idcita='+id,].join('&');
						 
						 $.ajax({
						        url: "../SCita",
						        data: cadena,
						  	    type: 'post',
						  	  	dataType: 'json',
						  	  	success: function(data){
						        	alert(data.mensaje);
						  	  		if(data.resultado=='OK'){
							  	  		$( "#dialog-form" ).dialog( "close" );
										$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
										$( "#dialog-form" ).dialog( "open" );
						        	}
						        }
						    });
					}
				<%
						Iterator<CCita> it2=cita.iterator();
						while(it2.hasNext()){
							CCita cc=it2.next();
						%>
						
							function r_dia_examen_<%=cc.getIdcita()%>(){
								$('#parameters').val('idcita');
								$('#values').val('<%=cc.getIdcita()%>');
								$('#report').val('Estudiantes_cita');
								$('#report_name').val('Estudiantes_cita');
								$("#form_report").submit();
								
							}
							function Er_dia_examen_<%=cc.getIdcita()%>(){
								$('#parameters1').val('idcita');
								$('#values1').val('<%=cc.getIdcita()%>');
								$('#report1').val('Estudiantes_cita');
								$('#report_name1').val('Estudiantes_cita');
								$("#form_report1").submit();
								
							}
				
				</script>
				<%
				}
				dbo.Close();
				
	}
  }
}
%>

<form id="form_report" name="form_report" action="../SGen_PDF" method="post" target="_blank">
  	<input type="hidden" name="report" id="report" value="" />
  	<input type="hidden" name="report_name" id="report_name" value="" />
  	<input type="hidden" name="parameters" id="parameters" value="" />
  	<input type="hidden" name="values" id="values" value="" />
  </form>
<form id="form_report1" name="form_report1" action="../SGen_EXCEL" method="post" target="_blank">
  	<input type="hidden" name="report" id="report1" value="" />
  	<input type="hidden" name="report_name" id="report_name1" value="" />
  	<input type="hidden" name="parameters" id="parameters1" value="" />
  	<input type="hidden" name="values" id="values1" value="" />
  </form>
    