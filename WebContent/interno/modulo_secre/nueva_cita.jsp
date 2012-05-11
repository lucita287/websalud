<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
  <script>
  $(function() {
		$( ".semana" ).button();
		$( ".button-save" ).button();
	  	$(".time").mask("99:99");
	  	$( ".datepicker" ).datepicker();
	  	$(".datepicker").mask("99/99/9999");
		$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
		

	});
	function GuardarRango(){
		  cadena = [ 'a=guardar_rango',
			            'fecha_inicio='+$("#r_fecha_inicio").val(),
			            'cupo='+$("#r_cupo").val(),
			            'tipo_examen='+$("#r_tipo_examen").val(),
			            'fecha_fin='+$("#r_fecha_fin").val(),
			            'hora_inicio='+$("#r_hora_inicio").val(),
			            'hora_fin='+$("#r_hora_fin").val(),
			            'estado='+$("#r_estado").val(),
			            'lunes='+(($("#lunes").is(":checked")==true)?1:0),
			            'martes='+(($("#martes").is(":checked")==true)?1:0),
			            'miercoles='+(($("#miercoles").is(":checked")==true)?1:0),
			            'jueves='+(($("#jueves").is(":checked")==true)?1:0),
			            'viernes='+(($("#viernes").is(":checked")==true)?1:0),
			            'sabado='+(($("#sabado").is(":checked")==true)?1:0),
			            'domingo='+(($("#domingo").is(":checked")==true)?1:0),
			        ].join('&');
		  $.ajax({
		        url: "../SCita",
		        data: cadena,
		  	    type: 'post',
		        dataType: 'json',
		        success: function(data){
		        	if(data.resultado=='OK'){
		        		mensaje2(data.mensaje);
		        		
		        		
		        	}else{
		        		mensaje3(data.mensaje);
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
						<h5>PERIODOS DE FECHAS</h5>
								<table>	
									<tr>
										<td>Fecha Inicio</td>
										<td><input type="text" id="r_fecha_inicio" size="10" class="datepicker"/></td>
										<td>Fecha Fin</td>
										<td><input type="text" id="r_fecha_fin" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" id="r_hora_inicio" type="text" class="time"/> 
											
										</td>
										<td>Hora Fin</td>
										<td><input size="10" id="r_hora_fin" type="text" class="time"/> 
											
										</td>
									</tr>	
									<tr>	
										<td>Cupo</td>
										<td><input size="10" id="r_cupo" type="text" /></td>
									</tr>
									<tr>
										<td>Tipo de Examen</td>
										<td><select id="r_tipo_examen">
											<option value="0">SELECCIONE EXAMEN</option>
											<option value="1">AutoEvaluacion</option>
											<option value="2">Multifásico</option>
											</select>
										</td>
										<td>Estado</td>
										<td>
											<select id="r_estado">
											<option value="1">HABILITADAS</option>
											<option value="2">HABILITADAS EN LINEA</option>
											<option value="0">DESHABILITADAS</option>
											</select>
										</td>
									
									</tr>
									<tr>
										<td colspan="4">
											<div style="font-size: 12px;">	
												<input type="checkbox" id="lunes"  class="semana" value="1">
												<label for="lunes">LUNES</label> 
												<input type="checkbox" id="martes" class="semana" value="1"> 
												<label for="martes">MARTES</label> 
												<input type="checkbox" id="miercoles" class="semana" value="1">
												<label for="miercoles">MIERCOLES</label>
												<input type="checkbox" id="jueves" class="semana" value="1">
												<label for="jueves">JUEVES</label>
												<input type="checkbox" id="viernes" class="semana" value="1">
												<label for="viernes">VIERNES</label>
												<input type="checkbox" id="sabado" class="semana" value="1">
												<label for="sabado">SABADO</label>
												<input type="checkbox" id="domingo" class="semana" value="1">
												<label for="domingo">DOMINGO</label>
											</div>	
										</td>
									</tr>
									
									
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarRango()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
						
			