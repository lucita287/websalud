<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataBase" %>
    <%@ page import="data.CUsuarioPermiso" %>
<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(255)>-1  || user_permiso.getIdusuario().getidusuario()==1){

%>
    
    
			<h2>CATEGORIZACI&Oacute;N SEG&Uacute;N CARNE</h2>
			<h2>PARA EL CICLO</h2>
			<style>
				.titulo { text-transform:uppercase; font-size:15px; }
			</style>
			<table>
				<tr>
					<td><div class="titulo">Carne que finalizan con 0</div></td>
						<td>
							<input type="radio" name="carne0" class="carne0" id="carne0auto" value="1" checked /><label for="carne0auto">AUTOEVALUACION</label>
							<input type="radio" name="carne0" class="carne0" id="carne0multi" value="2"  /><label for="carne0multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 1</div></td>
						<td>
							<input type="radio" name="carne1" class="carne1" id="carne1auto" value="1" checked /><label for="carne1auto">AUTOEVALUACION</label>
							<input type="radio" name="carne1" class="carne1" id="carne1multi" value="2"  /><label for="carne1multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 2</div></td>
						<td>
							<input type="radio" name="carne2" class="carne2" id="carne2auto" value="1" checked /><label for="carne2auto">AUTOEVALUACION</label>
							<input type="radio" name="carne2" class="carne2" id="carne2multi" value="2"  /><label for="carne2multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 3</div></td>
						<td>
							<input type="radio" name="carne3" class="carne3" id="carne3auto" value="1" checked /><label for="carne3auto">AUTOEVALUACION</label>
							<input type="radio" name="carne3" class="carne3" id="carne3multi" value="2"  /><label for="carne3multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 4</div></td>
						<td>
							<input type="radio" name="carne4" class="carne4" id="carne4auto" value="1" checked /><label for="carne4auto">AUTOEVALUACION</label>
							<input type="radio" name="carne4" class="carne4" id="carne4multi" value="2"  /><label for="carne4multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 5</div></td>
						<td>
							<input type="radio" name="carne5" class="carne5" id="carne5auto" value="1" checked /><label for="carne5auto">AUTOEVALUACION</label>
							<input type="radio" name="carne5" class="carne5" id="carne5multi" value="2"  /><label for="carne5multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 6</div></td>
						<td>
							<input type="radio" name="carne6" class="carne6" id="carne6auto" value="1" checked /><label for="carne6auto">AUTOEVALUACION</label>
							<input type="radio" name="carne6" class="carne6" id="carne6multi" value="2"  /><label for="carne6multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 7</div></td>
						<td>
							<input type="radio" name="carne7" class="carne7" id="carne7auto" value="1" checked /><label for="carne7auto">AUTOEVALUACION</label>
							<input type="radio" name="carne7" class="carne7" id="carne7multi" value="2"  /><label for="carne7multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 8</div></td>
						<td>
							<input type="radio" name="carne8" class="carne8" id="carne8auto" value="1" checked /><label for="carne8auto">AUTOEVALUACION</label>
							<input type="radio" name="carne8" class="carne8" id="carne8multi" value="2"  /><label for="carne8multi">MULTIFÁSICO</label>
						</td>
				</tr>
				<tr>	
					<td><div class="titulo">Carne que finalizan con 9</div></td>
						<td>
							<input type="radio" name="carne9" class="carne9" id="carne9auto" value="1" checked /><label for="carne9auto">AUTOEVALUACION</label>
							<input type="radio" name="carne9" class="carne9" id="carne9multi" value="2"  /><label for="carne9multi">MULTIFÁSICO</label>
						</td>
				</tr>
			</table>
								<div class="center_button">
													<a href="#" onclick="Guardar()" class="ui-state-default ui-corner-all buttonsave" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
													
								</div>
			
			<script>
					 $(function() {
							$( ".carne0" ).button();
							$( ".carne1" ).button();
							$( ".carne2" ).button();
							$( ".carne3" ).button();
							$( ".carne4" ).button();
							$( ".carne5" ).button();
							$( ".carne6" ).button();
							$( ".carne7" ).button();
							$( ".carne8" ).button();
							$( ".carne9" ).button();
							$(".buttonsave").button();
						});
					 function Guardar(){
						 cadena = ['carne0='   +$("input[@name='carne0']:checked").val(),
							          'carne1='+ $("input[@name='carne1']:checked").val(),
							          'carne2='+$("input[@name='carne2']:checked").val(),
							          'carne3='+$("input[@name='carne3']:checked").val(),
							          'carne4='+$("input[@name='carne4']:checked").val(),
							          'carne5='+$("input[@name='carne5']:checked").val(),
							          'carne6='+$("input[@name='carne6']:checked").val(),
							          'carne7='+$("input[@name='carne7']:checked").val(),
							          'carne8='+$("input[@name='carne8']:checked").val(),
							          'carne9='+$("input[@name='carne9']:checked").val(),
							          'a=GuardarCarne',
							        ].join('&');
							$.ajax({
						        url: "../SConfiguracion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        }
						    });
						 
					 }
			</script>	
<%		}	} %>	