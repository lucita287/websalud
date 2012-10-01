		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
        <%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
<%@ page import="data.CUsuarioPermiso" %>
    <% 
    CDataExam dbo=new CDataExam();
    
    HttpSession sessiones = request.getSession(false);
    if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
    	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

    		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){

    
    if(dbo.Connect()){
    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
    Iterator<CTipo_Interpretacion> it=list.iterator();
    
    %>
				    <label id="descrip_result" name="descrip_result"></label><br>
				    <table id="result_table" style="display:none"></table>
				    Tipo de Interpretaci&oacute;n<select id="tipo_interpre_result" name="tipo_interpre_result" onchange="CambiarInter()">
				    								<option value="0">Seleccione un elemento</option>
													<% 
													Iterator<CTipo_Interpretacion> it2=list.iterator();
													while(it2.hasNext()){
														CTipo_Interpretacion ctipo=it2.next();
														%>
													  <option value="<%=ctipo.getIdtipo_interpretacion() %>"><%=ctipo.getDescripcion() %></option>
													<% } %>
					</select><br/>
					<select id="interp_result" name="interp_result">
					</select>
					<div class="center_button">
							<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarResult()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
														
													
							</div>
					
					<script>
					function GuardarResult(){
						if(encabezado>0){
							var action="guardarresult";
							  
							  cadena = [ 	'id_encabezado='   + encabezado,
							             	'a='+action,
								            'idinter='+$("#interp_result").val(),
								        ].join('&');
							  $.ajax({
							        url: "../SInterpretacion",
							        data: cadena,
							  	    type: 'post',
							        dataType: 'json',
							        success: function(data){
							        	mensaje(data.mensaje);
							        	if(data.resultado=='OK'){
							        		CargarResult();
							        	}
							        }
							    });	
						}else{
							mensaje("Debe seleccionar una Encabezado de condicion");
						}
					}
					function EliminarResult(id){
						var action="deleteencabe_result";
						  
						  cadena = [ 	'id_inter='   + id,
						             	'a='+action,
						             	'id_encabezado='   + encabezado,
						            ].join('&');
						  $.ajax({
						        url: "../SInterpretacion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        	if(data.resultado=='OK'){
						        		CargarResult();
						        	}
						        }
						    });
					}
					function CargarResult(){
						$('#result_table').flexOptions({params : [ {name: 'a', value: 'mresult_exam'}, {name: 'id', value: encabezado} ]});
						  $('#result_table').flexReload();
					}
					function CambiarInter(){
						 cadena = [ 	'idtipo='   + $("#tipo_interpre_result").val(),
						             	'a=showtipointer',
							        ].join('&');
				
						 
						  $('#interp_result').children().remove().end();
						  $.ajax({
						        url: "../SInterpretacion",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	var array = eval(data.menus);
						        	for (var i = 0; i < array.length; i++)
						        	{
						        		 $('#interp_result').append($("<option></option>")
							        	         .attr("value",array[i].idmenu)
							        	         .text(array[i].descripcion));
						        	}
						        }
							
						       }); 
						  	
					}
					$(document).ready(function () {
						  
					    $("#result_table").flexigrid
							({
								method: 'POST',
								url: '../SInterpretacionTable',
								 dataType : 'xml',
							    colModel: [
								{display: 'ELIMINAR', name : 'dd', width : 50, sortable : false, align: 'left'}, 
								{ display: 'ID', name: 'id', width: 30, sortable: false, align: 'left' },
								{ display: 'Titulo', name: 'pregunta', width: 350, sortable: false, align: 'left' }
								],
								showTableToggleBtn: true,
							    sortname: "id",
								sortorder: "desc",
							    title: 'Interpretacion',
							    useRp: false,
							    width: 650,
							    height: 200,
							    params : [ {name: 'a', value: 'mresult_exam'}, {name: 'id', value: encabezado} ]
								      
							});
					 });
					</script>
	<%
    dbo.Close();
    }
    		}	}
    
    %>