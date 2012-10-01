<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="framework.CDataExam" %>
<%@page import="framework.CValidation" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
		<script  type="text/javascript">
<%
HttpSession sessiones=request.getSession(false); 		 	
if(sessiones!=null && sessiones.getAttribute("user_secretaria")!=null){
CDataExam dbo=new CDataExam();
//mes="+$("mes").val()+"&exam="+$("input[@name='exam']:checked").val()+"&anio="+$("#anio").val();
CValidation valid=new CValidation();
int mes=valid.ConvertEntero(valid.ValidarRequest( request.getParameter("mes")))-1;
int exam=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("exam")));
int anio=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("anio")));
int examv=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("exam")));
if(dbo.Connect()){
ArrayList<Integer> lista=dbo.listaAniosCitas();
java.util.GregorianCalendar calendar=new java.util.GregorianCalendar();	
int month=0;
if(mes==-1) month=calendar.get(java.util.GregorianCalendar.MONTH);
else month=mes;
int year=0;
if(anio==0) year=calendar.get(java.util.GregorianCalendar.YEAR);
else year=anio;
%>			
		  $(function() {
				$( ".buscar" ).button();
			});
			  $(document).ready(function () {
				     $("#fecha_citas").flexigrid
						({
							method: 'POST',
							url: '../SCitaTable',
							dataType : 'xml',
						    colModel: [
							{display: 'Seleccionar', name : 'chkactividad', width : 35, sortable : false, align: 'left'},
							{display: 'Eliminar', name : 'chkdelete', width : 35, sortable : false, align: 'left'},
							{display: 'Estado', name : 'chkdelete', width : 35, sortable : false, align: 'left'},
							{ display: 'ID', name: 'idcita', width: 30, sortable: true, align: 'left' },
							{ display: 'Fecha', name: 'fecha', width: 60, sortable: true, align: 'left' },
							{ display: 'Fecha Descripcion', name: 'fecha_descripcion', width: 120, align: 'left' },
							{ display: 'Hora Inicio', name: 'hora_', width: 60, sortable: true, align: 'left' },
							{ display: 'Tipo de Examen', name: 'tipo', width: 100, sortable: true, align: 'left' },
							{ display: 'Cupo', name: 'cupo', width: 50, sortable: true, align: 'left' },
							{ display: 'Asignados', name: 'cupod', width: 50, sortable: true, align: 'left' }
							],
							showTableToggleBtn: true,
						    buttons : [
								   		{name: 'Nuevo Semanal', bclass: 'add', onpress : Nuevo},
								   		{name: 'Nuevo Especifico', bclass: 'add', onpress : Nuevo}
								],
						    sortname: "idcita",
							sortorder: "desc",
						    title: 'FECHAS CITAS',
						    width: 800,
						    height: 400,
							params : [{name: 'mes', value: $("#mes").val()},{name: 'a',value:'allcitas'},{name: 'anio', value: $("#anio").val()},{name: 'tipo_examen', value: $("input[@name='exam']:checked").val()}]
						});
				  });  
			  function BuscarFecha(){
				  $('#fecha_citas').flexOptions({params : [{name: 'mes', value: $("#mes").val()},{name: 'a',value:'allcitas'},{name: 'anio', value: $("#anio").val()},{name: 'tipo_examen', value: $("input[@name='exam']:checked").val()}]});
				  $('#fecha_citas').flexReload();
			  }
			  function Modificar(id){
				  $( "#dialog-form" ).load("modulo_secre/modifi_cita.jsp?idcita="+id);
				  $( "#dialog-form" ).dialog( "open" );
			  }
			  function limpiar_cita(){
				  BuscarFecha();
				  $("#r_fecha_inicio").val("");
				  $("#r_fecha_fin").val("");
				  $("#r_hora_inicio").val("");
				  $("#r_cupo").val("");
				  $("#r_fecha1").val("");
		          $("#r_hora1").val("");
		          $("#r_tipo_examen1").val("");
		          $("#r_cupo1").val();
		          $("#r_estado").val(1);
				  $(".semana").attr('checked', false);
				  $(".semana").button('refresh');
				  BuscarFecha();
				  
			}
			  function mensaje2(mensaje){
				  $( "#dialog-message" ).html(mensaje);
					$( "#dialog-message" ).dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
								limpiar_cita();
				        		$( "#dialog-form" ).dialog( "close" );
				        		document.location.href="index.jsp?portal=2&mes="+$("#mes").val()+"&exam="+$("input[@name='exam']:checked").val()+"&anio="+$("#anio").val();
							}
						}
					});	
			}
			  function mensaje3(mens){
				  
				  $( "#dialog-message" ).html(mens);
					$( "#dialog-message" ).dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						}
					});
			  }
			  $(function() {
					
					$( "#dialog-form" ).dialog({
						autoOpen: false,
						height: 450,
						width: 800,
						modal: true
					});
					$( "#dialog:ui-dialog" ).dialog( "destroy" );
					
			    });	
			  
			  function Nuevo(com, grid){
				  if(com=="Nuevo Semanal"){
					  $( "#dialog-form" ).load("modulo_secre/nueva_cita.jsp");
					  $( "#dialog-form" ).dialog( "open" );
				  }else if(com=="Nuevo Especifico"){
					  $( "#dialog-form" ).load("modulo_secre/nueva_cita_e.jsp");
					  $( "#dialog-form" ).dialog( "open" );
				  }
			  }
			  function Delete(id){
				  cadena = [ 'a=deleteespecifico',
					            'idcita='+id
					        ].join('&');
				  $.ajax({
				        url: "../SCita",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		limpiar_cita();
				        		$( "#dialog-form" ).dialog( "close" );
				        	}
				        }
				    });
			  }
			  function Estado(id){
				  cadena = [ 'a=estadoespecifico',
					            'idcita='+id
					        ].join('&');
				  $.ajax({
				        url: "../SCita",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        		limpiar_cita();
				        		
				        }
				    });
			  }
			  function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					document.location.href="index.jsp?portal=2&mes="+$("#mes").val()+"&exam="+$("input[@name='exam']:checked").val()+"&anio="+$("#anio").val();
				}
			  
			</script>
			<style>
			#label_estado { width:130px;  padding: 0.4em; background: #fff; }
			#label_estado h3 { margin: 0; padding: 0.4em; text-align: center; }
			</style>
			<div id="dialog-form" title="Citas">
			</div>
			<center>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			
			Mes: <select id="mes" onchange="BuscarFecha()">
					<option value="1" <%= (month==0)?"selected":"" %>>Enero</option>
					<option value="2" <%= (month==1)?"selected":"" %> >Febrero</option>
					<option value="3" <%= (month==2)?"selected":"" %> >Marzo</option>
					<option value="4" <%= (month==3)?"selected":"" %> >Abril</option>
					<option value="5" <%= (month==4)?"selected":"" %> >Mayo</option>
					<option value="6" <%= (month==5)?"selected":"" %> >Junio</option>
					<option value="7" <%= (month==6)?"selected":"" %> >Julio</option>
					<option value="8" <%= (month==7)?"selected":"" %> >Agosto</option>
					<option value="9" <%= (month==8)?"selected":"" %> >Septiembre</option>
					<option value="10" <%= (month==9)?"selected":"" %> >Octubre</option>
					<option value="11" <%= (month==10)?"selected":"" %> >Noviembre</option>
					<option value="12" <%= (month==11)?"selected":"" %> >Diciembre</option>
				</select>	
			A&ntilde;o: <select id="anio" onchange="BuscarFecha()">
					<% 
					Iterator<Integer> it=lista.iterator();
					while(it.hasNext()){
						Integer num=it.next();
					%>
						<option value="<%=num %>" <%= (year==num)?"selected":"" %>><%=num %></option>
					<% } %>
					
				</select>
				
				<input onclick="BuscarFecha()" type="radio" name="exam" id="multi_exam" class="buscar" value="1" <%=(examv==1)?"checked":""%> /><label for="multi_exam">MULTIF&Aacute;SICO</label>
				<input onclick="BuscarFecha()" type="radio" name="exam" id="auto_exam" class="buscar" value="2" <%=(examv==2)?"checked":""%> /><label for="auto_exam">AUTOEVALUACI&Oacute;N</label>
				<input onclick="BuscarFecha()" type="radio" name="exam" id="ambos_exam" class="buscar" value="3" <%=(examv==3||examv==0)?"checked":""%> /><label for="ambos_exam">AMBOS</label>
				<hr/>
			</center>
			<div style="float:left; width:800px;">
			<table id="fecha_citas" style="display:none"></table>
			</div>
			<%
			String estado1="../images/close.png";
			String estado2="../images/on.png";
			String estado3="../images/web.png";
			%>
			<div style="float:left; width:150px;">
				<div id="label_estado" class="ui-widget-content ui-corner-all">
										<h3 class="ui-widget-header ui-corner-all">Estados</h3>
										<img src="<%= estado1 %>"  width='18px' height='18px' /> CERRADO<BR/>
										<img src="<%= estado2 %>"  width='18px' height='18px' /> HABILITADA<BR/>
										<img src="<%= estado3 %>"  width='18px' height='18px' /> VIA WEB<BR/>
				</div>						
			</div>
			<div style="clear: both;"></div>		
<% dbo.Close(); } } %>			