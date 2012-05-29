		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CTitulo_Respuesta" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(259)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>

		<script>
		var idtitulo=0;
		  $(document).ready(function () {
		      $("#titulo_respuesta").flexigrid
				({
					method: 'POST',
					 url: '../SPreguntaTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chktitulo', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idtitulo', width: 40, sortable: false, align: 'left' },
					{ display: 'Nombre', name: 'nombre', width: 300, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idtitulo",
					sortorder: "desc",
				    title: 'TITULO RESPUESTA',
				    useRp: true,
				    params : [ 
					          {name: 'a', value: 'titulo_respuesta'}
					        ],
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Nombre', name : 'nombre'}
					]
				});
		  });  
		  $('.pSearch').click();	
		  function GuardarEdificio(){
			  var action='guardar_titulo';
			   
			  
			  var nombre=($.trim($("#nombre").val()));
			  cadena = [ 'idtitulo='     + idtitulo,
				            'a='+action,
				            'nombre='+nombre,
				        ].join('&');
			  $.ajax({
			        url: "../SPregunta",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		LimpiarTitulo();
			        	}
			        }
			    });
			  
		  }

		  function EditarTitulo(id){
			  $("#id_titulo").text(id);
			  idtitulo=id;
			  cadena = [ 'idtitulo='     + idtitulo,
				            'a=show_titulo',
				        ].join('&');
			  
			  $.ajax({
			        url: "../SPregunta",
			        data: cadena,
			  	    type: 'post',
			        success: function(data){
			        	result=eval("("+ data+")");
			        	$("#nombre").val(result.nombre);
			        }
			    });
		  }
		  function LimpiarTitulo(){
			  	$("#id_titulo").text("");
			  	$("#nombre").val("");
			  	idtitulo=0;
			  	$("#titulo_respuesta").flexReload();
			  }
		</script>
		<table id="titulo_respuesta" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_titulo" ></label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Nombre</div>
								<div class="col"><input id='nombre' type="text" size="50"/></div>
							</div>

				</div>
		</div>
		
			<div class="center_button">
										<a href="#" class="ui-state-default ui-corner-all button-save" onclick="GuardarEdificio()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
											
			</div>
<% }	}	 %>				