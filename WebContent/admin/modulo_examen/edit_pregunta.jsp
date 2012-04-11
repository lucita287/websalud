<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="framework.CValidation" %>    
 <%@ page import="java.util.ArrayList" %>
<%@ page import="data.CTipo_Pregunta" %>
<%@ page import="data.CCategoria" %>
<%@ page import="data.CPregunta" %>
<%
 	CValidation valid=new CValidation();
 	int idpregunta=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpregunta")));
 	
 	if(idpregunta>0){
	CDataExam data=new CDataExam();
	data.Connect();
	CPregunta preg=data.getPreguntaEspecifica(idpregunta);
	
	if(preg!=null){
	
	ArrayList<CCategoria> lista_cate=data.getListaCategoria();
	data.Close();
	
%>
<script>
$(function() {
	$( ".check" ).button();
});
</script>
<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
    	<H2>EDITAR PREGUNTA <%=idpregunta%></H2>
    	<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">*Orden-Numero</div>
								<div class="col"><input type="text" id="orden_pregunta" name="orden_pregunta" size="10" value="<%= preg.getOrden() %>" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Pregunta</div>
								<div class="col"><textarea id="pregunta_pregunta" name="pregunta_pregunta" rows="3" cols="60"><%= preg.getPregunta() %></textarea></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Categoria</div>
								<div class="col">
										<select id="categoria_pregunta" name="categoria_pregunta" >
													<option value="0" selected>SELECCIONE UNA CATEGORIA</option>
													<% for(int j=0; j<lista_cate.size();j++){ 
														CCategoria edi=lista_cate.get(j);%>
														<option value="<%=edi.getIdcategoria() %>" <%if(preg.getIdcategoria().getIdcategoria()==edi.getIdcategoria()){ out.println("selected"); } %>><%=edi.getDescripcion() %></option>
													<% } %>
												</select>
								</div>
							</div>
														<div class="fila">
								<div class="col_titulo">*Obligatoria</div>
								<div class="col">
									<input  type="radio" id="obligatoria1" name="obligatoria" value="1" class="check obligatoria" <%=( preg.getRequerida()==0?"":"CHECKED" ) %>/><label for="obligatoria1">SI</label>
									<input  type="radio" id="obligatoria2" name="obligatoria" value="0" class="check obligatoria" <%=( preg.getRequerida()==0?"CHECKED":"" ) %>/><label for="obligatoria2">NO</label>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Examenes</div>
								<div class="col">
									<input type="checkbox" name="auto_pregunta" id="auto_pregunta" class="check"  <%=( preg.getAuto_evaluacion()==1?"CHECKED":"" ) %> /><label for="auto_pregunta">Examen de AutoEvaluaci&oacute;n</label>
									<input type="checkbox" name="multifa_pregunta" id="multifa_pregunta" class="check" <%=( preg.getMultifasico()==1?"CHECKED":"" ) %> /><label for="multifa_pregunta">Examen Multif&aacute;sico</label>										
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripcion</div>
								<div class="col">
										<textarea id="descripcion_pregunta" name="descripcion_pregunta" rows="2" cols="60"><%=preg.getDescripcion() %></textarea>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Estado</div>
								<div class="col">
									<select id="estado_pregunta" name="estado_pregunta"  >
													<option value="0"  <%=( preg.getEstado()==0?"selected":"" ) %>>DESHABILITADA</option>
													<option value="1" <%=( preg.getEstado()==1?"selected":"" ) %>>HABILITADO</option>
												</select>
								</div>
							</div>
				</div>
		</div>					
    	
    	
 <%	} }%>   	