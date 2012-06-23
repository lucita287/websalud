<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@page import="framework.CValidation" %>
    <%@page import="java.util.Date" %>
    <%@page import="data.CCita" %>
    <%@page import="data.CPaciente" %>
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
				CPaciente pac=(CPaciente)sessiones.getAttribute("paci_consulta");
				int idcita=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idcita")));
				CCita cc=dbo.getCita(idcita);
			if(cc!=null){	
				%>
				
		<div style="clear: both;"></div>
		<h2>Cita <%=cc.getIdcita() %> /<%=cc.getTipo_examenD()%> -> Fecha: <%=cc.getFormatoFechaddmmyy(cc.getFecha()) %>  <%=cc.getFormatoFechahhmm(cc.getHora_inicio()) %> a <%=cc.getFormatoFechahhmm(cc.getHora_fin()) %> </h2>

<div style="float:right; width:400px;">
	<input type="text" id="carne3" name="carne3" value="<%=(pac==null)?"":pac.getCarne()%>"/>
	<button id="bcarne3" onclick="buscar_carne3()">BUSCAR</button>
	<button id="examen_realizado"  onclick="examen_realizado()" >EXAMEN REALIZADO</button><BR/>
	<%=(pac==null)?"":pac.getCarne()%><br>
	<%=(pac==null)?"":pac.getIdpaciente()+ ")<b>"+(pac.getNombre()+" "+pac.getApellido()) %></b><br/>
	
</div>
<div style="float:left;">
REPORTE DE:<select id="tipo_cita" onchange="CambiarEstado()">
				<option value="0,1,2,3,4" SELECTED>TODOS</option>
				<option value="1">PENDIENTE DE ASISTIR</option>
				<option value="2">CAMBIO DE CITA</option>
				<option value="3">EXAMEN REALIZADO</option>
				<option value="0">NO SE PRESENTO</option>
				<option value="1,3">PENDIENTE DE ASISTIR, EXAMEN REALIZADO</option>
				<option value="2,0">CAMBIO DE CITA, NO SE PRESENTO</option>
			</select>
</div>

<div style="float:left;">
	<button id="pdf" onclick="lista_pdf()">PDF</button>
 </div> 
 <div style="float:left;">
  	<button id="excel" onclick="lista_excel()">EXCEL</button>
</div>

<div style="width:750px;float:right;">
						<img width='18px' height='18px' src="../images/exclamation.png" /> PENDIENTE DE ASISTIR
				<img width='18px' height='18px' src="../images/off.png" /> CAMBIO DE CITA
				<img width='18px' height='18px' src="../images/on.png" /> EXAMEN REALIZADO
				<img width='18px' height='18px' src="../images/close.png" /> NO SE PRESENTO		
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
$('#carne3').keypress(function(e){
	if(e.keyCode == 13)
	{ 
		buscar_carne3();
	}
});
function buscar_carne3(){
	cadena = [ 'a=estudiante_consulta','carne='+$("#carne3").val(),].join('&');
	 
	 $.ajax({
	        url: "../SEstudiante",
	        data: cadena,
	  	    type: 'post',
	  	  	success: function(data){
	  	  		document.location.href="index.jsp?portal=10&idcita=<%=cc.getIdcita() %>&a=especifico_calendar";
	  	  		
	        }
	    });
}
$(function() {
	<%
	ArrayList<CCita> list=new ArrayList<CCita>();
	if(pac!=null) list=dbo.ListCitasEstudiante2(pac.getIdpaciente());
	if(pac==null || list.size()>0){%>
	$( "#carne3" ).focus();
	<%
	}else{%>
		$("#examen_realizado").focus();
	<%}%>
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
function examen_realizado(){
	cadena = [ 'a=estu_examen_rea','idcita='+<%=cc.getIdcita() %>].join('&');
	 
	 $.ajax({
	        url: "../SCita",
	        data: cadena,
	  	    type: 'post',
	  	  	dataType: 'json',
	  	  	success: function(data){
	  	  		if(data.resultado=='OK'){
			  	  		$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()} ]});
						  $('#estudiantes').flexReload();
						  alert("Almacenado");
						  $( "#carne3" ).val("");
						  $( "#carne3" ).focus();
	  	  		}else if(data.resultado=='ERROR'){
	  	  			alert("Seleccione un estudiante");
	  	  		$( "#carne3" ).val("");
				  $( "#carne3" ).focus();
	  	  		}else if(data.resultado=='NO EXISTE'){
		  	  		if(confirm('No tiene cita asignada, desea asignarlo?')){
		  	  		cadena = [ 'a=new_cita_pac','idcita=<%= idcita%>'].join('&');	
		  	  		$.ajax({
		  		        url: "../SCita",
		  		        data: cadena,
		  		  	    type: 'post',
		  		  	  	dataType: 'json',
		  		  	  	success: function(data){
		  		  	  	$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()} ]});
						  $('#estudiantes').flexReload();
						  $( "#carne3" ).val("");
						  $( "#carne3" ).focus();
		  		        }
		  		    });	  			
		  	  		}
	  	  		}
	        }
	    });
}
function CambiarEstado(){
	$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()} ]});
	  $('#estudiantes').flexReload();
}
$(document).ready(function () {
    $("#estudiantes").flexigrid
		({
			method: 'POST',
			url: '../SCitaTable',
			dataType : 'xml',
		    colModel: [
			{ display: 'Carne', name: 'carne', width: 60, sortable: true, align: 'left' },
			{ display: 'Nombre', name: 'nombre', width: 140, sortable: true, align: 'left' },
			{ display: 'Apellido', name: 'apellido', width: 140, sortable: true, align: 'left' },
			{ display: 'Unidad Academica', name: 'unidad', width: 170, sortable: true, align: 'left' },
			
			{ display: 'Estado', name: 'estado', width: 60, sortable: true, align: 'left' },
			{ display: 'Movil', name: 'telefono', width: 65, sortable: true, align: 'left' },
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
			params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()}]
		});
   		//$('.pSearch').click();
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
	  	  		$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()} ]});
				  $('#estudiantes').flexReload();
	  	  		}else{
	  	  			alert("No ahi cupo disponible");
	  	  		$('#estudiantes').flexOptions({params : [{name: 'a',value:'lista_estudiantes'},{name: 'idcita', value: <%= idcita%>},{name: 'estado', value:$("#tipo_cita").val()} ]});
				  $('#estudiantes').flexReload();
	  	  		}
	        }
	    });
}
function EnviarPorCarne(carne){
	cadena = [ 'a=estudiante_consulta','carne='+carne,].join('&');
	 $.ajax({
	        url: "../SEstudiante",
	        data: cadena,
	  	    type: 'post',
	  	  	success: function(data){
	  	  		document.location.href="index.jsp?portal=3";
	  	  		
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
