<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="framework.CValidation" %>    
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Pregunta" %>
<%@ page import="data.CCategoria" %>
<%@ page import="data.CPregunta" %>
<%@ page import="data.CPregunta_Titulo_Respuesta" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){
 			CValidation valid=new CValidation();
		 	int idpregunta=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idpregunta")));
		 	
		 	if(idpregunta>0){
			CDataExam data=new CDataExam();
			data.Connect();
			CPregunta preg=data.getPreguntaEspecifica(idpregunta);
			 ArrayList<CPregunta_Titulo_Respuesta> lista_det=data.getListaPregunta_Titulo_Respuesta(preg);
			if(preg!=null){
			
			ArrayList<CCategoria> lista_cate=data.getListaCategoria();
			data.Close();
	
%>
<script>
$(function() {
	$( ".check" ).button();
});
function cancelar(){
	$( "#dialog-form" ).dialog( "close" );
}
function preguntaedit(){
	
	cadena = [ 	'a=editPregunta',
	           	'tipo=<%=preg.getIdtipo_pregunta().getIdtipo_pregunta()%>',
	           	'idpregunta=<%=idpregunta%>',
	            'pregunta='+$("#pregunta_epregunta").val(),
	            'categoria='+$("#categoria_epregunta").val(),
	            'requerida='+$("input[name='eobligatoria']:checked").val(),
	            'auto='+(($('#auto_epregunta').is(':checked')==true)?"1":"0"),
	            'multifa='+(($("#multifa_epregunta").is(':checked')==true)?"1":"0"),
	            'descrip='+$("#descripcion_epregunta").val(),
	            'orden='+$("#orden_epregunta").val(),
	            'genero='+$("#genero_pregunta").val(),
	            'estado='+$("#estado_epregunta").val()
	        ].join('&');
	cadena=cadena+"&"+mensaje_ecadena();
	
	  $.ajax({
        url: "../SPregunta",
        data: cadena,
  	    type: 'post',
        dataType: 'json',
        success: function(data){
        	mensaje(data.mensaje);
        	if(data.resultado=='OK'){
        		$( "#dialog-form" ).dialog( "close" );
        		
        		$('#Pregunta_table').flexReload();
        	}
        }
    });
}
</script>
<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
    	<H2>EDITAR PREGUNTA <%=idpregunta%></H2>
    	<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">*Orden-Numero</div>
								<div class="col"><input type="text" id="orden_epregunta" name="orden_epregunta" size="10" value="<%= preg.getOrden() %>" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Pregunta</div>
								<div class="col"><textarea id="pregunta_epregunta" name="pregunta_epregunta" rows="3" cols="60"><%= preg.getPregunta() %></textarea></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Categoria</div>
								<div class="col">
										<select id="categoria_epregunta" name="categoria_epregunta" >
													<option value="0" selected>SELECCIONE UNA CATEGORIA</option>
													<% for(int j=0; j<lista_cate.size();j++){ 
														CCategoria edi=lista_cate.get(j);%>
														<option value="<%=edi.getIdcategoria() %>" <%if(preg.getIdcategoria().getIdcategoria()==edi.getIdcategoria()){ out.println("selected"); } %>><%=edi.getDescripcion() %></option>
													<% } %>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Dirigida al genero</div>
								<div class="col">
									<select id="genero_pregunta" name="genero_pregunta"  >
													<option value="0" <%=((preg.getGenero()==0)?"selected":"") %> >AMBOS</option>
													<option value="2" <%=((preg.getGenero()==2)?"selected":"") %> >MUJERES</option>
													<option value="1" <%=((preg.getGenero()==1)?"selected":"") %>>HOMBRES</option>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Tipo de pregunta</div>
								<div class="col">
									<%=preg.getIdtipo_pregunta().getDescripcion() %>
								</div>
							</div>
							<% if(preg.getIdtipo_pregunta().getIdtipo_pregunta()<=1){ %>
								<script>
									function mensaje_ecadena(){
										return "";
									}		
								</script>
							<% }else %>
							<%if(preg.getIdtipo_pregunta().getIdtipo_pregunta()==2){ %>
								<script>
									function mensaje_ecadena(){
											cadena = [ 	'size='+$("#size_epregunta").val(),
										        ].join('&');
										return cadena;
									}		
								</script>
									<div class="fila">
								<div class="col_titulo">*Tama&ntilde;o</div>
								<div class="col">
									<select id="size_epregunta" name="size_epregunta" >
													<option value="0"  <%=((preg.getLargo()==0)?"selected":"") %>>SELECCIONE EL TAMA&Ntilde;O</option>
													<option value="1"  <%=((preg.getLargo()==1)?"selected":"") %>>PEQUE&Ntilde;O</option>
													<option value="2"  <%=((preg.getLargo()==2)?"selected":"") %>>MEDIANO</option>
													<option value="3"  <%=((preg.getLargo()==3)?"selected":"") %>>GRANDE</option>
									</select>
								</div>
								</div>
							<% }else %>
							<%if(preg.getIdtipo_pregunta().getIdtipo_pregunta()>=3){
								String cadena_mensaje="";
								Iterator<CPregunta_Titulo_Respuesta> it=lista_det.iterator();
								while(it.hasNext()){
									CPregunta_Titulo_Respuesta lis=it.next();
									cadena_mensaje+="\"ponderacion"+lis.getIdtitulo_respuesta().getIdtitulo_respuesta()+"=\"+$(\"#ponderacion"+lis.getIdtitulo_respuesta().getIdtitulo_respuesta()+"\").val(),";
							%>
							<div class="fila">
								<div class="col_titulo">Ponderaci&oacute;n <%= lis.getIdtitulo_respuesta().getDescripcion() %></div>
								<div class="col">
									<input type="text" id="ponderacion<%=lis.getIdtitulo_respuesta().getIdtitulo_respuesta() %>" size="10" value="<%= lis.getPonderacion() %>" />
								</div>
							</div>		
							<% } %>
							<div class="fila">
								<div class="col_titulo">*Opcion Multiple</div>
								<div class="col">
									<input  type="radio" id="emultiple1" name="emultiple" value="1" class="check emultiple" <%= (preg.getMultiple()==1)?"CHECKED":"" %>/><label for="emultiple1">SI</label>
									<input  type="radio" id="emultiple2" name="emultiple" value="0" class="check emultiple" <%= (preg.getMultiple()==0)?"CHECKED":"" %> /><label for="emultiple2">NO</label>
								</div>
							</div>
							<script>
								function mensaje_ecadena(){
											cadena = [ 
											'multiple='+$("input[name='emultiple']:checked").val(),
											<%=cadena_mensaje%>
										        ].join('&');
										return cadena;
									}
							</script>
							
							<% } %>
							
							<div class="fila">
								<div class="col_titulo">*Obligatoria</div>
								<div class="col">
									<input  type="radio" id="eobligatoria1" name="eobligatoria" value="1" class="check eobligatoria" <%=( preg.getRequerida()==0?"":"CHECKED" ) %>/><label for="eobligatoria1">SI</label>
									<input  type="radio" id="eobligatoria2" name="eobligatoria" value="0" class="check eobligatoria" <%=( preg.getRequerida()==0?"CHECKED":"" ) %>/><label for="eobligatoria2">NO</label>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Examenes</div>
								<div class="col">
									<input type="checkbox" name="auto_epregunta" id="auto_epregunta" class="check"  <%=( preg.getAuto_evaluacion()==1?"CHECKED":"" ) %> /><label for="auto_epregunta">Examen de AutoEvaluaci&oacute;n</label>
									<input type="checkbox" name="multifa_epregunta" id="multifa_epregunta" class="check" <%=( preg.getMultifasico()==1?"CHECKED":"" ) %> /><label for="multifa_epregunta">Examen Multif&aacute;sico</label>										
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripcion</div>
								<div class="col">
										<textarea id="descripcion_epregunta" name="descripcion_epregunta" rows="2" cols="60"><%=preg.getDescripcion() %></textarea>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Estado</div>
								<div class="col">
									<select id="estado_epregunta" name="estado_epregunta"  >
													<option value="0"  <%=( preg.getEstado()==0?"selected":"" ) %>>NO MOSTRAR EN DASH</option>
													<option value="1" <%=( preg.getEstado()==1?"selected":"" ) %>>MOSTRAR EN DASH</option>
												</select>
								</div>
							</div>
				</div>
		</div>					
		<div class="center_button">
										<input type="button"   class="ui-state-default ui-corner-all button-save" value="Guardar"  onclick="preguntaedit()"/> 
										<input type="button"   class="ui-state-default ui-corner-all button-save" onclick="cancelar()" value="Cancelar" />
					</div>	    	
    	
 <%	} }	}	}%>   	