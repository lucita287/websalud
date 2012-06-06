<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
  <script>
  $(function() {
		$( ".semana" ).button();
		$( ".button-save" ).button();
	  $( ".datepicker" ).datepicker();
		$(".time").mask("99:99");
		$(".datepicker").mask("99/99/9999");
		$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
	});
	function GuardarEspecifico(){
		  cadena = [ 'a=guardarespecifico',
			            'fecha='+$("#r_fecha1").val(),
			            'hora_inicio='+$("#r_hora_inicio1").val(),
			            'hora_fin='+$("#r_hora_fin1").val(),
			            'tipo_examen='+$("#r_tipo_examen1").val(),
			            'cupo='+$("#r_cupo1").val(),
			            'estado='+$("#r_estado1").val(),
			        ].join('&');
		  $.ajax({
		        url: "../SCita",
		        data: cadena,
		  	    type: 'post',
		        dataType: 'json',
		        success: function(data){
		        	
		        	if(data.resultado=='OK'){
		        		mensaje2(data.mensaje);
		        		limpiar_cita();
		        		$( "#dialog-form" ).dialog( "close" );
		        		document.location.href="index.jsp?portal=2&mes="+$("#mes").val()+"&exam="+$("input[@name='exam']:checked").val()+"&anio="+$("#anio").val();
		        	}else{
		        		mensaje(data.mensaje);
		        	}
		        }
		    });
	  }
	
  </script>
  <div style="float:left;">
  <h2>NUEVA CITA</h2>
  </div>
  <div style="float:right;">			
			<a  class="ui-state-default ui-corner-all button-save" onclick="Cancelar()"> <img  width="24px"  height="24px" src="../images/delete.png" />Cancelar</a>
			</div>
<div style="clear: both;"></div>			
  
						<div class="ui-widget-content ui-corner-all caja_gris">
						<h5>FECHA ESPECIFICA</h5>
								<table>	
									<tr>
										<td>Fecha</td>
										<td><input type="text" id="r_fecha1" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" id="r_hora_inicio1" type="text" class="time"/> 
											
										</td>
										<td>Hora Fin</td>
										<td><input size="10" id="r_hora_fin1" type="text" class="time"/> 
										</td>
									</tr>	
										
									<tr>	
										<td>Cupo</td>
										<td><input size="10" id="r_cupo1" type="text" /></td>
										<td>Tipo de Examen</td>
										<td><select id="r_tipo_examen1">
											<option value="0">SELECCIONE EXAMEN</option>
											<option value="1">AutoEvaluacion</option>
											<option value="2">Multifásico</option>
											</select>
										</td>
									</tr>
									<tr>	
										<td>Estado</td>
										<td>
											<select id="r_estado1">
											<option value="1">HABILITADAS</option>
											<option value="2">HABILITADAS EN LINEA</option>
											<option value="0">DESHABILITADAS</option>
											</select>
										</td>
									</tr>
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarEspecifico()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
			