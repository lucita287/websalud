<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %> 
    <%@ page import="framework.CValidation" %> 
    <%@ page import="data.CCategoria" %>
    <%@ page import="java.util.ArrayList" %> 
    <%@ page import="java.util.Iterator" %>
    <%@ page import="data.CPregunta" %> 
	<%@ page import="data.CTitulo_Respuesta" %>
	<%@ page import="data.CPregunta_Paciente" %>
	<%@ page import="data.CPaciente" %>
	<%@ page import="java.util.Map" %>
    <script>
    
    <% 
    HttpSession sessiones=request.getSession(false); 
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    		
    %>	
    
$(function() {
	$( ".check" ).button();
	$("#MainForm").validate();
});
</script>
	<form id="MainForm" name="MainForm" action="../SRespuesta" method="post">
	
	<div style="float:left;">
	<h2>PASO 2 / <%= request.getParameter("titulo") %></h2>
	</div>
	<div class="button-sig">
	<input type="submit" id="button_sig" class="ui-state-default ui-corner-all button" value="Guardar"/> 
	
	</div>
	<div style="clear: both;"></div>
	
	
    <% 
    CValidation valid=new CValidation();
    int auto=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("auto")));
    int multi=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("multi")));
    int menu=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idmenu")));
    
    %>
    <input type="hidden" name="a" value="<%=menu%>" />
    <input type="hidden" name="auto" value="<%=auto%>" />
    <input type="hidden" name="multi" value="<%=multi%>" />
    <% 
    CDataExam data=new CDataExam();
    data.Connect();
    ArrayList<CCategoria> cate= data.getListaCategoriaMenu(auto,multi,menu);
    Map<Integer,CPregunta_Paciente> ppaciente=data.getListaPreguntas_Paciente(menu,auto,multi, pac.getIdpaciente());
    Iterator<CCategoria> it=cate.iterator();

    while(it.hasNext()){
    	CCategoria categoria=it.next();	
    	
    	ArrayList<CPregunta> preg=data.getListaPreguntas(categoria,auto, multi);
    	
    %>
    <div id="dato_personal" class="ui-widget-content ui-corner-all">
		<h3 class="ui-state-default ui-corner-all"><%= categoria.getDescripcion().toUpperCase() %></h3>
				<div class="perfil">
					<div class="tabla">
					
						
							<% 
								Iterator<CPregunta> it2=preg.iterator();
								while(it2.hasNext()){
									CPregunta pregunta=it2.next();
								%>
						<div class="border">
							<div class="fila">
									<% if(pregunta.getDescripcion().length()>0){ %>
										<div  class="ui-state-error ui-corner-all col_mensaje"><%=pregunta.getDescripcion() %></div>
										<div style="clear: both;"></div>
									<% } %>	
									<div class="col_pregunta"><font  color="red"><%=pregunta.getOrden() %>)</font> <%=pregunta.getPregunta() %></div>
									<div class="col_examen">
										<% 
											if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()>=3){
											Iterator<CTitulo_Respuesta> it4=pregunta.getIdtipo_pregunta().getIdgrupo_titulo_respuesta().iterator(); 
												while(it4.hasNext()){
													CTitulo_Respuesta titulo=it4.next();
													%>
													<input type="<%=(pregunta.getMultiple()==0?"radio":"checkbox")%>" value="<%= titulo.getIdtitulo_respuesta() %>"
													id="pregunta_<%= pregunta.getIdpregunta() %>_<%= titulo.getIdtitulo_respuesta() %>"
													<%= (ppaciente.containsKey(pregunta.getIdpregunta())?(ppaciente.get(pregunta.getIdpregunta()).getLista().indexOf(titulo.getIdtitulo_respuesta())>-1?"checked=\"checked\"":""):"") %>
													name="pregunta_<%= pregunta.getIdpregunta() %>" class="check<%=(pregunta.getRequerida()==1)?" required":""%>" />
													<label for="pregunta_<%= pregunta.getIdpregunta() %>_<%= titulo.getIdtitulo_respuesta() %>"><%= titulo.getDescripcion() %></label>
											<% 	} 
											} else if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()==1){
												%><input type="text" size="10" id="pregunta_<%= pregunta.getIdpregunta() %>" name="pregunta_<%= pregunta.getIdpregunta() %>" class="number<%=(pregunta.getRequerida()==1)?" required":""%>" value="<%= ppaciente.containsKey(pregunta.getIdpregunta())?ppaciente.get(pregunta.getIdpregunta()).getCantidad()+"":"" %>" ><% 
											} else if(pregunta.getIdtipo_pregunta().getIdtipo_pregunta()==2 ){
													
													if(pregunta.getLargo()>=1 && pregunta.getLargo()<=2){%>
													<input type="text" size="<%=((pregunta.getLargo()==1)?"30":"65")%>" <%=(pregunta.getRequerida()==1)?"class=\"required\"":""%> name="pregunta_<%= pregunta.getIdpregunta() %>" id="pregunta_<%= pregunta.getIdpregunta() %>" class="number<%=(pregunta.getRequerida()==1)?" required":""%>"  value="<%= ppaciente.containsKey(pregunta.getIdpregunta())?ppaciente.get(pregunta.getIdpregunta()).getRespuesta()+"":"" %>">
										  <%		}else{%>
											  		<textarea id="pregunta_<%= pregunta.getIdpregunta() %>" rows="3" cols="50"  name="pregunta_<%= pregunta.getIdpregunta() %>" <%=(pregunta.getRequerida()==1)?"class=\"required\"":""%>><%= ppaciente.containsKey(pregunta.getIdpregunta())?ppaciente.get(pregunta.getIdpregunta()).getRespuesta()+"":""%></textarea>
										  			<%}
													
											}%>
									</div>
							</div>		
							<div style="clear: both;"></div>
						</div>		
							<% }%>
						
						
					</div>
				</div>
				<div style="clear: both;"></div>			
	</div>
<%  } 
data.Close(); }
%>
	</form>
    