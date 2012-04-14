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
    <%@ page import="data.CParentesco" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.Iterator" %>
<%
		CValidation valid=new CValidation();
		int idregistro=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idregistro")));		
		CDataExam	data=new CDataExam();
		data.Connect();
		ArrayList<CParentesco> lista_paren=data.getListaParentesco(0,1,0);
		String a="";
		if(idregistro==4)
			a="guardarpaciente";
		else if(idregistro==3)
			a="guardartrabajador";
		else if(idregistro==2)
			a="guardarestudiante";
		else if(idregistro==1)
			a="guardarcortesia";
%>

    <script  type="text/javascript">
			  $(document).ready(function () {
				  
				  $( ".info-btt" ).button({
			            icons: {
			                primary: "ui-icon-info"
			            }});
				  // validate signup form on keyup and submit
					$("#registro").validate({
						rules: {
							<% if(idregistro==2||idregistro==4){ %>	
							carne: {
								required: true,
								minlength: 7,
								number: true
							},
							centro_registro: {
								min:1,
								required: true
							},
							facultad: {
								min:1,
								required: true
							},
							carrera: {
								min:1,
								required: true
							},
							<% } if(idregistro==3||idregistro==4){%>
							dependencia: {
								min:1
							},
							no_personal:{
								required: true,
								minlength: 3,
								number: true
							},
							<% } %>
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
							<% if(idregistro==2||idregistro==4){ %>	
							centro_registro: {
								min:"Seleccione un centro regional"
							},
							facultad: {
								min:"Seleccione una facultad"
							},
							carrera: {
								min:"Seleccione una carrera"
							},
							<% } if(idregistro==3||idregistro==4){%>
							dependencia: {
								min:"Seleccione su Dependencia",
								required: true
							},
							<% } %>
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
	<form class="cmxform" id="registro" method="post" action="SPaciente" accept-charset="UTF-8">
	<input type="hidden" id="a" name="a" value="<%=a %>" />
	<div class="registro_user"> 
	<% if(idregistro==2||idregistro==4){ 
		ArrayList<CCentro_Regional> centro=data.getListaCentro_Regional();
		ArrayList<CUnidad_Academica> facultad=data.getListaUnidad_Academica();
		ArrayList<CCarrera> carrera=data.getListaCarrera();
	%>
			<h3 class="ui-widget-header ui-corner-all">Estatus del Estudiante</h3>
		<div class="tabla">
						<div class="fila">
									<div class="col_titulo">*Carne</div>
									<div class="col"><input type="text" id="carne" name="carne" class="required"  size="20"></div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Centro Universitario</div>
									<div class="col">
										<select id="centro_registro"  name="centro_registro" >
												<option value="0">SELECCIONE SU CENTRO UNIVERSITARIO</option>
										<%
										Iterator<CCentro_Regional> it=centro.iterator();
										while (it.hasNext()) {
											CCentro_Regional cen=it.next();
												out.println("<option value=\""+cen.getIdcentro_regional()+"\">"+cen.getNombre()+"</option>");
										    }
											%>			
										</select>
										
									</div>
						</div>
					
						<div class="fila">
									<div class="col_titulo">*Facultad</div>
									<div class="col">
										<select id="facultad" name="facultad" >
												<option value="0">SELECCIONE SU FACULTAD</option>	
												<%
										Iterator<CUnidad_Academica> it2=facultad.iterator();
										while (it2.hasNext()) {
											CUnidad_Academica fac=it2.next();
												out.println("<option value=\""+fac.getIdunidad_academica()+"\">"+fac.getNombre()+"</option>");
										    }
											%>			
										</select>
									</div>
						</div>
						
						<div class="fila">
									<div class="col_titulo">*Carrera</div>
									
						</div>
						<div class="fila">
									<div class="col">
										<select id="carrera" name="carrera" >
												<option value="0">SELECCIONE SU CARRERA</option>	
												<%
													Iterator<CCarrera> it3=carrera.iterator();
													while (it3.hasNext()) {
														CCarrera car=it3.next();
															out.println("<option value=\""+car.getIdcarrera()+"\">"+car.getNombre()+"</option>");
													    }
												%>
										</select>
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
									<div class="col_titulo">*No Personal</div>
									<div class="col">
										<input type="text" id="no_personal" name="no_personal" minlength="3" class="required" size="20">
									</div>
						</div>
						<div class="fila">			
									<div class="col_titulo">*Dependencia</div>
									<div class="col">
										<select id="dependencia" name="dependencia" >
												<option value="0">SELECCIONE LA DEPENDENC&Iacute;A</option>	
												<%
													Iterator<CDependencia> it4=lista_dep.iterator();
													while (it4.hasNext()) {
														CDependencia car=it4.next();
															out.println("<option value=\""+car.getIddependencia()+"\">"+car.getNombre()+"</option>");
													    }
												%>
										</select>
									</div>
						</div>
						
			</div>
		<div style="clear: both;"></div>															
	<% }%>	
<h3 class="ui-widget-header ui-corner-all">Datos Personales</h3>
	<div class="tabla">
						<div class="fila">
									<div class="col_titulo">*Usuario</div>
									<div class="col">
										<input type="text" id="username" name="username" class="required"  size="20"/>
										<a onclick="disponibilidad()" class="info-btt">Comprobar disponibilidad</a><br/>
										<label id="disp_usuario"></label>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Password</div>
									<div class="col">
										<input type="password" autocomplete="off" class="password" name="password" id="password"  />
										<div class="password-meter">
											<div class="password-meter-message">&nbsp;</div>
											<div class="password-meter-bg">
												<div class="password-meter-bar"></div>
											</div>
										</div>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Confirmar Password </div>
									<div class="col"> <input type="password" id="password_confirm" name="password_confirm"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Nombre Completo</div>
									<div class="col">
									<input type="text" id="nombre_usuario" name="nombre_usuario" class="required"  size="70"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Cedula/DPI</div>
									<div class="col">
									
										<select id="paren_usuario" name="paren_usuario" >
										<option value="0">SOY MAYOR DE EDAD</option>
									<%
										Iterator<CParentesco> it_paren=lista_paren.iterator();
										while(it_paren.hasNext()){
											CParentesco paren= it_paren.next();
											out.println("<option value=\""+paren.getIdparentesco()+"\">Responsable "+paren.getNombre()+"</option>");
										}
									%>	</select><input type="text" id="ced_usuario" name="ced_usuario" class="required"  size="25"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Telefono</div>
									<div class="col">
									<input type="text" id="tel_usuario" name="tel_usuario"   size="30"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Telefono Movil</div>
									<div class="col">
									<input type="text" id="movil_usuario" name="movil_usuario"  size="30"/>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Direcci&oacute;n</div>
									<div class="col">
									<textarea id="direccion" name="direccion"  rows="3" cols="50"  class="required"></textarea>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Fecha de Nacimiento</div>
									<div class="col"><input type="text" id="datepicker" name="datepicker" class="required" size="10"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Sexo</div>
									<div class="col">
									<div class="genero">
										<input type="radio" id="genero_1" name="genero" value="1" /><label for="genero_1">MASCULINO</label>
										<input type="radio" id="genero_2" name="genero" value="2" checked="checked" /><label for="genero_2">FEMENINO</label>
									</div>
									</div>
						</div>
						<div class="fila">
									<div class="col_titulo">Correo Electronico</div>
									<div class="col"><input type="text" id="correo_electronico" name="correo_electronico"  size="50"/></div>
						</div>
						<div class="fila">
									<div class="col_titulo">*Ingrese el texto</div>
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
	<% data.Close();%>