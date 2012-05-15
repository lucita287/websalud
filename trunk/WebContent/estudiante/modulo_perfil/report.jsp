<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CAnuncio" %>
<% 
    CDataExam dbo=new CDataExam();
    dbo.Connect();
    CAnuncio anuncio=dbo.getAnuncioEspecifico(5);
    
%>    
 <h2>DASH </h2>   
 <%= anuncio.getContenido() %>
<form id="form_report" name="form_report" action="../SGenerateReportPDF" method="post" target="_blank">
  	<center>
  	<input type="submit" id="enviar" value="Descargar Dash" />
  	</center>
  	<input type="hidden" name="report" id="report" value="Primera_parte" />
  	<input type="hidden" name="report_name" id="report_name" value="Primera_parte" />
  	<input type="hidden" name="parameters" id="parameters" value="idpaciente" />
  	<input type="hidden" name="values" id="values" value="1" />
  </form>
<script>
		 $(function() {
				$( "#enviar" ).button();
			});
</script>		 
