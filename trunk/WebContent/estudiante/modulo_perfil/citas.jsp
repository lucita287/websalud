<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CCita" %>    
<%@ page import="data.CAnuncio" %>
<% 
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
ArrayList<CCita> list=dbo. getListaCitasEstudiante(2);
%>
	<script>
	$(function() {
		
		//$( ".check" ).button();	
		$( ".button" ).button();
	});
	</script>

<h2>SELECCIONA UNA CITA</h2>

Deposito Monitario:
<input type="text"  size="20"  /><br/>

<h2>Examen Multf&aacute;sico</h2>


<% 
	
Iterator<CCita> it=list.iterator();
	while(it.hasNext()){
		CCita cita=it.next();
		out.print("<input type='radio' name='fecha_examen' class='check' >"+cita.getFormatoFechaddmmyy(cita.getFecha())+" "+cita.getFormatoFechahhmm(cita.getHora_inicio())+"<br>");
	}

	
	list=dbo. getListaCitasEstudiante(1);	
	if(list.size()==0){
		CAnuncio anuncio=dbo.getAnuncioEspecifico(4);
		 out.print( anuncio.getContenido()); 
	}
%>	
<h2>Examen AutoEvaluaci&oacute;n</h2>
<% 
it=list.iterator();
	while(it.hasNext()){
		CCita cita=it.next();
		out.print("<input type='radio' name='fecha_examen' class='check' >"+cita.getFormatoFechaddmmyy(cita.getFecha())+" "+cita.getFormatoFechahhmm(cita.getHora_inicio())+"<br>");
	}
	
	
} %>
<input type="submit" name="Enviar" class="button" value="Enviar">
