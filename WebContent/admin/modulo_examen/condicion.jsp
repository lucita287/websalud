<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CCategoria" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
ArrayList<CCategoria> lista=dbo.getListaCategoria();
Iterator<CCategoria> it=lista.iterator();
%>
<label id="titulo_condicion"></label>
<table id="condicion_table" style="display:none"></table>
Pregunta:
<div style="border-style:solid; border-width:2px;border-color:#728FCE;">
Categoria <select id="categoria_condicion" name="categoria_condicion" onchange="cambiarCategoria()">
<option value="0">SELECCIONE CATEGORIA</option>
<% while(it.hasNext()){ 
	CCategoria cat=it.next();
	%>
  <option value="<%=cat.getIdcategoria() %>"><%=cat.getDescripcion() %></option>

<% } %>  
</select><br/>

Pregunta
<select id="new-submenu" name="new-submenu">
</select>
</div>
Condici&oacute;n:
<select id="signo_condicion" name="signo_condicion">
	<option value="1">Mayor</option>
	<option value="2">Menor</option>
	<option value="3">Mayor igual</option>
	<option value="4">Menor igual</option>
	<option value="5">igual</option>
	<option value="6">no igual</option>
</select>

Valor: <input type="text" size="10" id="valor_condicion" name="valor" />
<div style="clear: both;"></div>
<div class="center_button">
<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarCondicional()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
</div>
<script>
function limpiarCondicion(){
	$("#valor_condicion").val(0);
	$("#categoria_condicion").val(0);
	cambiarCategoria();
}
function GuardarCondicional(){
	if(encabezado>0){
		var action="guardarcond";
		  
		  cadena = [ 	'id_encabezado='   + encabezado,
		             	'a='+action,
			            'idpregunta='+$("#new-submenu").val(),
			            'signo='+$("#signo_condicion").val(),
			            'valor='+$("#valor_condicion").val(),
			        ].join('&');
		  $.ajax({
		        url: "../SInterpretacion",
		        data: cadena,
		  	    type: 'post',
		        dataType: 'json',
		        success: function(data){
		        	mensaje(data.mensaje);
		        	if(data.resultado=='OK'){
		        		limpiarCondicion();
		        		CargarCondicion();
		        	}
		        }
		    });	
	}else{
		mensaje("Debe seleccionar una Encabezado de condicion");
	}
}
function cambiarCategoria(){
	 
	  cadena = [ 	'idcate='   + $("#categoria_condicion").val(),
	             	'a=showsubpreguntas',
		        ].join('&');

	 
	  $('#new-submenu').children().remove().end();
	  $.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	var array = eval(data.menus);
	        	for (var i = 0; i < array.length; i++)
	        	{
	        		 $('#new-submenu').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        	}
	        }
		
	       }); 
	  
}
	function EliminarCond(id){
		alert(id);
	}
$(document).ready(function () {
	  
    $("#condicion_table").flexigrid
		({
			method: 'POST',
			url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'ELIMINAR', name : 'dd', width : 50, sortable : false, align: 'left'}, 
			{ display: 'ID', name: 'id', width: 30, sortable: false, align: 'left' },
			{ display: 'Pregunta', name: 'pregunta', width: 250, sortable: false, align: 'left' },
			{ display: 'signo', name: 'signo', width: 100, sortable: false, align: 'left' },
			{ display: 'valor', name: 'valor', width: 50, sortable: false, align: 'left' }
			],
			showTableToggleBtn: true,
		    sortname: "id",
			sortorder: "desc",
		    title: 'Condicion',
		    useRp: false,
		    width: 650,
		    height: 200,
		    params : [ 
			          {name: 'a', value: 'mcondicion'},{name: 'id', value:encabezado} 
			        ]
			      
		});
    $('.pSearch').click();
 }); 
function CargarCondicion(){
	$('#condicion_table').flexOptions({params : [{name: 'a', value: 'mcondicion'},{name: 'id', value:encabezado} ]});
	  $('#condicion_table').flexReload();
}
</script>

<% dbo.Close(); } %>	