<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <script>
    $(function() {
		
		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 550,
			width: 800,
			modal: true
		});
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		
    });	
		  $(document).ready(function () {
			  
			     $("#Pregunta_table").flexigrid
					({
						method: 'POST',
						 url: '../SPreguntaTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'MODIFICAR', name : 'chkactividad', width : 50, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idpregunta', width: 30, sortable: true, align: 'left' },
						{ display: 'Orden', name: 'orden', width: 40, sortable: true, align: 'left' },
						{ display: 'Categoria', name: 'categoria', width: 80, sortable: true, align: 'left' },
						{ display: 'Pregunta', name: 'pregunta', width: 200, sortable: true, align: 'left' },
						{ display: 'Estado', name: 'estado', width: 80, sortable: true, align: 'left' },
						{ display: 'AutoEvaluacion', name: 'auto', width: 70, sortable: true, align: 'left' },
						{ display: 'Multifasico', name: 'multi', width: 60, sortable: true, align: 'left' }
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
					    rp: 15,
					    width: 710,
					    height: 300,
					    params : [ 
						          {name: 'a', value: 'preguntas'}//,{name: 'f_ini', value: ''},{name: 'f_fin', value: ''} 
						        ],
						searchitems : [
						   					{display: 'Pregunta', name : 'pregunta'},
						   					{display: 'Categoria', name : 'categoria'}
						    		],        
					});
			     $('.pSearch').click();
			  }); 
		  function Nuevo(com, grid){
			  $( "#dialog-form" ).load("modulo_examen/new_pregunta.jsp");
			  $( "#dialog-form" ).dialog( "open" );
		  }
		  function EditarPregunta(id){
			  $( "#dialog-form" ).load("modulo_examen/edit_pregunta.jsp?idpregunta="+id);
			  $( "#dialog-form" ).dialog( "open" );
		  }
	</script>	  
	<table id="Pregunta_table" style="display:none"></table>
	
	
	<div id="dialog-form" title="FORMULARIO DE PREGUNTA">
	</div>

	