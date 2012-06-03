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
									<input type="radio" name="multifa" class="multifa" id="simultifa" value="0" <%= (configurar.getMultifa_reporte()==0)?"checked":"" %> /><label for="simultifa">NO</label>
									<input type="radio" name="multifa" class="multifa" id="nomultifa" value="1" <%= (configurar.getMultifa_reporte()==1)?"checked":"" %> /><label for="nomultifa">SI</label>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Impresi&oacute;n completa en la Unidad de Salud</div>
								<div class="col">
									<input type="radio" name="salud" class="salud" id="sisalud" value="0" <%= (configurar.getImpresion_salud()==0)?"checked":"" %> /><label for="sisalud">NO</label>
									<input type="radio" name="salud" class="salud" id="nosalud" value="1" <%= (configurar.getImpresion_salud()==1)?"checked":"" %> /><label for="nosalud">SI</label>
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
									<input type="radio" name="random_carne" class="random_carne" id="random" value="0" <%= (configurar.getRandom_carne()==0)?"checked":"" %> /><label for="random">RANDOM</label>
									<input type="radio" name="random_carne" class="random_carne" id="carne" value="1" <%= (configurar.getRandom_carne()==1)?"checked":"" %> /><label for="carne">CARNE</label>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Fecha de cobro de examen de salud, extraordinario</div>
								<div class="col">
									<input type="text" id="fecha_examen"  class="datepicker" size="20px" value="<%= configurar.getFormatoFechaddmmyy(configurar.getFecha_examen()) %>" /> dd/mm/yyyy
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
		 $(function() {
				$( ".multifa" ).button();
				$( ".salud" ).button();
				$( ".random_carne" ).button();
			});
		function GuardarConfi(){
			cadena = [
			          'fecha='+$('#fecha_examen').val(),
					  'imp_salud='+$("input[@name='salud']:checked").val(),
					  'jefe='+$("#jefe").val(),
			          'random_carne='+$("input[@name='random_carne']:checked").val(),
			          'fecha_examen='+$("#fecha_examen").val(),
			          'telefono='   + $("#tel_confi").val(),
			          'fax='+ $("#fax_confi").val(),
			          'dir='+$("#dir_confi").val(),
			          'size='+$("#size_confi").val(),
			          'a=GuardarConfig',
			          'ciclo='+$("#ciclo").val(),
			          'multifa='+$("input[@name='multifa']:checked").val(),
			          
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