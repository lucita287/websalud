<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CUsuario" %>
<%

HttpSession ss=request.getSession(false); 
if(ss!=null && session.getAttribute("user")!=null){
CDataBase dbo=new CDataBase();
dbo.Connect();
CUsuario user=dbo.getUsuario(session.getAttribute("user").toString());
dbo.Close();
%>
		<div class="centerd">
				<h2> PERFIL</h2>
		</div>
<script>
$(document).ready(function () {
	$(".col_pass").hide();
	$( ".chk_pass" ).button({
        icons: {
            primary: "ui-icon-plusthick"
        }}); 
	$( ".ochk_pass" ).button({
        icons: {
            primary: "ui-icon-circle-close"
        }}); 
});
function Cambiar_pass(){
	$(".col_pass").show();
	$(".chk_pass").hide();
}
function ocultar_pass(){
	$(".col_pass").hide();
	$(".chk_pass").show();
	$("#ant_pass").val("");
	$("#new_pass").val("");
	$("#conf_pass").val("");
}
function Guardar(){
	cadena = ['nombre='   + $("#nombre_perfil").val(),
	          'apellido='+ $("#apellido_perfil").val(),
	          'telefono='+$("#telefono_perfil").val(),
	          'email='+$("#email_perfil").val(),
	          'no_personal='+$("#no_personal_perfil").val(),
	          'ant_pass='+$("#ant_pass").val(),
	          'new_pass='+$("#new_pass").val(),
	          'conf_pass='+$("#conf_pass").val(),
           	  'a=guardar_perfil',
	        ].join('&');
	$.ajax({
        url: "../SUsuario",
        data: cadena,
  	    type: 'post',
        dataType: 'json',
        success: function(data){
        	mensaje(data.mensaje);
        	if(data.resultado=='OK'){
        	ocultar_pass();	
        	}
        }
    });
	
}
</script>
<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
<div class="perfil">
<div class="tabla">
	<div class="fila">
			<div class="col_titulo">*Nombre</div> 
			<div class="col"><input id="nombre_perfil" type="text" size="40" value="<%=user.getnombre() %>"/></div>
	</div>
	<div class="fila">		
			<div class="col_titulo">*Apellido</div> 
			<div class="col"><input id="apellido_perfil" type="text" size="40" value="<%=user.getapellido() %>" /></div>
	</div>
	<div class="fila">		
			<div class="col_titulo">Telefono</div> 
			<div class="col"><input id="telefono_perfil" type="text" value="<%=user.gettelefono() %>"/></div>
	</div>
	<div class="fila">		
			<div class="col_titulo">Email</div>
			<div class="col"><input type="text" id="email_perfil" value="<%=user.getemail()%>" /></div>
	</div>
	<div class="fila">		
			<div class="col_titulo">No personal</div>
			<div class="col"><input type="text" id="no_personal_perfil" value="<%=user.getNo_personal() %>" /></div>
	</div>
	<div class="btt_pass" >
		<button class="chk_pass" onclick="Cambiar_pass()">Cambiar Password</button>
	</div>	
	<div style="clear: both;"></div>
	<div class="col_pass">
		<div class="titulo_pass"><button class="ochk_pass" onclick="ocultar_pass()">&nbsp;</button>
								Desea cambiar su password?</div>
		<div class="fila">		
				<div class="col_titulo" >Anterior Password </div>
				<div class="col"><input id="ant_pass" autocomplete="off" type="password" size="20" /></div>
		</div>
		<div class="fila">		
				<div class="col_titulo">Nuevo Password </div>
				<div class="col"><input id="new_pass" autocomplete="off" type="password" size="20" /></div>
		</div>
		<div class="fila">		
				<div class="col_titulo">Confirmar Nuevo Password</div>
				<div class="col"><input id="conf_pass" autocomplete="off" type="password" size="20" /></div>
		</div>
	<div style="clear: both;"></div>
	</div>
			
</div>	
<div style="clear: both;"></div>
				<div class="center_button">
						<a onclick="Guardar()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>					
				</div>
</div>
<% } %>				