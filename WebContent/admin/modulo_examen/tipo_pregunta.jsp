<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CValidation" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CTipo_Pregunta" %>
<%@ page import="data.CTitulo_Respuesta" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>

    <script>
    $(function() {
		$( ".check_tipo" ).button();
	});
        
    </script>


<%
		CValidation valid=new CValidation();
		int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idtipo_pregunta")));
		CDataExam data=new CDataExam();
		data.Connect();
		
		if(idtipo<=1){%>
			<script>
			function mensaje_cadena (){
				return "";
			}
			</script>
		
		
		
		
		
		
		
		
		<%} if(idtipo==2){%>
			<script>
			function mensaje_cadena (){
				cadena = ['size_pregunta='+$("#size_pregunta").val(),].join('&');
				return cadena;
			}	
			</script>
			<div class="fila">
								<div class="col_titulo">*Tama&ntilde;o</div>
								<div class="col">
									<select id="size_pregunta" name="size_pregunta" >
													<option value="0"  selected>SELECCIONE EL TAMA&Ntilde;O</option>
													<option value="1"  >PEQUE&Ntilde;O</option>
													<option value="2"  >MEDIANO</option>
													<option value="3"  >GRANDE</option>
									</select>
								</div>
			</div>		
		<% }
		
		
		
		
			
		
		
		
		
		
		
		if(idtipo==3){%>
		<script>
		 $(document).ready(function () {
			 mult_cantidad();
	    });
		 function mult_cantidad(){
		    	$("#div_pregunta_multiple").load("modulo_examen/multiple_respuesta.jsp?cantidad="+$("#cantidad_opc_pregunta").val());
		    }
		</script>
			<div class="fila">
								<div class="col_titulo">*Opcion Multiple</div>
								<div class="col">
									<input  type="radio" id="multiple1" name="multiple" value="1" class="check_tipo multiple"/><label for="multiple1">SI</label>
									<input  type="radio" id="multiple2" name="multiple" value="0" class="check_tipo multiple" CHECKED/><label for="multiple2">NO</label>
								</div>
			</div>
			<div class="fila">
								<div class="col_titulo">*Cantidad de Opciones</div>
								<div class="col">
									<select id="cantidad_opc_pregunta" name="cantidad_opc_pregunta"  onchange="mult_cantidad()" >
													<option value="0"  selected>SELECCIONE LA CANTIDAD</option>
													<% for(int j=1; j<16;j++){ %>
													<option value="<%=j%>" ><%=j%></option>
													<% } %>
									</select>
								</div>
								<div id="div_pregunta_multiple">
								</div>
			</div>
		<%}
		
		
		
		
		
		
		
		
		
		
		
		
		
		if(idtipo>=4){	
			%>
			<script>
				function mensaje_cadena (){
					cadena = [ 	
					          'multiple='+$("input[name='multiple']:checked").val(),
					<%CTipo_Pregunta tipo= data.getTipo_PreguntaEspecifica(idtipo);
					Iterator<CTitulo_Respuesta> it2=tipo.getIdgrupo_titulo_respuesta().iterator();	
					while(it2.hasNext()){
						CTitulo_Respuesta titulo=it2.next();	
							%>'ponderacion<%= titulo.getIdtitulo_respuesta() %>='+$('#ponderacion<%= titulo.getIdtitulo_respuesta() %>').val(),   
					<%}%>
							].join('&');
					return cadena;
				}
			</script>
			<div class="fila">
								<div class="col_titulo">*Opcion Multiple</div>
								<div class="col">
									<input  type="radio" id="multiple1" name="multiple" value="1" class="check_tipo multiple"/><label for="multiple1">SI</label>
									<input  type="radio" id="multiple2" name="multiple" value="0" class="check_tipo multiple" CHECKED/><label for="multiple2">NO</label>
								</div>
			</div>
			<%
			Iterator<CTitulo_Respuesta> it=tipo.getIdgrupo_titulo_respuesta().iterator();	
			while(it.hasNext()){
				CTitulo_Respuesta titulo=it.next();	
			
		%>
		
			<div class="fila">
								<div class="col_titulo">*<%=titulo.getDescripcion() %>, PONDERACION</div>
								<div class="col">
									<input type="text" size="6" id="ponderacion<%= titulo.getIdtitulo_respuesta() %>" name="ponderacion<%= titulo.getDescripcion() %>"/>
								</div>
			</div>		
		<% }
		}
		data.Close();
		}	}
%>		
