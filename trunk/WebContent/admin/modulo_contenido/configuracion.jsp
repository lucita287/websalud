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
				</div>
</div>							
	
				<div class="center_button">
						<a href="#" onclick="GuardarConfi()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
		<script>
		function GuardarConfi(){
			cadena = ['telefono='   + $("#tel_confi").val(),
			          'fax='+ $("#fax_confi").val(),
			          'dir='+$("#dir_confi").val(),
			          'size='+$("#size_confi").val(),
			          'a=GuardarConfig'
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