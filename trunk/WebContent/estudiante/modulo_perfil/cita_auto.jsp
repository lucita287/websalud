<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CCita" %>    
<%@ page import="data.CAnuncio" %>
<%@ page import="data.CConfiguracion" %>
<%@ page import="data.CPaciente" %> 
<% 
CDataExam dbo=new CDataExam();
HttpSession sessiones=request.getSession(false); 
if(dbo.Connect()){
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    	if(pac.getExamen_linea()>=8 && pac.getEstado()==2){
		
    		CConfiguracion config2=dbo.getConfiguracion();
    		if(config2.getImpresion_salud()==1){
    		
    							int idcita=dbo.getCita(pac);
								String error=request.getParameter("e");
								String boleta=request.getParameter("noboleta");
								
								if(idcita==0){			
																	ArrayList<CCita> list=dbo. getListaCitasEstudiante(1);
																
																if(list.size()>0){ %>
																  <script  type="text/javascript">
																			  $(document).ready(function () {
																				  $("#MainForm").validate();
																			  });
																			  $(function() {
																				  $(".cita").button();
																			  });	  
																</script>			
																<%=  (error!=null)?"<div class='ui-state-error style'>"+error+"</div>":"" %>  
																<form id="MainForm" name="MainForm" action="../SSiguiente" method="post">
																
																<div style="float:right;">
																	
																		<input type="hidden" name="a" value="cita_auto" />
																		<input type="submit" name="Asignar" class="large button red" value="Asignar Examen" />
																	
																	</div>
																<h2>PASO 3/CITA AUTOEVALUACI&Oacute;N</h2>
																
																
																<% if( config2.getFecha_examen().compareTo(new java.util.Date()) <=0 ){ 
																CAnuncio anuncio=dbo.getAnuncioEspecifico(9);
																out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");
																%>
																<%= (error!=null)?"<div class='ui-state-highlight'>":"" %>
																<div class='instruccion'> Ingresa tu boleta de pago:<input name="boleta" class="required" type="text"  size="20" value="<%= boleta!=null?boleta:"" %>"  /></div>
																<%= (error!=null)?"</div>":"" %>
																<% } %>
																
																
																
																<h2>Selecciona una cita</h2>
																
																
																<% 
																CAnuncio anuncio=dbo.getAnuncioEspecifico(6);
																out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");
																Iterator<CCita> it=list.iterator();
																	out.println((error!=null)?"<div class='ui-state-highlight'>":"");
																	while(it.hasNext()){
																		CCita cita=it.next();
																		out.print("<input type='radio'  id='cita"+cita.getIdcita()+"' name='fecha_examen' class='cita required ' value='"+cita.getIdcita()+"' ><label for='cita"+cita.getIdcita()+"'>"+cita.getFormatoFechaddmmyy(cita.getFecha())+" a las  "+cita.getFormatoFechahhmm(cita.getHora_inicio())+"</label><br>");
																	}
																	out.println((error!=null)?"</div>":"");
																	
																		%>
																	
																	</form>	
																		<%	
																	}else{
																		CAnuncio anuncio=dbo.getAnuncioEspecifico(7);
																		out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");
																	}
								}else{
									out.println("<H2>PASO 3 / DESCARGAR CITA</H2>");
									CAnuncio anuncio=dbo.getAnuncioEspecifico(10);
									out.println("<div class='instruccion'>"+anuncio.getContenido()+"</div>");		
									%>
									
									<form id="MainForm" name="MainForm" action="../SGenerateCita" method="post">										
										<input type="hidden" name="a" value="cita" />
										<input type="hidden" name="idcita" value="<%=idcita %>" />
										<center><input type="submit" id="SUcita" value="Descargar Cita" /></center>
									</form>								
									
									<script>
								 $(function() {
										$( "#SUcita" ).button();
									});
						</script>		 
									<% 
								}							
    		}else{
    			CAnuncio anuncio=dbo.getAnuncioEspecifico(11);
    			 out.println("<div class='instruccion'>"+anuncio.getContenido()+"<div/>");
    		}
    		
    	}else{%>
		<h2>DEBE COMPLETAR EL PASO 2, O DAR SIGUIENTE EN PASO 3/CUESTIONARIO DE AUTOEVALUACI&Oacute;N PARA CONTINUAR</h2>
		<%}								
    }
}	
dbo.Close();
%>	
