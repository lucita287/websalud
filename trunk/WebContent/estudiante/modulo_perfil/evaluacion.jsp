<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %> 
    <%@ page import="data.CPaciente" %>
    <%@ page import="java.util.ArrayList" %> 
    <%@ page import="java.util.Iterator" %>
    <%@ page import="data.CAnuncio" %>
    <%@ page import="framework.CEvaluarExamen" %>    
      <% 
    HttpSession sessiones=request.getSession(false); 
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    	CDataExam dbo=new CDataExam();
    	CEvaluarExamen eva=new CEvaluarExamen();
        String sql="";
        ArrayList<Integer> list=eva.Evaluar(pac.getIdpaciente());
        Iterator<Integer> it=list.iterator();
        while(it.hasNext()){
        	sql+=it.next();
        	if(it.hasNext()) sql+=",";
        }
    	
    	if(dbo.Connect()){	
    		CAnuncio anuncio=dbo.getAnuncioEspecifico(4);
    %>	    
<BR/><h2>    DASH DE AUTOEVALUACI&Oacute;N</h2>

<% out.println(anuncio.getContenido()+"<BR/>"); %>
<form id="form_report" name="form_report" action="../SGenerateReportAutoPDF" method="post" target="_blank">
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
<% }} %>
	