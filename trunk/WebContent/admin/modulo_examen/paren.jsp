
<%@ page import="data.CUsuarioPermiso" %>

<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){

%>
<script>
function GuardarPAREN(){
	if(encabezado>0){
		var action="guardar_paren";
		  
		  cadena = [ 	'id_encabezado='   + encabezado,
		             	'a='+action,
			            'condicion='+$("#condi_paren").val(),
			            'tipo='+$("#signo_paren").val()
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
		        	}
		        }
		    });	
	}else{
		mensaje("Debe seleccionar una Encabezado de condicion");
	}
}
function CargarParentesis(){
	$('#paren_table').flexOptions({params : [{name: 'a', value: 'm_paren'},{name: 'id', value:encabezado} ]});
	  $('#paren_table').flexReload();
	
}

$(document).ready(function () {
	  
    $("#paren_table").flexigrid
		({
			method: 'POST',
			url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'ELIMINAR', name : 'dd', width : 50, sortable : false, align: 'left'}, 
			{ display: 'ID', name: 'id', width: 30, sortable: false, align: 'left' },
			{ display: 'Condicion 1', name: 'pregunta', width: 350, sortable: false, align: 'left' },
			{ display: 'signo', name: 'signo', width: 100, sortable: false, align: 'left' }
			],
			showTableToggleBtn: true,
		    sortname: "id",
			sortorder: "desc",
		    title: 'Condicion',
		    useRp: false,
		    width: 650,
		    height: 200,
		    params : [ 
			          {name: 'a', value: 'm_paren'},{name: 'id', value: encabezado} 
			        ]
			      
		});
 });
</script>
<label id="descrip_paren" name="descrip_paren"></label><br>
<table id="paren_table" style="display:none"></table>


Condicion:
	<select id="condi_paren" name="condi_paren">
	</select>
<BR>
<select id="signo_paren" name="signo_paren">
  <option value="3">PARENTESIS</option>
  <option value="4">NOT</option>
</select>	
<div class="center_button">
<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarPAREN()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
</div>
<% }	} %>	