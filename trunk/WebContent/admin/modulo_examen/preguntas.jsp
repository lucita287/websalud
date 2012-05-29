<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CCategoria" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){

		CDataExam dbo=new CDataExam();
		if(dbo.Connect()){
		ArrayList<CCategoria> lista=dbo.getListaCategoria();
		Iterator<CCategoria> it=lista.iterator();
%>

SELECCIONE LA CATEGORIA:

<select id="categoria" name="categoria" onchange="cambiarCategoria()">
<% while(it.hasNext()){ 
	CCategoria cat=it.next();
	%>
  <option value="<%=cat.getIdcategoria() %>"><%=cat.getDescripcion() %></option>

<% } %>  
</select>
    
    <script>
    function cambiarCategoria(){
    	 $('#Pregunta_table').flexOptions({params : [{name: 'a', value: 'preguntas'},{name: 'cate', value:$("#categoria").val()} ]});
		  $('#Pregunta_table').flexReload();
    	 
    }
    function ElimPregunta(id){
    	$("#dialog-delete").html("CONFIRMA QUE DESEA ELIMINARLO? <br> ESTE PROCESO ES IRREVERSIBLE");
    	$( "#dialog-delete" ).dialog({
    		resizable: false,
			height:140,
			modal: true,
			buttons: {
				"Eliminar": function() {
					$( this ).dialog( "close" );
					cadena = [ 	'a=deletePregunta',
					           	'idpregunta='+id,
					        ].join('&');
					
					  $.ajax({
				        url: "../SPregunta",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	cambiarCategoria();
				        }
				    });
					
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			}
		});
    	
    }
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
						{display: 'ELIMINAR', name : 'ddactividad', width : 50, sortable : false, align: 'left'}, 
						{ display: 'ID', name: 'idpregunta', width: 30, sortable: true, align: 'left' },
						{ display: 'Orden', name: 'orden', width: 40, sortable: true, align: 'left' },
						{ display: 'Pregunta', name: 'pregunta', width: 250, sortable: true, align: 'left' },
						{ display: 'Estado', name: 'estado', width: 80, sortable: true, align: 'left' },
						{ display: 'AutoEvaluacion', name: 'auto', width: 70, sortable: true, align: 'left' },
						
						{ display: 'Multifasico', name: 'multi', width: 60, sortable: true, align: 'left' },
						{ display: 'Categoria', name: 'categoria', width: 80, sortable: true, align: 'left' }
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
						          {name: 'a', value: 'preguntas'},{name: 'cate', value:$("#categoria").val()} 
						        ],
						searchitems : [
						   					{display: 'Pregunta', name : 'pregunta'}
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
	<div id="dialog-delete" title="CONFIRMA QUE DESEA ELIMINAR">
	
	</div>

<% dbo.Close(); } 
	}	} %>	