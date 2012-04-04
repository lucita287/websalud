<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
 <%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
    <%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
    <%@ page import="framework.CValidation" %>
    <%@ page import="framework.CDataExam" %>
    <%@ page import="data.CCentro_Regional" %>
    <%@ page import="data.CUnidad_Academica" %>
    <%@ page import="data.CCarrera" %>
    <%@ page import="data.CDependencia" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.Iterator" %>
<%
		CValidation valid=new CValidation();
		int idregistro=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idregistro")));		
		CDataExam	data=new CDataExam();
		data.Connect();
%>

    <script  type="text/javascript">
    function cambiarCentro(){ 
		  if($("#centro_registro").val()=="A"){
			  	$("#oculto_centro_registro").show();
		  }else{
			  $("#oculto_centro_registro").hide();
		  }
    }	
    function cambiarFacultad(){
    	if($("#facultad").val()=="A"){
		  	$("#oculto_facultad").show();
	  }else{
		  $("#oculto_facultad").hide();
	  }
    }
    
    function cambiarCarrera(){
    	if($("#carrera").val()=="A"){
		  	$("#oculto_carrera").show();
		  }else{
			  $("#oculto_carrera").hide();
		  }  
	  }
    function CambiarDependencia(){
    	if($("#dependencia").val()=="A"){
		  	$("#oculto_dependencia").show();
		  }else{
			  $("#oculto_dependencia").hide();
		  }
    }
			  $(document).ready(function () {
				  $("#oculto_centro_registro").hide();
				  $("#oculto_facultad").hide();
				  $("#oculto_carrera").hide();
				  $("#oculto_dependencia").hide();
				  
				  $( ".info-btt" ).button({
			            icons: {
			                primary: "ui-icon-info"
			            }});
				  // validate signup form on keyup and submit
					$("#registro").validate({
						rules: {
							username: {
								required: true,
								minlength: 4
							},
							password: {
								password: "#username"
							},
							password_confirm: {
								required: true,
								equalTo: "#password"
							}
						},
						messages: {
							username: {
								required: "Ingrese su usuario",
								minlength: jQuery.format("Ingrese almenos {0} caracteres")
							},
							password_confirm: {
								required: "Repita su password",
								minlength: jQuery.format("Ingrese almenos {0} caracteres"),
								equalTo: "Ingrese el mismo password "
							}
						}
					});

			  	});	  
			  
			
			  
			  
			  function disponibilidad(){
				  cadena = [ 'a=user_disponibilidad',
					         'user='     + $("#username").val(),
					        ].join('&');
				  $.ajax({
				        url: "SPaciente",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	$("#disp_usuario").text(data.mensaje);
				        }
				    });
			  }
			  
			  
	</script>
	<form class="cmxform" id="registro" method="post" action="">
	<div class="registro_user">
	<% if(idregistro==2||idregistro==4){ 
		ArrayList<CCentro_Regional> centro=data.getListaCentro_Regional();
		ArrayList<CUnidad_Academica> facultad=data.getListaUnidad_Academica();
		ArrayList<CCarrera> carrera=data.getListaCarrera();
	%>
			<h3 class="ui-widget-header ui-corner-all">Estatus del Estudiante</h3>
		<div class="tabla">
						<div class="fila">
									<div class="col_titulo">Carne</div>
									<div class="col"><input type="text" id="carne" name="carne" class="required" minlength="7" size="20"></div>
						</div>
						<div class="fila">
									<div class="col_titulo">Centro Universitario</div>
									<div class="col">
										<select id="centro_registro" onchange="cambiarCentro()" name="centro_registro" >
												<option value="0">SELECCIONE SU CENTRO UNIVERSITARIO</option>
										<%
										Iterator<CCentro_Regional> it=centro.iterator();
										while (it.hasNext()) {
											CCentro_Regional cen=it.next();
												out.println("<option value=\""+cen.getIdcentro_regional()+"\">"+cen.getNombre()+"</option>");
										    }
											%>			
												<option value="A">OTRO</option>	
										</select>
										
									</div>
						</div>
			<div id="oculto_centro_registro">
					<div class="fila">
									<div class="col_titulo">Ingrese su Centro Regional</div>
									<div class="col">
										<input type="text" id="nombre_centro_registro" />
									</div>
						</div>
			</div>			
						<div class="fila">
									<div class="col_titulo">Facultad</div>
									<div class="col">
										<select id="facultad" onchange="cambiarFacultad()">
												<option value="0">SELECCIONE SU FACULTAD</option>	
												<%
										Iterator<CUnidad_Academica> it2=facultad.iterator();
										while (it2.hasNext()) {
											CUnidad_Academica fac=it2.next();
												out.println("<option value=\""+fac.getIdunidad_academica()+"\">"+fac.getNombre()+"</option>");
										    }
											%>			
												<option value="A">OTRO</option>
										</select>
									</div>
						</div>
			<div id="oculto_facultad">
					<div class="fila">
									<div class="col_titulo">Ingrese su Facultad</div>
									<div class="col">
										<input type="text" id="nombre_facultad" />
									</div>
						</div>
			</div>			
						<div class="fila">
									<div class="col_titulo">Carrera</div>
									<div class="col">
										<select id="carrera" onchange="cambiarCarrera()">
												<option value="0">SELECCIONE SU CARRERA</option>	
												<%
													Iterator<CCarrera> it3=carrera.iterator();
													while (it3.hasNext()) {
														CCarrera car=it3.next();
															out.println("<option value=\""+car.getIdcarrera()+"\">"+car.getNombre()+"</option>");
													    }
												%>
												<option value="A">OTRO</option>
										</select>
									</div>
						</div>
			<div id="oculto_carrera">
					<div class="fila">
									<div class="col_titulo">Ingrese su Carrera</div>
									<div class="col">
										<input type="text" id="nombre_carrera" />
									</div>
						</div>
			</div>			
		</div>												
		
	
	<% } %>
	<div style="clear: both;"></div>
	<% if(idregistro==3||idregistro==4){ 
		ArrayList<CDependencia> lista_dep=data.getListaDependencia();
	%>
		<h3 class="ui-widget-header ui-corner-all">Estatus del Trabajador</h3>
		
			<div class="tabla">
						<div class="fila">
									<div class="col_titulo">No Personal</div>
									<div class="col">
										<input type="text" id="no_personal" name="no_personal" minlength="3" class="required" size="20">
									</div>
						</div>
						<div class="fila">			
									<div class="col_titulo">Dependencia</div>
									<div class="col">
										<select id="dependencia" onchange="CambiarDependencia()">
												<option value="0">SELECCIONE LA DEPENDENC&Iacute;A</option>	
												<%
													Iterator<CDependencia> it4=lista_dep.iterator();
													while (it4.hasNext()) {
														CDependencia car=it4.next();
															out.println("<option value=\""+car.getIddependencia()+"\">"+car.getNombre()+"</option>");
													    }
												%>
												<option value="A">OTRO</option>
										</select>
									</div>
						</div>
						<div id="oculto_dependencia">
								<div class="fila">
												<div class="col_titulo">Ingrese su dependencia</div>
												<div class="col">
													<input type="text" id="nombre_dependencia" />
												</div>
									</div>
						</div>
			</div>
		<div style="clear: both;"></div>															
	<% }%>	
<h3 class="ui-widget-header ui-corner-all">Datos Personales</h3>
	<div class="tabla">
						<div class="fila">
									<div class="col_titulo">Usuario</div>
									<div class="col">
										<input type="text" id="username" name="username" class="required" minlength="2" size="20"/>
										<a onclick="disponibilidad()" class="info-btt">Comprobar disponibilidad</a><br/>
										<label id="disp_usuario"></label>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Password</div>
									<div class="col">
										<input type="password" autocomplete="off" class="password" name="password" id="password" />
										<div class="password-meter">
											<div class="password-meter-message">&nbsp;</div>
											<div class="password-meter-bg">
												<div class="password-meter-bar"></div>
											</div>
										</div>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Confirmar Password </div>
									<div class="col"> <input type="password" id="password_confirm" name="password_confirm"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">Nombre Completo</div>
									<div class="col">
									<input type="text" id="nombre_usuario" name="nombre_usuario" class="required"  size="70"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Telefono</div>
									<div class="col">
									<input type="text" id="tel_usuario" name="nombre_usuario"   size="30"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Telefono Movil</div>
									<div class="col">
									<input type="text" id="movil_usuario" name="nombre_usuario"  size="30"/>
									</div>
						</div>
						
						<div class="fila">
									<div class="col_titulo">Fecha de Nacimiento</div>
									<div class="col"><input type="text" id="datepicker" name="datepicker" class="required" size="10"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">Sexo</div>
									<div class="col">
									<div class="genero">
										<input type="radio" id="genero_1" name="genero" /><label for="genero_1">MASCULINO</label>
										<input type="radio" id="genero_2" name="genero" checked="checked" /><label for="genero_2">FEMENINO</label>
									</div>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Correo Electronico</div>
									<div class="col"><input type="text" id="correo_electronico" name="correo_electronico"  class="required email" size="50"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">Ingrese el texto</div>
									<div class="col">
										 <% ReCaptcha c = ReCaptchaFactory.newReCaptcha("6Lf9as8SAAAAAOvbB8V_Xj1KaI3vFPaYAlsgYFoq", "6Lf9as8SAAAAAI5FO_4qetoWZv4D_8nRFDSsbp5P", false);
									          out.print(c.createRecaptchaHtml(null, null));			
									        %>									
									</div>
						</div>
	</div>					



	
	<div style="clear: both;"></div>
	<div class="bt_registrarse">
	<input class="ui-state-default ui-corner-all button" type="submit" value="Registrarse"/>
	</div>
	</div>
	</form>
	<% data.Close();	 %>