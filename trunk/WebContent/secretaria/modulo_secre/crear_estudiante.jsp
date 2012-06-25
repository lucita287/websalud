<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CPaciente" %>
    <%@ page import="framework.CDataExam" %>
    <%@ page import="data.CUnidad_Academica"%>
    <%@ page import="java.util.ArrayList"%>
    <%@ page import="java.util.Iterator"%>
    <%@ page import="framework.CValidation" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>
    <%@ page import="java.util.Locale" %>
<%
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
	CDataExam dbo=new CDataExam();
	if(dbo.Connect()){
	String user=(String)sessiones.getAttribute("resultado");
	user=(user==null)?"0":user;
CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
CValidation valid=new CValidation();
String idcita=request.getParameter("idcita");
ArrayList<CUnidad_Academica>list=dbo.getListaUnidadAcademicas();
Iterator<CUnidad_Academica> it=list.iterator();
%>    
<script>
<% if(request.getParameter("start")!=null){%>
				function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					$('#calendar').weekCalendar("gotoWeek", new Date(<%=request.getParameter("start")%>));
					 
				}
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
				function NuevaCita(init,end){
					$( "#dialog-form" ).dialog( "close" );
					$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
					$( "#dialog-form" ).dialog( "open" );
					
				}
<% }else{ %>
				function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					<%if(idcita==null){%>
					document.location.href="index.jsp?portal=3";	
					<%}else{%>
					document.location.href="index.jsp?portal=10&idcita=<%=idcita%>&a=especifico_calendar";
					<%}%>
				}	
<%}%>				

$(function() {
	$( ".button-save" ).button();
	$('.mybutton').button();
	$(".datepicker").mask("99/99/9999");
	$("#carne2").focus();
});

function GuardarPaciente(){
	cadena = [ 'a=crear_estudiante',
	           'carne='+$("#carne2").val(),
	           'nombre='+$("#nombre2").val(),
	           'apellido='+$("#apellido2").val(),
	           'unidad='+$("#unidad2").val(),
	           'fecha='+$("#fecha2").val(),
	           'sexo='+$("#sexo2").val()
	         ].join('&');
	 
	 $.ajax({
	        url: "../SEstudiante",
	        data: cadena,
	  	    type: 'post',
	  	  	dataType: 'json',
	  	  	success: function(data){
	  	  		alert(data.mensaje);
	  	  		if(data.resultado=='OK'){
			  	  	<% if(request.getParameter("start")!=null){%>
			  			NuevaCita(<%=request.getParameter("start")%>,<%=request.getParameter("end")%>);
				  	<% }else{%>
				  			Cancelar();
				  	<% }%>
	  	  		}
	        }
	    });
	
}
</script>
<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
<% if(request.getParameter("start")!=null){%>
<div style="float:left;">

<button class="mybutton" onclick="NuevaCita('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">REGRESAR A CITA</button>
<button class="mybutton" onclick="BuscarCarne('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">BUSCAR POR CARNE</button>
<button class="mybutton" onclick="BuscarNombre('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">BUSCAR POR NOMBRE</button>
</div>
<%	} %>
<div style="float:right;">			
			<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cerrar</a>
</div>
		<div style="clear: both;"></div>
<h2>Crear Paciente</h2>

Carne: <input type="text" size="20" id="carne2" /><br/>
*Nombre: <input type="text" size="40" id="nombre2" /><br/>
*Apellido: <input type="text" size="40" id="apellido2" /><br/>
Unidad Academica: <select  id="unidad2">
									<option value="0"   >NO ES ESTUDIANTE</option>
										<% 
											while(it.hasNext()){
												CUnidad_Academica unidad=it.next();%>
												<option value="<%= unidad.getIdunidad_academica() %>"   ><%=unidad.getCodigo()+"/"+unidad.getNombre() %></option>
										<%	} %>
					</select> <br/>
<% 
Date cal=new Date();
SimpleDateFormat formatter = new SimpleDateFormat("dd'/'MM'/'yyyy", new Locale("es"));
String fecha= formatter.format(cal);
%>					
*Fecha de Nacimiento: <input type="text" id="fecha2" class="datepicker" value="<%= fecha %>" />dd/MM/yyyy<br/>
Sexo:  <select  id="sexo2">
									<option value="1"   >MASCULINO</option>
									<option value="2"   >FEMENINO</option>
		</select>							
<center>
<button class="ui-state-default ui-corner-all button-save" onclick="GuardarPaciente()"><img  width="24px"  height="24px" src="../images/guardar.png" />Guardar</button>
</center>
<% } dbo.Close(); } 
%>