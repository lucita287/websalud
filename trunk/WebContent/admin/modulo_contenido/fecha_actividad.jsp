<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="data.CUsuarioPermiso" %>    
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

	if (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>		
	
    <script  type="text/javascript">
			
			  $(document).ready(function () {
				  
				  $( ".buscar" ).button({
			            icons: {
			                primary: "ui-icon-search"
			            }}); 
			     $("#fecha_actividad").flexigrid
					({
						method: 'POST',
						 url: '../SFecha_actividadTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idfecha_actividad', width: 40, sortable: true, align: 'left' },
						{ display: 'Fecha', name: 'fecha', width: 80, sortable: true, align: 'left' },
						{ display: 'Fecha Descripcion', name: 'fecha_descripcion', width: 140, align: 'left' },
						{ display: 'Hora Inicio', name: 'hora_inicio', width: 90, sortable: true, align: 'left' },
						{ display: 'Hora Fin', name: 'hora_fin', width: 90, sortable: true, align: 'left' }
						],
						<% if (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
						buttons : [
						   		{name: 'Eliminar', bclass: 'delete', onpress : EliminarFecha},
						   		{name: 'Eliminar Todos', bclass: 'delete', onpress : EliminarFecha}
						],
						<%}%>
						showTableToggleBtn: true,
					    usepager: true,
					    sortname: "idfecha_actividad",
						sortorder: "desc",
					    title: 'ACTIVIDADES FECHAS',
					    useRp: true,
					    rp: 15,
					    width: 600,
					    height: 200,
						params : [ 
						          {name: 'idactividad', value: 0},{name: 'f_ini', value: ''},{name: 'f_fin', value: ''} 
						        ], 
					});
			  });  
			  $(function() {
				  $( ".datepicker" ).datepicker();
					$(".time").mask("99:99");
					$(".datepicker").mask("99/99/9999");
					$( ".datepicker" ).datepicker( "option", "dateFormat", "dd/mm/yy");
				});
			  
			  function GuardarRango(){
				  cadena = [ 'a=guardar_rango',
					            'idactividad='     + idactividad,
					            'fecha_inicio='+Base64.encode($("#r_fecha_inicio").val()+" "),
					            'fecha_fin='+Base64.encode($("#r_fecha_fin").val()+" "),
					            'hora_inicio='+Base64.encode($("#r_hora_inicio").val()+" "),
					            'hora_inicio_mm='+$("#horario_rh_inicio").val(),
					            'hora_fin='+Base64.encode($("#r_hora_fin").val()+" "),
					            'hora_fin_mm='+$("#horario_rh_fin").val(),
					            'lunes='+(($("#lunes").is(":checked")==true)?1:0),
					            'martes='+(($("#martes").is(":checked")==true)?1:0),
					            'miercoles='+(($("#miercoles").is(":checked")==true)?1:0),
					            'jueves='+(($("#jueves").is(":checked")==true)?1:0),
					            'viernes='+(($("#viernes").is(":checked")==true)?1:0),
					            'sabado='+(($("#sabado").is(":checked")==true)?1:0),
					            'domingo='+(($("#domingo").is(":checked")==true)?1:0),
					        ].join('&');
				  $.ajax({
				        url: "../SFecha_actividad",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		limpiar_fecha_actividad();
				        	}
				        }
				    });
			  }
			  function GuardarEspecifico(){
				  cadena = [ 'a=guardarespecifico',
					            'idactividad='     + idactividad,
					            'fecha='+Base64.encode($("#r_fecha").val()+" "),
					            'hora_inicio='+Base64.encode($("#r_hora_inicio1").val()+" "),
					            'hora_inicio_mm='+$("#horario_rh_inicio1").val(),
					            'hora_fin='+Base64.encode($("#r_hora_fin1").val()+" "),
					            'hora_fin_mm='+$("#horario_rh_fin1").val(),
					        ].join('&');
				  $.ajax({
				        url: "../SFecha_actividad",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		limpiar_fecha_actividad();
				        	}
				        }
				    });
			  }
			  function limpiar_fecha_actividad(){
				  $("#r_fecha").val("");
				  $("#r_hora_inicio1").val("");
				  $("#r_hora_fin1").val("");
				  $("#r_fecha_inicio").val("");
				  $("#r_fecha_fin").val("");
				  $("#r_hora_inicio").val("");
				  $("#r_hora_fin").val("");
				  $("#fe_ini_buscar").val("");
				  $("#fe_fin_buscar").val("");
				  $(".semana").attr('checked', false);
				  $('#fecha_actividad').flexReload();
			  }
			  function EliminarFecha(com, grid){
				  if(com=="Eliminar"){
						  	var array_values = [];
								$('.dele_activity').each( function() {
								    if( $(this).is(':checked') ) {
								        array_values.push( $(this).val() );
								    }
								});
								var arrayValues = array_values.join(',');
								cadena = [ 'a=eliminar_especifico',
								            'idactividad='     + idactividad,
								            'check_det_actividad='+arrayValues,
								            
								        ].join('&');
							  $.ajax({
							        url: "../SFecha_actividad",
							        data: cadena,
							  	    type: 'post',
							        dataType: 'json',
							        success: function(data){
							        	mensaje(data.mensaje);
							        	if(data.resultado=='OK'){
							        		limpiar_fecha_actividad();
							        	}
							        }
							    });
				  }else{
					  cadena = [ 'a=eliminar_todos',
						            'idactividad='     + idactividad,
						        ].join('&');
					  $.ajax({
					        url: "../SFecha_actividad",
					        data: cadena,
					  	    type: 'post',
					        dataType: 'json',
					        success: function(data){
					        	mensaje(data.mensaje);
					        	if(data.resultado=='OK'){
					        		limpiar_fecha_actividad();
					        	}
					        }
					    });
				  }		  
			  }
			  function BuscarFecha(){
				  $('#fecha_actividad').flexOptions({params : [{name: 'idactividad', value: idactividad}, {name: 'f_ini', value: $("#fe_ini_buscar").val()},{name: 'f_fin', value: $("#fe_fin_buscar").val()} ]});
				  $('#fecha_actividad').flexReload();
			  }
			</script>
			<center>
			<div style="width:600px;">
			<B>ID: </B><label id="id_actividad_f"></label> <br><B>TITULO: </B><label id="titulo_actividad_f">SELECCIONE UNA ACTIVIDAD</label> 

			</div>
			</center>
			
			<% if (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
			<div class="caja_gris">
						<h5>PERIODOS DE FECHAS</h5>
								<table>	
									<tr>
										<td>Fecha Inicio</td>
										<td><input type="text" id="r_fecha_inicio" size="10" class="datepicker"/></td>
										<td>Fecha Fin</td>
										<td><input type="text" id="r_fecha_fin" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" id="r_hora_inicio" type="text" class="time"/> 
											<select id="horario_rh_inicio">
											<option value="AM">AM</option>
											<option value="PM">PM</option>
											</select>
										</td>
										<td>Hora Fin</td>
										<td><input size="10" id="r_hora_fin" type="text" class="time"/> 
											<select id="horario_rh_fin">
											<option value="AM">AM</option>
											<option value="PM">PM</option>
											</select>
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<div style="font-size: 12px;">	
												<input type="checkbox" id="lunes"  class="semana" value="1"> LUNES 
												<input type="checkbox" id="martes" class="semana" value="1"> MARTES 
												<input type="checkbox" id="miercoles" class="semana" value="1"> MIERCOLES
												<input type="checkbox" id="jueves" class="semana" value="1"> JUEVES
												<input type="checkbox" id="viernes" class="semana" value="1"> VIERNES
												<input type="checkbox" id="sabado" class="semana" value="1"> SABADO
												<input type="checkbox" id="domingo" class="semana" value="1"> DOMINGO
											</div>	
										</td>
									</tr>
									
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarRango()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
						<div class="caja_gris">
						<h5>FECHA ESPECIFICA</h5>
								<table>	
									<tr>
										<td>Fecha</td>
										<td><input type="text" id="r_fecha" size="10" class="datepicker"/></td>
									</tr>
									<tr>	
										<td>Hora Inicio</td>
										<td><input size="10" id="r_hora_inicio1" type="text" class="time"/> 
											<select id="horario_rh_inicio1">
											<option value="AM">AM</option>
											<option value="PM">PM</option>
											</select>
										</td>
										<td>Hora Fin</td>
										<td><input size="10" id="r_hora_fin1" type="text" class="time"/> 
											<select  id="horario_rh_fin1">
											<option value="AM">AM</option>
											<option value="PM">PM</option>
											</select>
										</td>
									</tr>
								</table>
								<div style="float:right; margin-top:20px; margin-bottom:20px;">
								<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarEspecifico()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
								</div>
								<div style="clear: both;"></div>
						</div>
						
						Fecha Inicio: <input  type="text" id="fe_ini_buscar" size="10" class="datepicker"/> Fecha Fin: <input type="text" id="fe_fin_buscar" size="10" class="datepicker"/> 
			<button class="buscar" onclick="BuscarFecha()">Buscar</button>
			<div class="fecha_tabla">
			
			<table id="fecha_actividad" style="display:none"></table>
			</div>			
		<%} %>							
<%	}	} %>					