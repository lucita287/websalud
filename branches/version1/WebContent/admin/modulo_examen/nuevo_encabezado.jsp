		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
        <%@ page import="framework.CValidation" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
<%@ page import="data.CEncabezado_Condicion" %>
<%@ page import="data.CUsuarioPermiso" %>
    <% 
    CValidation valid=new CValidation();
    HttpSession sessiones = request.getSession(false);
    
    if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
    	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

    		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){
				int idenca=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idenca")));
				int idtipo=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idtipo")));			
					    
					    CDataExam dbo=new CDataExam();
					    if(dbo.Connect()){
					    	CEncabezado_Condicion encabe=dbo.getEncabezado_CondicionEspecifico(idenca);
					    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
					    Iterator<CTipo_Interpretacion> it=list.iterator();
					    
					    
					    %>
					 <h2><%= (encabe==null)?"NUEVO":"EDITAR "+idenca %></h2>
					 Descripcion de la condici&oacute;n: <br>
					 <textarea rows="3" cols="70" id="texto_nuevo_enca" name="texto_nuevo_enca"><%= (encabe!=null)?encabe.getDescripcion():"" %></textarea>
					<select id="tipo2_nuevo_enca" name="tipo2_nuevo_enca">
					<% while(it.hasNext()){
						CTipo_Interpretacion ctipo=it.next();
						%>
					  <option value="<%=ctipo.getIdtipo_interpretacion() %>" <%= ((idtipo==ctipo.getIdtipo_interpretacion())?"SELECTED":"") %>><%=ctipo.getDescripcion() %></option>
					<% } %>
					</select>
						
						<div class="center_button">
															<input type="button" onclick="GuardarEncabeza()" class="ui-state-default ui-corner-all button-save" value="Guardar" />
															<input type="button"   class="ui-state-default ui-corner-all button-save" onclick="cancelar()" value="Cancelar" />		
										</div> 
						<script>
							function GuardarEncabeza(){
					
						    	cadena = [ 	'a=<%= (encabe==null)?"NuevoEncabezado":"EditarEncabezado"%>',
						    				'idencabezado=<%=idenca%>',
								            'tipo='+$("#tipo2_nuevo_enca").val(),
								            'descripcion='+$("#texto_nuevo_enca").val(),
								            
								        ].join('&');
						    	
						 		  $.ajax({
							        url: "../SInterpretacion",
							        data: cadena,
							  	    type: 'post',
							        dataType: 'json',
							        success: function(data){
							        	mensaje(data.mensaje);
							        	if(data.resultado=='OK'){
							        		cambiarTipo();
							        		cancelar();
							        	}
							        }
							    });
							}
							function cancelar(){
								$( "#dialog-form" ).dialog( "close" );
							}
						</script>
	<% } dbo.Close();	} 		} %>	
					