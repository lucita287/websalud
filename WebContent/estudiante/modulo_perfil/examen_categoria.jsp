<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %> 
    <%@ page import="framework.CValidation" %> 
    <%@ page import="data.CCategoria" %>
    <%@ page import="java.util.ArrayList" %> 
    <%@ page import="java.util.Iterator" %>
    <%@ page import="data.CPregunta" %> 
	<%@ page import="data.CTitulo_Respuesta" %>
    <script>
$(function() {
	$( ".check" ).button();
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
    CDataExam data=new CDataExam();
    data.Connect();
    ArrayList<CCategoria> cate= data.getListaCategoriaMenu(auto,multi,menu);
    
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
													<input type="radio" 
													id="pregunta_<%= pregunta.getIdpregunta() %>_<%= titulo.getIdtitulo_respuesta() %>"
													name="pregunta_<%= pregunta.getIdpregunta() %>" class="check" />
													<label for="pregunta_<%= pregunta.getIdpregunta() %>_<%= titulo.getIdtitulo_respuesta() %>"><%= titulo.getDescripcion() %></label>
											<% 	} 
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
data.Close();
%>
	</form>
    