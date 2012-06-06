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
<div style="float:left;">
<button class="mybutton" onclick="NuevaCita('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">REGRESAR A CITA</button>
<button class="mybutton" onclick="BuscarCarne('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">BUSCAR CARNE</button>
</div>
 <div style="float:right;">			
	<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cerrar</a>
</div>
		<div style="clear: both;"></div>
<H2>BUSQUEDA POR NOMBRE (LOCALMENTE)/Maximo 30</H2>

Nombre <input type="text" id="nombre" />
Apellido <input type="text" id="apellido" />
<button onclick="buscarNombre()" class="mybutton">BUSCAR</button>
<div id="respuesta"></div>
<script>
function buscarNombre(){
	cadena = [ 'a=buscar_nombre','nombre='+$("#nombre").val(),'apellido='+$("#apellido").val(),].join('&');
	 
	 $.ajax({
	        url: "../SEstudiante",
	        data: cadena,
	  	    type: 'post',
	  	  	success: function(data){
	     		$("#respuesta").html(data);   	
	        }
	    });
}
function Cancelar(){
	$( "#dialog-form" ).dialog( "close" );
	 document.location.href="index.jsp?portal=1&start="+<%=request.getParameter("start") %>+"&end="+<%=request.getParameter("end") %>;
}
$(function() {
	$( ".mybutton" ).button();
	$( ".button-save" ).button();
});
function NuevaCita(init,end){
	$( "#dialog-form" ).dialog( "close" );
	$( "#dialog-form" ).load("modulo_secre/dia_examen.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
	$( "#dialog-form" ).dialog( "open" );
	
}
function BuscarCarne(init,end){
	$( "#dialog-form" ).dialog( "close" );
	$( "#dialog-form" ).load("modulo_secre/bcarne.jsp?start="+init+"&end="+end+"&a=especifico_calendar&");
	$( "#dialog-form" ).dialog( "open" );
}


</script>
<%  dbo.Close(); }
} 
}%>		