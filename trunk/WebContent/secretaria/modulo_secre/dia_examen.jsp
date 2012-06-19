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
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");


CValidation valid=new CValidation();
String action=valid.ValidarRequest(request.getParameter("a"));
if(action.equalsIgnoreCase("especifico_calendar")){
	
	
	CDataExam dbo=new CDataExam();
	
	if(dbo.Connect()){
		
		ArrayList<CCita> list=new ArrayList<CCita>();
		if(pac!=null) list=dbo.ListCitasEstudiante(pac.getIdpaciente());
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
		<button class="mybutton" onclick="CrearCarne('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">CREAR NUEVO</button>		
		</div>
		  <div style="float:right;">			
			<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cerrar</a>
		  </div>
		  <div style="float:right;">			
			<a  class="ui-state-default ui-corner-all button-save" onclick="Actualizar('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')"> <img  width="24px"  height="24px" src="../images/actualizar.png" />Actualizar</a>
		  </div>
		<div style="clear: both;"></div>  
		<div class="ui-widget-content ui-corner-all">
		
		
		
			<div style="float:left; width:400px;">
			Carne<input type="text" id="carne" name="carne"  size="20px"/><button onclick="buscar('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')" class="mybutton">BUSCAR</button><br/>
			<b><%=(pac==null)?"":pac.getCarne()%></b><br/>
			<%=(pac==null)?"":pac.getIdpaciente()+ ")<b>"+(pac.getNombre()+" "+pac.getApellido()) %></b><br/>
			<b>Fecha Nac:</b> <%=(pac==null)?"":(pac.getddmmyyFecha()) %> <b>Movil:</b> <%=(pac==null)?"":(pac.getMovil()) %><br/>
			<b>Email: </b><%=(pac==null)?"":(pac.getEmail()) %><BR>
			
			</div>
			<div style="float:left; width:300px;">
			<% 
			Iterator<CCita> it3=list.iterator();
			while(it3.hasNext()){
				CCita cc=it3.next();
				String img="'../images/close.png'";
				if(cc.getEstado()==1) img="'../images/exclamation.png'";
				else if(cc.getEstado()==2) img="'../images/off.png'";
				else if(cc.getEstado()==0) img="'../images/close.png'";
				else if(cc.getEstado()==3) img="'../images/on.png'";
				%>

				<button onclick="Modificar(<%= cc.getIdcita()%>)"><img width='18px' height='18px' src=<%=img%> /></button>
				<%= cc.getFormatoFechaddmmyy(cc.getFecha()) %> <%= cc.getFormatoFechahhmm(cc.getHora_inicio()) %> <%= cc.getTipo_examenD() %><br/>
			<%}%>
			
			</div>

			<div style="clear: both;"></div>
			
		</div>
					<div style="width:750px;float:right;">
						<img width='18px' height='18px' src="../images/exclamation.png" /> CITA NO CONFIRMADA
				<img width='18px' height='18px' src="../images/off.png" /> CAMBIO DE CITA
				<img width='18px' height='18px' src="../images/on.png" /> CITA CONFIRMADA
				<img width='18px' height='18px' src="../images/close.png" /> NO SE PRESENTO		
			</div>
		<div style="float:right">
			REPORTE DE:<select id="tipo_cita">
				<option value="1,2,3,0" SELECTED>TODOS</option>
				<option value="1">CITA NO CONFIRMADA</option>
				<option value="2">CAMBIO DE CITA</option>
				<option value="3">CITA CONFIRMADA</option>
				<option value="0">NO SE PRESENTO</option>
				<option value="1,3">CITA NO CONFIRMADA, CITA CONFIRMADA</option>
				<option value="2,0">CAMBIO DE CITA, NO SE PRESENTO</option>
				
			</select>
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
								<td><%=citaact%> 
									<% if(citaact>0){%>
											<a class="mybutton" onclick="asignar('<%=cc.getIdcita()%>','<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">(ASIGNAR)</a>
											<br/>Boleta<input type="text" id="boleta" name="boleta" size="20"/>
									<% } %>
									
								</td>
							<td>
							<a class="mybutton"  target="_blank" href="index.jsp?portal=10&idcita=<%=cc.getIdcita()%>&a=especifico_calendar"> VER <%=cc.getCupo_disp() %></a><br/>
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
				
				$('#carne').keypress(function(e){
					if(e.keyCode == 13)
					{ 
						buscar('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>');
					}
				});
				function buscar(init,end){

					cadena = [ 'a=estudiante_consulta','carne='+$("#carne").val(),].join('&');
					 
					 $.ajax({
					        url: "../SEstudiante",
					        data: cadena,
					  	    type: 'post',
					  	  	success: function(data){
							  	  	$( "#dialog-form" ).dialog( "close" );
							  		$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
							  		$( "#dialog-form" ).dialog( "open" );   	
					        }
					    });
				}
				function Modificar(id){
					cadena = [ 'a=estu_cita','idcita='+id,].join('&');
					 
					 $.ajax({
					        url: "../SCita",
					        data: cadena,
					  	    type: 'post',
					  	  	dataType: 'json',
					  	  	success: function(data){
					  	  	$( "#dialog-form" ).dialog( "close" );
					  		$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+<%=request.getParameter("start")%>+"&end="+<%=request.getParameter("end")%>+"&a=especifico_calendar&");
					  		$( "#dialog-form" ).dialog( "open" );
					        }
					    });
					
				}
				function Actualizar(init,end){
					$( "#dialog-form" ).dialog( "close" );
			  		$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
			  		$( "#dialog-form" ).dialog( "open" ); 
				}
				function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					$('#calendar').weekCalendar("gotoWeek", new Date(<%=request.getParameter("start")%>));
					 
				}
				function CrearCarne(init,end){
					$( "#dialog-form" ).dialog( "close" );
			  		$( "#dialog-form" ).load("modulo_secre/crear_estudiante.jsp?start="+init+"&end="+end);
			  		$( "#dialog-form" ).dialog( "open" );
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
						cadena = [ 'a=asignar_cita','idcita='+id,'boleta='+$("#boleta").val()].join('&');
						 
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
										
										cadena = ['idcita='+id].join('&');
										$.ajax({
									        url: "../SSendMailCita",
									        data: cadena,
									  	    type: 'post',
									  	  	dataType: 'json',
									  	  	success: function(data){
									  	  			
									  	  		}
											});
						        	}
						        }
						    });
					}
					function asignados(id,init,end){
						$( "#dialog-form" ).dialog( "close" );
						$( "#dialog-form" ).load("modulo_secre/lista_paciente.jsp?idcita="+id+"&start="+init+"&end="+end+"&a=especifico_calendar&");
						$( "#dialog-form" ).dialog( "open" );
					}
				<%
						Iterator<CCita> it2=cita.iterator();
						while(it2.hasNext()){
							CCita cc=it2.next();
						%>
						
							function r_dia_examen_<%=cc.getIdcita()%>(){
								$('#parameters').val('idcita,estado');
								$('#values').val('<%=cc.getIdcita()%>|'+$("#tipo_cita").val());
								$('#report').val('Estudiantes_cita');
								$('#report_name').val('Estudiantes_cita');
								$("#form_report").submit();								
							}
							function Er_dia_examen_<%=cc.getIdcita()%>(){
								$('#parameters1').val('idcita,estado');
								$('#values1').val('<%=cc.getIdcita()%>|'+$("#tipo_cita").val());
								$('#report1').val('Estudiantes_cita');
								$('#report_name1').val('Estudiantes_cita');
								$("#form_report1").submit();
								
							}
				
				
				<%	} %>
				</script>
				<%		
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
    