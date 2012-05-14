<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="framework.CDataExam" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
		<script  type="text/javascript">
<%
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
ArrayList<Integer> lista=dbo.listaAniosCitas();
java.util.GregorianCalendar calendar=new java.util.GregorianCalendar();	
int month=calendar.get(java.util.GregorianCalendar.MONTH);
int year=calendar.get(java.util.GregorianCalendar.YEAR);
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
							{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
							{ display: 'ID', name: 'idcita', width: 40, sortable: true, align: 'left' },
							{ display: 'Fecha', name: 'fecha', width: 80, sortable: true, align: 'left' },
							{ display: 'Fecha Descripcion', name: 'fecha_descripcion', width: 140, align: 'left' },
							{ display: 'Hora Inicio', name: 'hora_', width: 90, sortable: true, align: 'left' },
							{ display: 'Tipo de Examen', name: 'tipo', width: 100, sortable: true, align: 'left' },
							{ display: 'Cupo', name: 'cupo', width: 90, sortable: true, align: 'left' },
							{ display: 'Cupo Disponible', name: 'cupod', width: 90, sortable: true, align: 'left' }
							],
							showTableToggleBtn: true,
						    usepager: true,
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
				        		document.location.href="index.jsp?portal=2";
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
			  function Cancelar(){
					$( "#dialog-form" ).dialog( "close" );
					document.location.href="index.jsp?portal=2";
				}
			</script>
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
				
				<input onclick="BuscarFecha()" type="radio" name="exam" id="multi_exam" class="buscar" value="1" /><label for="multi_exam">MULTIF&Aacute;SICO</label>
				<input onclick="BuscarFecha()" type="radio" name="exam" id="auto_exam" class="buscar" value="2" /><label for="auto_exam">AUTOEVALUACI&Oacute;N</label>
				<input onclick="BuscarFecha()" type="radio" name="exam" id="ambos_exam" class="buscar" value="3" checked/><label for="ambos_exam">AMBOS</label>
				<hr/>
			</center>
			
			<table id="fecha_citas" style="display:none"></table>
					
<% dbo.Close(); } %>			