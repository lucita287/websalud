<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 <%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
    <%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<div id="registro_usuarios" class="ui-widget-content ui-corner-all">
<div id="registro_titulo" >
<h2>REGISTRARSE</h2>		
</div>
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNAR A LA UNIDAD DE SALUD</a>  

</div>
<div style="clear: both;"></div>


<div id="div_button_registro">
	<button onclick="Registro()" id="bt_est_registro" class="button_registro">Estudiante de la Universidad de San Carlos de Guatemala</button>
	<button class="button_registro" onclick="registrarse_trabajador()" id="bt_tra_registro">Trabajador de la Universidad de San Carlos de Guatemala</button>
	<button class="button_registro" onclick="registrarse_est_traba()" id="bt_tra_registro">Estudiante y Trabajador de la Universidad de San Carlos de Guatemala</button>
	<button  class="button_registro" onclick="cortesia()" id="bt_tra_registro">Cortesia</button>
</div>	
	
	
	<div id="registro_estudiante">
			<h3 class="ui-widget-header ui-corner-all">Estatus del Estudiante</h3>
	<div class="bt_registrarse">
	</div>
		<table>
			<tr>
				<td>
					Carne
				</td>
				<td>
					<input type="text" size="20">
				</td>
			</tr>
			<tr>
				<td>
					Centro Universitario
				</td>
				<td>
					<select>
							<option value="volvo">SELECCIONE SU CENTRO UNIVERSITARIO</option>	
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Facultad
				</td>
				<td>
					<select>
							<option value="volvo">SELECCIONE SU FACULTAD</option>	
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Carrera
				</td>
				<td>
					<select>
							<option value="volvo">SELECCIONE SU CARRERA</option>	
					</select>
				</td>
			</tr>
		</table>
	
	
	<div style="clear: both;"></div>
	</div>
	
		<div id="registro_trabajadores">
		<h3 class="ui-widget-header ui-corner-all">Estatus del Trabajador</h3>	
													<div class="bt_registrarse">

													</div>	
													<table>
														<tr>
															<td>
																No Personal
															</td>
															<td>
																<input type="text" size="20">
															</td>
														</tr>
														<tr>
															<td>
																Dependencia
															</td>
															<td>
																<select>
																		<option value="volvo">SELECCIONE LA DEPENDENC&Iacute;A</option>	
																</select>
															</td>
														</tr>
													</table>									
													
		</div>
<div id="datos_personales">	
<h3 class="ui-widget-header ui-corner-all">Datos Personales</h3>
	<table>
		<tr>
			<td>Usuario</td><td><input type="text" size="20"/></td>
		</tr>
		<tr>
			<td>Nombre Completo</td><td><input type="text" size="70"/></td>
		</tr>
		<tr>
			<td>Fecha de Nacimiento</td><td><input type="text" id="datepicker" size="10"/></td>
		</tr>
		<tr>
			<td>Sexo</td><td><div class="genero">
										<input type="radio" id="genero_1" name="genero" /><label for="genero_1">MASCULINO</label>
										<input type="radio" id="genero_2" name="genero" checked="checked" /><label for="genero_2">FEMENINO</label>
							</div>											
						</td>
		</tr>
		<tr>
			<td>Correo Electronico</td><td><input type="text" size="50"/></td>
		</tr>
	</table>


	 <%
          ReCaptcha c = ReCaptchaFactory.newReCaptcha("6Lf9as8SAAAAAOvbB8V_Xj1KaI3vFPaYAlsgYFoq", "6Lf9as8SAAAAAI5FO_4qetoWZv4D_8nRFDSsbp5P", false);
          out.print(c.createRecaptchaHtml(null, null));
        %>
	
	<div style="clear: both;"></div>
	<div class="bt_registrarse">
	<input class="ui-state-default ui-corner-all button" type="submit" value="Registrarse"/>
	</div>
</div>	
	<div style="clear: both;"></div>
</div>    
<script>
$(function() {
	$( "#datepicker" ).datepicker({
		changeMonth: true,
		changeYear: true
	});
	$("#datepicker").mask("99/99/9999");
	$( "#datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
});
function Registro(){
	 $("#registro_estudiante").show();
	 $("#datos_personales").show();
	 $("#div_button_registro").hide();
}
function registrarse_trabajador(){
	$("#registro_trabajadores").show();
	$("#datos_personales").show();
	$("#div_button_registro").hide();
}
function registrarse_est_traba(){
	$("#registro_trabajadores").show();
	$("#datos_personales").show();
	$("#registro_trabajadores").show();
	$("#div_button_registro").hide();
}
function cortesia(){
	$("#datos_personales").show();
	$("#div_button_registro").hide();
}
$(document).ready(function () {
	  $( ".button_registro" ).button({
          icons: {
              primary: "ui-icon ui-icon-circle-plus"
          }});
		$(function() {
			$( ".genero" ).buttonset();
		});
	 $("#registro_estudiante").hide();	
	 $("#registro_trabajadores").hide();
	 $("#datos_personales").hide();
});

</script>