<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataPreg" %>
<%@ page import="data.CPaciente" %>
<%@ page import="framework.CEvaluarExamen" %>    
<%@ page import="data.CAnuncio" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    CDataPreg dbo=new CDataPreg();
    dbo.Connect();
    CAnuncio anuncio=dbo.getAnuncioEspecifico(5);
    CEvaluarExamen eva=new CEvaluarExamen();
    CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    String sql="";
    ArrayList<Integer> list=eva.Evaluar(pac.getIdpaciente());
    Iterator<Integer> it=list.iterator();
    while(it.hasNext()){
    	sql+=it.next();
    	if(it.hasNext()) sql+=",";
    }
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
  	<input type="hidden" name="resultado" id="resultado" value="<%= sql %>" />
  	
  </form>
<script>
		 $(function() {
				$( "#enviar" ).button();
			});
</script>		 
<% } %>