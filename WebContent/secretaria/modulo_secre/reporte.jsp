<%@page import="framework.CDataExam" %>
<%@ page import="data.CConfiguracion" %>
<%
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){

%>
<style>
.reporte{
border-style:solid;
border-width:2px;

}
.subreporte{
margin:0 auto 0 auto; width:510px;
}
</style>
<%
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
CConfiguracion config2=dbo.getConfiguracion();
%>
<H2>Reportes Fechas</H2>
<div class="reporte" >
	<h3>Facultades por rango de fechas</h3>
	<div class="subreporte">
	Ciclo: <input id="ciclo" type="text" size="10" value="<%= config2.getCiclo() %>" /> 
	Tipo Examen <select id="tipo_examen" > 
					<option value="1,2">TODOS</option>
					<option value="1">AUTOEVALUCION</option>
					<option value="2">MULTIFASICO</option>
					
				 </select><br>
	Fecha Inicio: <input type="text"  id="Init_date" readonly="readonly"  class="datepicker" size="12"/>
	Fecha Fin: <input type="text" id="End_date" readonly="readonly"  class="datepicker" size="12"/><br>
	Estado:<select id="estado">
				<option value="1,2,3,0" SELECTED>TODOS</option>
				<option value="1">CITA NO CONFIRMADA</option>
				<option value="2">CAMBIO DE CITA</option>
				<option value="3">CITA CONFIRMADA</option>
				<option value="0">NO SE PRESENTO</option>
				<option value="1,3">CITA NO CONFIRMADA, CITA CONFIRMADA</option>
				<option value="2,0">CAMBIO DE CITA, NO SE PRESENTO</option>
			</select>
	</div>
	<div style="float:right">
		<button class="button-save" onclick="pdf_facultad()" >PDF</button>
		<button class="button-save" onclick="excel_facultad()" >EXCEL</button>
	</div>
	<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>
<div class="reporte" >
	<h3>Estudiantes por rango de fechas</h3>
	<div class="subreporte">
	Ciclo: <input id="ciclo1" type="text" size="10" value="<%= config2.getCiclo() %>" > 
	Tipo Examen <select id="tipo_examen1"> 
					<option value="1,2">TODOS</option>
					<option value="1">AUTOEVALUCION</option>
					<option value="2">MULTIFASICO</option>
					
				 </select><br>
	Fecha Inicio: <input id="Init_date1" type="text" readonly="readonly"  class="datepicker" size="12">
	Fecha Fin: <input id="End_date1" type="text" readonly="readonly"  class="datepicker" size="12"><br>
	Estado:<select id="estado1">
				<option value="1,2,3,0" SELECTED>TODOS</option>
				<option value="1">CITA NO CONFIRMADA</option>
				<option value="2">CAMBIO DE CITA</option>
				<option value="3">CITA CONFIRMADA</option>
				<option value="0">NO SE PRESENTO</option>
				<option value="1,3">CITA NO CONFIRMADA, CITA CONFIRMADA</option>
				<option value="2,0">CAMBIO DE CITA, NO SE PRESENTO</option>
			</select>
	</div>
	
	<div style="float:right">
		<button onclick="excel_estudiantes()" class="button-save">EXCEL</button>
	</div>
	<div style="clear: both;"></div>
</div>

<script>
$(function() {
	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "../images/calendar.gif",
		buttonImageOnly: true
	});
  	$(".datepicker").mask("9999-99-99");
	$( ".datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd");
	

});
function pdf_facultad(){
	$('#parameters').val('Init_date,End_date,tipo_examen,ciclo,estado');
	$('#values').val($("#Init_date").val()+'|'+$("#End_date").val()+'|'+$("#tipo_examen").val()+'|'+$("#ciclo").val()+'|'+$("#estado").val());
	$('#report').val('Estudiantes_Facultad');
	$('#report_name').val('Estudiantes_Facultad');
	$("#form_report").submit();
	
}
function excel_facultad(){
	$('#parameters1').val('Init_date,End_date,tipo_examen,ciclo,estado');
	$('#values1').val($("#Init_date").val()+'|'+$("#End_date").val()+'|'+$("#tipo_examen").val()+'|'+$("#ciclo").val()+'|'+$("#estado").val());
	$('#report1').val('Estudiantes_Facultad');
	$('#report_name1').val('Estudiantes_Facultad');
	$("#form_report1").submit();
	
}
function excel_estudiantes(){
	$('#parameters1').val('Init_date,End_date,tipo_examen,ciclo,estado');
	$('#values1').val($("#Init_date1").val()+'|'+$("#End_date1").val()+'|'+$("#tipo_examen1").val()+'|'+$("#ciclo1").val()+'|'+$("#estado1").val());
	$('#report1').val('Estudiante_Fecha');
	$('#report_name1').val('Estudiante_Fecha');
	$("#form_report1").submit();
	
}
</script>
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
<% 
	dbo.Close();
}	} %>
