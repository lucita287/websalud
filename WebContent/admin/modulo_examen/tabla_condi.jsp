		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
<% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
    Iterator<CTipo_Interpretacion> it=list.iterator();
    %>
 <select id="tipo_nuevo_enca" name="tipo_nuevo_enca" onchange="cambiarTipo()">
<% while(it.hasNext()){
	CTipo_Interpretacion ctipo=it.next();
	%>
  <option value="<%=ctipo.getIdtipo_interpretacion() %>"><%=ctipo.getDescripcion() %></option>
<% } %>
</select> 
<script>

function cambiarTipo(){
	 $('#Pregunta_table').flexOptions({params : [{name: 'a', value: 'condicional'},{name: 'idtipo', value:$("#tipo_nuevo_enca").val()}]});
	  $('#Pregunta_table').flexReload();
	
}

$(document).ready(function () {
	  
    $("#Pregunta_table").flexigrid
		({
			method: 'POST',
			url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'SELECCIONAR', name : 'chkcondicion', width : 70, sortable : false, align: 'left'}, 
			{display: 'ELIMINAR', name : 'ddcondicion', width : 50, sortable : false, align: 'left'}, 
			{ display: 'ID', name: 'idcondicion', width: 30, sortable: true, align: 'left' },
			{ display: 'Descripcion', name: 'descripcion', width: 250, sortable: true, align: 'left' },
			{ display: 'Tipo', name: 'tipo', width: 200, sortable: true, align: 'left' }
			],
			buttons : [
			   		{name: 'Nuevo', bclass: 'add', onpress : Nuevo}
			   		
			],
			showTableToggleBtn: true,
		    usepager: true,
		    sortname: "idpregunta",
			sortorder: "desc",
		    title: 'Pregunta',
		    useRp: true,
		    rp: 20,
		    width: 660,
		    height: 300,
		    params : [ 
			          {name: 'a', value: 'condicional'},{name: 'idtipo', value:$("#tipo_nuevo_enca").val()} 
			        ],
			searchitems : [
			   					{display: 'Pregunta', name : 'pregunta'}
			    		],        
		});
    $('.pSearch').click();
 }); 
function Nuevo(com, grid){
	  $( "#dialog-form" ).load("modulo_examen/nuevo_encabezado.jsp");
	   $( "#dialog-form" ).dialog( "open" );
}
var encabezado=0;
function ElimCondicion(id){
	
	alert(id);
}
function EditarEncabezado(id){
	encabezado=id;
	
	cadena = [ 'a=show_condicion',
	            'id_encabezado='     + encabezado,
	        ].join('&');
	$.ajax({
        url: "../SInterpretacion",
        data: cadena,
  	    type: 'post',
  	    
        success: function(data){
        	
        	result=eval("("+data+")");
        	    $("#titulo_condicion").text(result.descripcion);
        	}
    });
	CargarCondicion();
}
$(function() {
	
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		height: 300,
		width: 600,
		modal: true
	});
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	
});
</script>
<table id="Pregunta_table" style="display:none"></table>
	<div id="dialog-form" title="FORMULARIO DE PREGUNTA">
	</div>
	 <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
<% dbo.Close(); } %>