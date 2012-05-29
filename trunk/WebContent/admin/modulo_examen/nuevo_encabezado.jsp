		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
<%@ page import="data.CUsuarioPermiso" %>
    <% 
    HttpSession sessiones = request.getSession(false);
    if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
    	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

    		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){

					    
					    CDataExam dbo=new CDataExam();
					    if(dbo.Connect()){
					    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
					    Iterator<CTipo_Interpretacion> it=list.iterator();
					    %>
					 
					 Descripcion de la condici&oacute;n: <br>
					 <textarea rows="3" cols="70" id="texto_nuevo_enca" name="texto_nuevo_enca"></textarea>
					
						
						<div class="center_button">
															<input type="button" onclick="GuardarEncabeza()" class="ui-state-default ui-corner-all button-save" value="Guardar" />
															<input type="button"   class="ui-state-default ui-corner-all button-save" onclick="cancelar()" value="Cancelar" />		
										</div> 
						<script>
							function GuardarEncabeza(){
					
						    	cadena = [ 	'a=NuevoEncabezado',
								            'tipo='+$("#tipo_nuevo_enca").val(),
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
	<% }	}		} %>	
					