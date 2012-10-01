<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CConfiguracion" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
CConfiguracion configurar=dbo.getConfiguracion();
dbo.Close();

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(233)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>    

		<div class="centerd">
				<h2>CONFIGURACI&Oacute;N</h2>
		</div>
<br/>
<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">Telefono</div>
								<div class="col"><input id="tel_confi" type="text" size="15" value="<%=configurar.gettelefono() %>"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Fax</div>
								<div class="col"><input id="fax_confi" type="text" size="15" value="<%=configurar.getfax() %>" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Direcci&oacute;n</div>
								<div class="col"><textarea id="dir_confi" rows="3" cols="60"><%=configurar.getdireccion() %></textarea></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Direcci&oacute;n de Imagen</div>
								<div class="col"><%=configurar.getdireccion_imagen()%></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Direcci&oacute;n de PDF</div>
								<div class="col"><%=configurar.getdireccion_pdf()%></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Tama&ntilde;o para subir archivos</div>
								<div class="col"><input id="size_confi" size="10" type="text" value="<%= configurar.gettamanio_sub() %>"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Ciclo Actual</div>
								<div class="col"><input type="text" size="10" value="<%= configurar.getCiclo() %>" id="ciclo"></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Impresi&oacute;n completa de multif&aacute;sico</div>
								<div class="col">
									<select name="multifa" class="multifa" id="multifa">	
										<option value="0" <%= (configurar.getMultifa_reporte()==0)?"selected":"" %>>NO</option>
										<option value="1" <%= (configurar.getMultifa_reporte()==1)?"selected":"" %> >SI</option>
									</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Los estudiantes imprimen</div>
								<div class="col">
									
									<select name="salud" class="salud" id="salud">	
										<option value="0" <%= (configurar.getImpresion_salud()==0)?"selected":"" %>>NO</option>
										<option value="1" <%= (configurar.getImpresion_salud()==1)?"selected":"" %> >SI</option>
									</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Jefe actual</div>
								<div class="col">
									<input type="text" name="jefe" class="jefe" id="jefe" size="30" value="<%= configurar.getJefe_actual()%>" />
									
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Modalidad para escoger examen</div>
								<div class="col">
									<select name="random_carne" class="random_carne" id="random_carne">	
										<option value="0" <%= (configurar.getRandom_carne()==0)?"selected":"" %>>RANDOM</option>
										<option value="1" <%= (configurar.getRandom_carne()==1)?"selected":"" %>>CARNE</option>
									</select>

								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Examen en linea</div>
								<div class="col">
									<select name="linea" class="linea" id="linea">	
										<option value="0" <%= (configurar.getExamen_linea()==0)?"selected":"" %>>NO</option>
										<option value="1" <%= (configurar.getExamen_linea()==1)?"selected":"" %>>SI</option>
									</select>

								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Fecha de cobro de examen de salud, extraordinario</div>
								<div class="col">
									<input type="text" id="fecha_examen"  class="datepicker" size="20px" value="<%= configurar.getFormatoFechaddmmyy(configurar.getFecha_examen()) %>" /> dd/mm/yyyy
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Dependencia / WEBSERVICES</div>
								<div class="col">
									<input type="password" id="dependencia"  size="30px" value="<%= configurar.getDependencia() %>" /> 
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">No Personal / WEBSERVICES</div>
								<div class="col">
									<input type="password" id="no_personal"  size="30px" value="<%= configurar.getNo_personal() %>" /> 
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Password / WEBSERVICES</div>
								<div class="col">
									<input type="password" id="pass"  size="30px" value="<%= configurar.getPassword() %>" /> 
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Correo JavaMail</div>
								<div class="col">
									<input type="text" name="email_javamail" class="email_javamail" id="email_javamail" size="30" value="<%= configurar.getCorreo_javamail()%>" />
									
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Password JavaMail</div>
								<div class="col">
									<input type="text" name="pass_javamail" class="pass_javamail" id="pass_javamail" size="30" value="<%= configurar.getPass_javamail()%>" />
									
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">SMTP JavaMail</div>
								<div class="col">
									<input type="text" name="smtp_javamail" class="smtp_javamail" id="smtp_javamail" size="30" value="<%= configurar.getSmtp_javamail() %>" />
									
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Puerto JavaMail</div>
								<div class="col">
									<input type="text" name="port_javamail" class="port_javamail" id="port_javamail" size="30" value="<%= configurar.getPort_javamail() %>" />
									
								</div>
							</div>
				</div>
</div>							
	
				<div class="center_button">
						<a href="#" onclick="GuardarConfi()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
		<script>
		 $(function() {
			  $( ".datepicker" ).datepicker();
				$(".time").mask("99:99");
				$(".datepicker").mask("99/99/9999");
				$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
			});

		function GuardarConfi(){
			cadena = [
			          'fecha='+$('#fecha_examen').val(),
					  'imp_salud='+$("#salud").val(),
					  'jefe='+$("#jefe").val(),
			          'random_carne='+$("#random_carne").val(),
			          'fecha_examen='+$("#fecha_examen").val(),
			          'telefono='   + $("#tel_confi").val(),
			          'fax='+ $("#fax_confi").val(),
			          'dir='+$("#dir_confi").val(),
			          'size='+$("#size_confi").val(),
			          'a=GuardarConfig',
			          'ciclo='+$("#ciclo").val(),
			          'multifa='+$("#multifa").val(),
			          'dependencia='   + $("#dependencia").val(),
			          'no_personal='+ $("#no_personal").val(),
			          'password='+$("#pass").val(),
			          'correo_javamail='+$("#email_javamail").val(),
			          'pass_javamail='   + $("#pass_javamail").val(),
			          'smtp_javamail='+ $("#smtp_javamail").val(),
			          'port_javamail='+$("#port_javamail").val(),
			          'linea='+$("#linea").val(),
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
<%   	}	} %>				