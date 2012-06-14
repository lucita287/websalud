		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 		<%@ page import="data.CUsuarioPermiso" %>
        <%
        HttpSession sessiones=request.getSession(false); 
        
        if(sessiones!=null && sessiones.getAttribute("username")!=null&& sessiones.getAttribute("user_permiso")!=null){
        	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
        if (user_permiso.getIdpermiso().indexOf(261)>-1  || user_permiso.getIdusuario().getidusuario()==1){       	
        %>
        <br/><br/><br/><br/>
        <center>
        <button class="reporte" onclick="Condiciones()">REPORTE CONDICIONES</button>
        <button class="reporte" onclick="Auto()">REPORTE PREGUNTAS AUTOEVALUACI&Oacute;N</button>
        <button class="reporte" onclick="Multi()">REPORTE PREGUNTAS MULTIFASICO</button>
        <button class="reporte" onclick="Inter()">REPORTE INTERPRETACIONES</button>
        </center>
<form id="form_report" name="form_report" action="../SGen_PDF" method="post" target="_blank">
  	<input type="hidden" name="report" id="report" value="" />
  	<input type="hidden" name="report_name" id="report_name" value="" />
  	<input type="hidden" name="parameters" id="parameters" value="" />
  	<input type="hidden" name="values" id="values" value="" />
  </form>
<script>
		 $(function() {
				$( ".reporte" ).button();
			});
		 function Condiciones(){
			 $('#parameters').val('');
				$('#values').val('');
				$('#report').val('Condiciones');
				$('#report_name').val('Condiciones');
				$("#form_report").submit();
		 }
		 function Auto(){
			 $('#parameters').val('auto,multi');
				$('#values').val('1|0');
				$('#report').val('MPreguntas');
				$('#report_name').val('MPreguntas');
				$("#form_report").submit();
		 }
		 function Multi(){
			 $('#parameters').val('auto,multi');
				$('#values').val('0|1');
				$('#report').val('MPreguntas');
				$('#report_name').val('MPreguntas');
				$("#form_report").submit();
		 }
		 function Inter(){
			 $('#parameters').val('');
				$('#values').val('');
				$('#report').val('Interpretacion');
				$('#report_name').val('Interpretacion');
				$("#form_report").submit();			 
		 }
</script>		 
	<% } }%>