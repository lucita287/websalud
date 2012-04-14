<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CTipo_Pregunta" %>
<%@ page import="data.CCategoria" %>
<%
CDataExam data=new CDataExam();
data.Connect();
ArrayList<CTipo_Pregunta> lista_tipo=data.getListaTipo_Pregunta();
ArrayList<CCategoria> lista_cate=data.getListaCategoria();
data.Close();

%>
    <script>
    function tipo_pregunta(){
    	$("#div_tipo_pregunta").load("modulo_examen/tipo_pregunta.jsp?idtipo_pregunta="+$("#tipo_pregunta").val());
    	
    }
    $(document).ready(function () {
    		tipo_pregunta();
    });
    $(function() {
		$( ".check" ).button();
	});
    function preguntaForm(){
    	
    	cadena = [ 	'a=NewPregunta',
		            'pregunta='+$("#pregunta_pregunta").val(),
		            'categoria='+$("#categoria_pregunta").val(),
		            'tipo='+$("#tipo_pregunta").val(),
		            'requerida='+$("input[name='obligatoria']:checked").val(),
		            'auto='+(($('#auto_pregunta').is(':checked')==true)?"1":"0"),
		            'multifa='+(($("#multifa_pregunta").is(':checked')==true)?"1":"0"),
		            'descrip='+$("#descripcion_pregunta").val(),
		            'orden='+$("#orden_pregunta").val(),
		            'estado='+$("#estado_pregunta").val()
		        ].join('&');
    	cadena=cadena+"&"+mensaje_cadena();
    	
    	//alert(cadena+"&"+mensaje_cadena ());
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
    function cancelar(){
    	$( "#dialog-form" ).dialog( "close" );
    }
    </script>
    <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
    	<H2>NUEVA PREGUNTA</H2>
    		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">*Orden-Numero</div>
								<div class="col"><input type="text" id="orden_pregunta" name="orden_pregunta" size="10" /></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Pregunta</div>
								<div class="col"><textarea id="pregunta_pregunta" name="pregunta_pregunta" rows="3" cols="60"></textarea></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Categoria</div>
								<div class="col">
										<select id="categoria_pregunta" name="categoria_pregunta" >
													<option value="0" selected>SELECCIONE UNA CATEGORIA</option>
													<% for(int j=0; j<lista_cate.size();j++){ 
														CCategoria edi=lista_cate.get(j);%>
														<option value="<%=edi.getIdcategoria() %>" ><%=edi.getDescripcion() %></option>
													<% } %>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Tipo de Pregunta</div>
								<div class="col">
												<select id="tipo_pregunta" name="tipo_pregunta" onchange="tipo_pregunta()" >
													<option value="0"  selected>SELECCIONE UN TIPO DE PREGUNTA</option>
													<% for(int j=0; j<lista_tipo.size();j++){ 
														CTipo_Pregunta edi=lista_tipo.get(j);%>
														<option value="<%=edi.getIdtipo_pregunta() %>" ><%=edi.getDescripcion() %></option>
													<% } %>
												</select>
								</div>
							</div>
							<div class="fila">
								<div id="div_tipo_pregunta">
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Obligatoria</div>
								<div class="col">
									<input  type="radio" id="obligatoria1" name="obligatoria" value="1" class="check obligatoria"/><label for="obligatoria1">SI</label>
									<input  type="radio" id="obligatoria2" name="obligatoria" value="0" class="check obligatoria" CHECKED/><label for="obligatoria2">NO</label>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Estado</div>
								<div class="col">
									<select id="estado_pregunta" name="estado_pregunta"  >
													<option value="0" >DESHABILITADA</option>
													<option value="1" selected>HABILITADO</option>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Examenes</div>
								<div class="col">
									<input type="checkbox" name="auto_pregunta" id="auto_pregunta" class="check" /><label for="auto_pregunta">Examen de AutoEvaluaci&oacute;n</label>
									<input type="checkbox" name="multifa_pregunta" id="multifa_pregunta" class="check" /><label for="multifa_pregunta">Examen Multif&aacute;sico</label>										
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripcion</div>
								<div class="col">
										<textarea id="descripcion_pregunta" name="descripcion_pregunta" rows="2" cols="60"></textarea>
								</div>
							</div>
							
				</div>
			</div>
			<div class="center_button">
										<input type="button" onclick="preguntaForm()"  class="ui-state-default ui-corner-all button-save" value="Guardar" /> 
										<input type="button" onclick="cancelar()"  class="ui-state-default ui-corner-all button-save" value="Cancelar" />
					</div>	
							