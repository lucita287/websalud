<%@ page import="data.CUsuarioPermiso" %>
<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){

%>

<label id="descrip_and_or" name="descrip_and_or"></label><br>
<table id="and_or_table" style="display:none"></table>
Condicion 1:
	<select id="condi1_and_or" name="condi1_and_or">
	</select>
<BR>
<select id="signo_and_or" name="signo_and_or">
  <option value="1">AND</option>
  <option value="2">OR</option>
</select>
<br>
Condicion 2:
	<select id="condi2_and_or" name="condi2_and_or">
	</select>
	
<div class="center_button">
<a  class="ui-state-default ui-corner-all button-save" onclick="Guardarand_or()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
</div>	
	
<script>
$(document).ready(function () {
	  
    $("#and_or_table").flexigrid
		({
			method: 'POST',
			url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'ELIMINAR', name : 'dd', width : 50, sortable : false, align: 'left'}, 
			{ display: 'ID', name: 'id', width: 30, sortable: false, align: 'left' },
			{ display: 'Condicion 1', name: 'pregunta', width: 200, sortable: false, align: 'left' },
			{ display: 'signo', name: 'signo', width: 100, sortable: false, align: 'left' },
			{ display: 'Condicion 2', name: 'valor', width: 200, sortable: false, align: 'left' }
			],
			showTableToggleBtn: true,
		    sortname: "id",
			sortorder: "desc",
		    title: 'Condicion',
		    useRp: false,
		    width: 650,
		    height: 200,
		    params : [ 
			          {name: 'a', value: 'm_and_or'},{name: 'id', value: encabezado} 
			        ]
			      
		});
 }); 
 function EliminarAndOr(id){
	 var action="deletecondicion";
	  
	  cadena = [ 	'id_condicion='   + id,
	             	'a='+action
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
 }
function CargarAnd_OrCondicion(){
	$('#and_or_table').flexOptions({params : [{name: 'a', value: 'm_and_or'},{name: 'id', value:encabezado} ]});
	  $('#and_or_table').flexReload();
	
}
function Guardarand_or(){
	if(encabezado>0){
		var action="guardar_and_or";
		  
		  cadena = [ 	'id_encabezado='   + encabezado,
		             	'a='+action,
			            'condicion1='+$("#condi1_and_or").val(),
			            'tipo='+$("#signo_and_or").val(),
			            'condicion2='+$("#condi2_and_or").val(),
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
function cambiarCondiciones(){
	 
	  cadena = [ 	'idencabe='   + encabezado,
	             	'a=showcondiciones',
		        ].join('&');

	 
	  $('#condi1_and_or').children().remove().end();
	  $('#condi2_and_or').children().remove().end();
	  $('#condi_paren').children().remove().end();
	  $.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	var array = eval(data.menus);
	        	for (var i = 0; i < array.length; i++)
	        	{
	        		 $('#condi1_and_or').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        		 $('#condi2_and_or').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        		 $('#condi_paren').append($("<option></option>")
		        	         .attr("value",array[i].idmenu)
		        	         .text(array[i].descripcion));
	        	}
	        }
		
	       }); 
	  
}
</script>
<% }	} %>