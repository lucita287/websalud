<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="framework.CDataExam" %>
<%@ page import="data.CConfiguracion" %>
<%@ page import="data.CUsuarioPermiso" %>
<%@page import="data.CCategoria" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Iterator" %>
<style>
.reporte{
border-style:solid;
border-width:2px;

}
.subreporte{
margin:0 auto 0 auto; width:510px;
}
</style>
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
</script>
        <%
        HttpSession sessiones=request.getSession(false); 
        
        if(sessiones!=null && sessiones.getAttribute("username")!=null&& sessiones.getAttribute("user_permiso")!=null){
        	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");
        if (user_permiso.getIdpermiso().indexOf(261)>-1  || user_permiso.getIdusuario().getidusuario()==1){       	
        	CDataExam dbo=new CDataExam();
        	if(dbo.Connect()){
        	CConfiguracion config2=dbo.getConfiguracion();
        	ArrayList<CCategoria> lista=dbo.getListaCategoria();
			Iterator<CCategoria> it=lista.iterator();
        %>
        <br/><br/><br/><br/>
        <center>
        <button class="breporte" onclick="Condiciones()">REPORTE CONDICIONES</button>
        <button class="breporte" onclick="Auto()">REPORTE PREGUNTAS AUTOEVALUACI&Oacute;N</button>
        <button class="breporte" onclick="Multi()">REPORTE PREGUNTAS MULTIFASICO</button>
        <button class="breporte" onclick="Inter()">REPORTE INTERPRETACIONES</button>
        </center>
        <br/>
 <div class="reporte" >
	<h3>ESTUDIANTES / TIPO DE EXAMEN</h3>
	<div class="subreporte">
	Ciclo: <input id="ciclo" type="text" size="10" value="<%= config2.getCiclo() %>" /> <br>
	Fecha Inicio: <input type="text"  id="Init_date" readonly="readonly"  class="datepicker" size="12"/>
	Fecha Fin: <input type="text" id="End_date" readonly="readonly"  class="datepicker" size="12"/><br>
	</div>
	<div style="float:right">
		<button  onclick="estudiante_tipo_examen()" class="breporte" >EXCEL</button>
	</div>
	<div style="clear: both;"></div>
</div>
 <div class="reporte" >
	<h3>ESTUDIANTES / INTERPRETACI&Oacute;N AUTOEVALUACIÓN POR CATEGORIA</h3>
	<div class="subreporte">
	Ciclo: <input id="ciclo1" type="text" size="10" value="<%= config2.getCiclo() %>" /> <br>
	Fecha Inicio: <input type="text"  id="Init_date1" readonly="readonly"  class="datepicker" size="12"/>
	Fecha Fin: <input type="text" id="End_date1" readonly="readonly"  class="datepicker" size="12"/><br>
	</div>
	<div style="float:right">
		<button  onclick="estudiante_auto()" class="breporte" >EXCEL</button>
	</div>
	<div style="clear: both;"></div>
</div>
 <div class="reporte" >
	<h3>ESTUDIANTES / RESPUESTAS POR PREGUNTA</h3>
	<div class="subreporte">
	Ciclo: <input id="ciclo2" type="text" size="10" value="<%= config2.getCiclo() %>" /> <br>
	Fecha Inicio: <input type="text"  id="Init_date2" readonly="readonly"  class="datepicker" size="12"/>
	Fecha Fin: <input type="text" id="End_date2" readonly="readonly"  class="datepicker" size="12"/><br>
	Categoria <select id="categoria_condicion" name="categoria_condicion" onchange="cambiarCategoria()">
						<option value="0">SELECCIONE CATEGORIA</option>
						<% while(it.hasNext()){ 
							CCategoria cat=it.next();
							%>
						  <option value="<%=cat.getIdcategoria() %>"><%=cat.getDescripcion() %></option>
						
						<% } %>  
						</select><br/>
	Pregunta<select id="new-submenu" name="new-submenu">
						</select>					
	</div>
	<div style="float:right">
		<button  onclick="estudiante_preg()" class="breporte" >EXCEL</button>
	</div>
	<div style="clear: both;"></div>
</div>        
        
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
<script>

function cambiarCategoria(){
	 
	  cadena = [ 	'idcate='   + $("#categoria_condicion").val(),
	             	'a=showsubpreguntas',
		        ].join('&');

	 
	  $('#new-submenu').children().remove().end();
	  $.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	var array = eval(data.menus);
	        	for (var i = 0; i < array.length; i++)
	        	{
	        		 $('#new-submenu').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        	}
	        }
		
	       }); 
	  
}
		 $(function() {
				$( ".breporte" ).button();
			});
		 function estudiante_tipo_examen(){
			 $('#parameters1').val('fecha_inicio,fecha_fin,ciclo');
				$('#values1').val($("#Init_date").val()+'|'+$("#End_date").val()+'|'+$("#ciclo").val());
				$('#report1').val('Estudiantes');
				$('#report_name1').val('Estudiantes');
				$("#form_report1").submit();
		 }
		 function estudiante_preg(){
			 $('#parameters1').val('fecha_inicio,fecha_fin,ciclo,idpregunta');
				$('#values1').val($("#Init_date2").val()+'|'+$("#End_date2").val()+'|'+$("#ciclo2").val()+'|'+$("#new-submenu").val());
				$('#report1').val('Estudiante_pregunta');
				$('#report_name1').val('Estudiante_pregunta');
				$("#form_report1").submit();
		 }
		 function estudiante_auto(){
			 				
				 $('#parameters1').val('fecha_inicio,fecha_fin,ciclo');
					$('#values1').val($("#Init_date1").val()+'|'+$("#End_date1").val()+'|'+$("#ciclo1").val());
					$('#report1').val('Estudiante_categoria');
					$('#report_name1').val('Estudiante_categoria');
					$("#form_report1").submit();
		 }
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
	<%	} dbo.Close(); } }%>