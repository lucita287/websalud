		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <script>
    
    
    function CargarInicio(){
	$('#inicio_table').flexOptions({params : [{name: 'a', value: 'm_inicio'},{name: 'id', value:encabezado} ]});
	$('#inicio_table').flexReload();
	}

$(document).ready(function () {
	  
    $("#inicio_table").flexigrid
		({
			method: 'POST',
			url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'CAMBIAR', name : 'dd', width : 50, sortable : false, align: 'left'}, 
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
			          {name: 'a', value: 'm_inicio'},{name: 'id', value: encabezado} 
			        ]
			      
		});
 });
function InicioCondi(id){
	
	var action="updateInicio";
	  
	  cadena = [ 	'id_condicion='   + id,
	             	'id_encabezado=' + encabezado,
	             	'a='+action
	            ].join('&');
	  $.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	if(data.resultado=='OK'){
	        		CargarInicio();
	        	}
	        }
	    });
}
</script>
<label id="descrip_inicio" name="descrip_inicio"></label><br>
<table id="inicio_table" style="display:none"></table>
    