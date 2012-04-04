<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
 <%@ page import="framework.CValidation" %>
<%
		CValidation valid=new CValidation();
		int idregistro=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idregistro")));		
%>   
<div id="registro_usuarios" class="ui-widget-content ui-corner-all">
<div id="registro_titulo" >
<h2>REGISTRARSE</h2>		
</div>
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNAR A LA UNIDAD DE SALUD</a>  

</div>
<div style="clear: both;"></div>

<% if(idregistro==0){%>
<div id="div_button_registro">
	<a href="registrarse.jsp?a=registrarse&idregistro=2"><button id="bt_est_registro" class="button_registro">Estudiante de la Universidad de San Carlos de Guatemala</button></a>
	<a href="registrarse.jsp?a=registrarse&idregistro=3"><button class="button_registro"  id="bt_tra_registro">Trabajador de la Universidad de San Carlos de Guatemala</button></a>
	<a href="registrarse.jsp?a=registrarse&idregistro=4"><button class="button_registro"  id="bt_tra_registro">Estudiante y Trabajador de la Universidad de San Carlos de Guatemala</button></a>
	<a href="registrarse.jsp?a=registrarse&idregistro=1"><button  class="button_registro" id="bt_tra_registro">Cortesia</button></a>
</div>	
<% } %>
<% if(idregistro>0){%>
<jsp:include page="estudiante.jsp">
<jsp:param name="idregistro" value="<%=idregistro%>" />	
</jsp:include>
<% } %>

	<div style="clear: both;"></div>
</div> 

   
<script>
$(function() {
	$( "#datepicker" ).datepicker({
		changeMonth: true,
		changeYear: true,
		yearRange: "1960:2015"
	});
	$("#datepicker").mask("99/99/9999");
	$( "#datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
});

$(document).ready(function () {
	  $( ".button_registro" ).button({
          icons: {
              primary: "ui-icon ui-icon-circle-plus"
          }});
		$(function() {
			$( ".genero" ).buttonset();
		});
});

</script>