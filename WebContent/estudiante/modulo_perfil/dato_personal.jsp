	<form id="MainForm" name="MainForm" action="../SDatoPersonal" method="post">
<script>
	$(function() {
		$( ".radio" ).buttonset();
	});
</script>
<div class="button-sig">
<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Siguiente"/> 

</div>
<div style="float:left;">
<H2>PASO 1</H2>
</div>
<div id="cont_dato_personal">
<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Datos Personales</h3>
				
				
				<table  align="center" width="90%" CELLSPACING="8">
									<tr  >
										<td class="titulo_tabla">Nombre</td><td><label> Aura Luz Cifuentes Reyes </label></td>
									</tr>
									<tr >
										<td class="titulo_tabla">Fecha de Nacimiento</td><td><label> 1 de Diciembre del 1987 </label></td>
									</tr>
									<tr >
										<td class="titulo_tabla">Sexo</td><td><label> Femenino </label></td>
									</tr>
									<tr >
										<td class="titulo_tabla">Estado Civil</td><td><div class="radio">
																		<input type="radio" id="estado_1" name="radio" /><label for="estado_1">SOLTERO(A)</label>
																		<input type="radio" id="estado_2" name="radio" checked="checked" /><label for="estado_2">CASADO(A)</label>
																		<input type="radio" id="estado_3" name="radio" /><label for="estado_3">VIUDO(A)</label>
																		<input type="radio" id="estado_4" name="radio" /><label for="estado_4">DIVORSIADO(A)</label>
																		<input type="radio" id="estado_5" name="radio" /><label for="estado_5">UNIDO(A)</label>
																	</div>
															</td>
									</tr>
									<tr >
										<td class="titulo_tabla">Domicilio</td><td>
																<textarea  cols="50" rows="3" ></textarea> 
														  </td>
									</tr>
									<tr >
										<td class="titulo_tabla">Telefono casa</td><td><input type="text" size="20"/> </td>
									</tr>
									<tr >
										<td class="titulo_tabla">Telefono movil</td><td><input type="text" size="20"/>  </td>
									</tr>
									<tr >
										<td class="titulo_tabla">Correo electr&oacute;nico</td><td><input type="text" size="40"/>  </td>
									</tr>
									<tr >
										<td class="titulo_tabla">Tipo de Sangre</td><td>
										
																	<div class="radio">
																		<input type="radio" id="sangre_1" name="sangre" /><label for="sangre_1">A+</label>
																		<input type="radio" id="sangre_2" name="sangre" checked="checked" /><label for="sangre_2">B+</label>
																		<input type="radio" id="sangre_3" name="sangre" /><label for="sangre_3">O+</label>
																		<input type="radio" id="sangre_4" name="sangre" /><label for="sangre_4">A</label>
																		<input type="radio" id="sangre_5" name="sangre" /><label for="sangre_5">B</label>
																		<input type="radio" id="sangre_6" name="sangre" /><label for="sangre_6">O-</label>
																	</div>  
																</td>
									</tr>
									<tr >
										<td class="titulo_tabla">Titulo de secundaria</td>
																<td>
																	<select>
																	  <option value="volvo">SELECCIONE SU CARRERA</option>	
																	</select>
																</td>
									</tr>
									<tr >
										<td class="titulo_tabla">Crecio en</td><td><input type="text" size="20"/> <br/><span>Lugar</span></td>
									</tr>
</table>																		
</div>
<div id="dato_personal" class="ui-widget-content ui-corner-all">
<h3 class="ui-state-default ui-corner-all">Persona a notificar en Caso de Emergencia</h3>

						<table  align="center" width="90%" CELLSPACING="8">
									<tr  >
										<td class="titulo_tabla">Nombre</td><td><input type="text" size="20"/></td>
									</tr>
									<tr  >
										<td class="titulo_tabla">Parentesco</td>
										<td><select><option value="volvo">SELECCIONE SU PARENTESCO</option>	
											</select></td>
									</tr>
									<tr >
										<td class="titulo_tabla">Telefono casa</td><td><input type="text" size="20"/> </td>
									</tr>
									<tr >
										<td class="titulo_tabla">Telefono movil</td><td><input type="text" size="20"/>  </td>
									</tr>
						</table>									

</div>
</div>
<div class="button-sig">
<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Siguiente"/> 
</div>
	</form>