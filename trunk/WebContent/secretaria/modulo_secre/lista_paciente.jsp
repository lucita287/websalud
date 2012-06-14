<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@page import="framework.CValidation" %>
    <%@page import="java.util.Date" %>
    <%@page import="data.CCita" %>
    <%@page import="java.util.ArrayList" %>
    <%@page import="java.util.Iterator" %>
    <%@page import="framework.CDataExam" %>
    
<%
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
CValidation valid=new CValidation();
String action=valid.ValidarRequest(request.getParameter("a"));
if(action.equalsIgnoreCase("especifico_calendar")){
	CDataExam dbo=new CDataExam();
		
	
	if(dbo.Connect()){
				int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
				CCita cc=dbo.getCita(idcita);
			if(cc!=null){	
				%>
				
		<div style="clear: both;"></div>
		<h2>Cita <%=cc.getIdcita() %> /<%=cc.getTipo_examenD()%> -> Fecha: <%=cc.getFormatoFechaddmmyy(cc.getFecha()) %>  <%=cc.getFormatoFechahhmm(cc.getHora_inicio()) %> a <%=cc.getFormatoFechahhmm(cc.getHora_fin()) %> </h2>
<div style="float:left;">
REPORTE DE:<select id="tipo_cita">
				<option value="1" SELECTED>ESTUDIANTES CON CITAS PENDIENTES DE CONFIRMACION</option>
				<option value="2">ESTUDIANTES CON CITAS CAMBIADAS</option>
				<option value="3">ESTUDIANTES QUE ASISTIERON A SU CITAS</option>
				<option value="4">ESTUDIANTES QUE NO VINIERON A SUS CITAS</option>
			</select>
</div>
<div style="float:left;">
	<button id="pdf" onclick="lista_pdf()">PDF</button>
 </div> 
 <div style="float:left;">
  	<button id="excel" onclick="lista_excel()">EXCEL</button>
</div>
<form id="form_report" name="form_report" action="../SGen_PDF" method="post" target="_blank">
  	<input type="hidden" name="report" id="report" value="Estudiantes_cita" />
  	<input type="hidden" name="report_name" id="report_name" value="Estudiantes_cita" />
  	<input type="hidden" name="parameters" id="parameters" value="idcita" />
  	<input type="hidden" name="values" id="values" value="<%=cc.getIdcita()%>" />
  	
  </form>
<form id="form_report1" name="form_report1" action="../SGen_EXCEL" method="post" target="_blank">
  	<input type="hidden" name="report" id="report1" value="Estudiantes_cita" />
  	<input type="hidden" name="report_name" id="report_name1" value="Estudiantes_cita" />
  	<input type="hidden" name="parameters" id="parameters1" value="idcita" />
  	<input type="hidden" name="values" id="values1" value="<%=cc.getIdcita()%>" />
  </form>  		
<table id="estudiantes" style="display:none"></table>
<script>
$(function() {
	$( "#pdf" ).button();
	$( "#excel" ).button();
});
function lista_pdf(){
	$('#parameters').val('idcita,estado');
	$('#values').val('<%=cc.getIdcita()%>|'+$("#tipo_cita").val());
	$('#report').val('Estudiantes_cita');
	$('#report_name').val('Estudiantes_cita');
	$("#form_report").submit();								
}
function lista_excel(){
	$('#parameters1').val('idcita,estado');
	$('#values1').val('<%=cc.getIdcita()%>|'+$("#tipo_cita").val());
	$('#report1').val('Estudiantes_cita');
	$('#report_name1').val('Estudiantes_cita');
	$("#form_report1").submit();
	
}

$(document).ready(function () {
    $("#estudiantes").flexigrid
		({
			method: 'POST',
			url: '../SCitaTable',
			dataType : 'xml',
		    colModel: [
			{display: 'ID', name : 'chkactividad', width : 35, sortable : false, align: 'left'},           
			{ display: 'Carne', name: 'carne', width: 60, sortable: true, align: 'left' },
			{ display: 'Nombre', name: 'nombre', width: 150, sortable: true, align: 'left' },
			{ display: 'Apellido', name: 'apellido', width: 150, sortable: true, align: 'left' },
			{ display: 'Unidad Academica', name: 'unidad', width: 180, sortable: true, align: 'left' },
			{ display: 'Estado', name: 'estado', width: 60, sortable: true, align: 'left' },
			{ display: 'Boleta', name: 'boleta', width: 200, sortable: true, align: 'left' }
			],
			usepager: true,
		    sortname: "carne",
			sortorder: "desc",
		    title: 'PACIENTES',
		    useRp: true,
		    rp: 30,
		    showTableToggleBtn: true,
		    searchitems : [
							{display: 'carne', name : 'carne'},
							{display: 'nombre', name : 'nombre'},
							{display: 'apellido', name : 'apellido'}
							],
		    width: 940,
		    height: 500,
			params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>}]
		});
   		$('.pSearch').click();
 });

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
	  	  			alert("No ahi cupo disponible");
	  	  		$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>} ]});
				  $('#estudiantes').flexReload();
	  	  		}
	        }
	    });
}
function GuardarBoleta(idpaciente,idcita){
	cadena = [ 'a=updatecita_paciente','idcita='+idcita,'idpaciente='+idpaciente+'&boleta='+$("#boleta"+idpaciente).val()].join('&');
	 
	 $.ajax({
	        url: "../SCita",
	        data: cadena,
	  	    type: 'post',
	  	  	dataType: 'json',
	  	  	success: function(data){
	  	  		if(data.resultado=='OK'){
	  	  			alert("Almacenado");
	  	  		}else{
	  	  			alert("No se ha cambiado");
	  	  		}
	        }
	    });
	 
}
</script>
<%  	}
	dbo.Close(); }

}	}%>	
