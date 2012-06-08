<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %> 
    <%@ page import="data.CPaciente" %>
    <%@ page import="java.util.ArrayList" %> 
    <%@ page import="java.util.Iterator" %>
    <%@ page import="data.CAnuncio" %>
    <%@ page import="data.CConfiguracion" %>
    <%@ page import="framework.CEvaluarExamen" %>    
      <% 
    HttpSession sessiones=request.getSession(false); 
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    	if(pac.getExamen_linea()>=6 && pac.getEstado()==2){
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
    	
    		CConfiguracion config2=dbo.getConfiguracion();
    		if(config2.getImpresion_salud()==1){
    		
    		CAnuncio anuncio=dbo.getAnuncioEspecifico(4);
    %>	    
<BR/>

 <div style="float:right;">
	<form id="MainForm" name="MainForm" action="../SSiguiente" method="post">
		<input type="hidden" name="a" value="reportauto" />
		<input type="submit" name="siguiente" class="large button red" value="siguiente" />
	</form>
</div>
<h2>    CUESTIONARIO DE AUTOEVALUACI&Oacute;N</h2>



<% out.println(anuncio.getContenido()+"<BR/>"); %>

<form id="form_report" name="form_report" action="../SGenerateReportAutoPDF" method="post" target="_blank">
  	<center>
  	<input type="submit" id="enviar" value="Descargar Resultados" />
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
<% }else{
	CAnuncio anuncio=dbo.getAnuncioEspecifico(11);
	 out.println("<div class='instruccion'>"+anuncio.getContenido()+"<div/>"); 
}
    dbo.Close();			
    	}
    	}else{%>
    		<h2>DEBE COMPLETAR EL PASO 2, PARA CONTINUAR</h2>
    	<%}
    	
    
    } %>
	