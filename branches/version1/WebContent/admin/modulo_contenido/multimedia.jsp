<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="data.CUsuarioPermiso" %>    
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

	if (user_permiso.getIdpermiso().indexOf(247)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>		    
    <script  type="text/javascript">
			
			  $(document).ready(function () {
				  
			     $("#multimedia").flexigrid
					({
						method: 'POST',
						 url: '../SMultimediaTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
						{ display: 'ID', name: 'idmultimedia', width: 40, sortable: true, align: 'left' },
						{ display: 'TIPO', name: 'tipo', width: 40, sortable: true, align: 'left' },
						{ display: 'LINK', name: 'link', width: 80, align: 'left' },
						{ display: 'NOMBRE ARCHIVO', name: 'ubicacion', width: 200, sortable: true, align: 'left' },
						{ display: 'CREADOR', name: 'nombre', width: 100, sortable: true, align: 'left' },
						{ display: 'USUARIO', name: 'user', width: 80, align: 'left', sortable: true }
						],
						<% if (user_permiso.getIdpermiso().indexOf(248)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
						buttons : [
						   		{name: 'Eliminar', bclass: 'delete', onpress : EliminarFecha},
						   		{name: 'Eliminar Todos', bclass: 'delete', onpress : EliminarFecha}
						],
						<%}%>
						showTableToggleBtn: true,
					    usepager: true,
					    sortname: "idmultimedia",
						sortorder: "desc",
					    title: 'ARCHIVOS SIN USO',
					    useRp: true,
					    rp: 15,
					    width: 720,
					    height: 300,
					    searchitems : [
										{display: 'Nombre archivo', name : 'nombre'},
										{display: 'Nombre de Creador', name : 'usuario'}
									  ]
					});
			     $('.pSearch').click();
			  });
			  function EliminarFecha(com, grid){
				  if(com=="Eliminar"){
						  	var array_values = [];
								$('.dele_multimedia').each( function() {
								    if( $(this).is(':checked') ) {
								        array_values.push( $(this).val() );
								    }
								});
								var arrayValues = array_values.join(',');
								cadena = [ 'a=eliminar_especifico',
								            'check_det_multimedia='+arrayValues,
								        ].join('&');
								$.ajax({
							        url: "../SMultimedia",
							        data: cadena,
							  	    type: 'post',
							        success: function(data){
							        		$("#result").html(data);
							        		limpiar();
							        	
							        }
							    });
								
				  }else{
					  cadena = [ 'a=eliminar_todos'  ].join('&');
						$.ajax({
					        url: "../SMultimedia",
					        data: cadena,
					  	    type: 'post',
					        success: function(data){
					        		$("#result").html(data);
					        		limpiar();
					        	
					        }
					    });
				  }		  
			  }
			  function limpiar(){
				  $('#multimedia').flexReload();
			  }
			</script>
			
			<div class="centerd">
			<H2>ARCHIVOS SIN USO</H2>
			</div>			
			<table id="multimedia" style="display:none"></table>
			<div id="result"></div>
<% 		}	} %>			