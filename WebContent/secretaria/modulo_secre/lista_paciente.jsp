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
				int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
				ArrayList<CCita> cita= dbo.getDetalleCita(fecha_inicio,fecha_fin);
				%>
<div style="float:left;">
<button class="mybutton" onclick="NuevaCita('<%=request.getParameter("start") %>','<%=request.getParameter("end") %>')">REGRESAR A CITA</button>
</div>
 <div style="float:right;">			
	<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cerrar</a>
</div>
		<div style="clear: both;"></div>
<table id="estudiantes" style="display:none"></table>
<script>
$(document).ready(function () {
    $("#estudiantes").flexigrid
		({
			method: 'POST',
			url: '../SCitaTable',
			dataType : 'xml',
		    colModel: [
			{display: 'ID', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
			{ display: 'Carne', name: 'carne', width: 140, sortable: true, align: 'left' },
			{ display: 'Nombre', name: 'nombre', width: 140, sortable: true, align: 'left' },
			{ display: 'Apellido', name: 'apellido', width: 90, sortable: true, align: 'left' },
			{ display: 'Unidad Academica', name: 'unidad', width: 100, sortable: true, align: 'left' },
			{ display: 'Estado', name: 'estado', width: 90, sortable: true, align: 'left' }
			],
			usepager: true,
		    sortname: "carne",
			sortorder: "desc",
		    title: 'PACIENTES',
		    useRp: true,
		    rp: 15,
		    showTableToggleBtn: true,
		    searchitems : [
							{display: 'carne', name : 'carne'},
							{display: 'nombre', name : 'nombre'},
							{display: 'apellido', name : 'apellido'}
							],
		    width: 750,
		    height: 250,
			params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>}]
		});
   		$('.pSearch').click();
 });

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
function Modificar(idpaciente,idcita){
	cadena = [ 'a=estu_cita_pac','idcita='+idcita,'idpaciente='+idpaciente].join('&');
	 
	 $.ajax({
	        url: "../SCita",
	        data: cadena,
	  	    type: 'post',
	  	  	dataType: 'json',
	  	  	success: function(data){
	  	  		if(data.resultado=='OK'){
	  	  		$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>} ]});
				  $('#estudiantes').flexReload();
	  	  		}else{
	  	  			alert("No se ha cambiado");
	  	  		}
	        }
	    });
}
</script>
<%  dbo.Close(); }
} 
}%>		