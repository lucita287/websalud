<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataPreg" %>
<%@ page import="data.CPaciente" %>
<%@ page import="framework.CEvaluarExamen" %>    
<%@ page import="data.CAnuncio" %>
<%@ page import="data.CConfiguracion" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    CDataPreg dbo=new CDataPreg();
    dbo.Connect();
    
    
   
    
    
    CEvaluarExamen eva=new CEvaluarExamen();
    CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    if(pac.getExamen_linea()>=5 && pac.getEstado()==3){
    	
    	 CConfiguracion config2=dbo.getConfiguracion();
    		if(config2.getImpresion_salud()==1){
    			CAnuncio anuncio=dbo.getAnuncioEspecifico(5);    	
    String sql="";
    ArrayList<Integer> list=eva.Evaluar(pac.getIdpaciente());
    Iterator<Integer> it=list.iterator();
    while(it.hasNext()){
    	sql+=it.next();
    	if(it.hasNext()) sql+=",";
    }
%>    
 <div style="float:right;">
	<form id="MainForm" name="MainForm" action="../SSiguiente" method="post">
		<input type="hidden" name="a" value="reportmulti" />
		<input type="submit" name="siguiente" class="large button red" value="siguiente" />
	</form>
</div>
 <h2>DASH MULTIF&Aacute;SICO </h2>   
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
<%	}else{
	
	CAnuncio anuncio=dbo.getAnuncioEspecifico(11);
	 out.println("<div class='instruccion'>"+anuncio.getContenido()+"<div/>"); 
	
	}

    }else{%>
<h2>DEBE COMPLETAR EL PASO 2, PARA CONTINUAR</h2>
En el menu del lado izquierdo, presiona PASO 2 y selecciona EXAMEN MULTIF&Aacute;SICO
<BR> DEBES COMPLETAR EL CUESTIONARIO DE SALUD, PARA CONTINUAR
	<%
	
    } 
    dbo.Close();

} %>