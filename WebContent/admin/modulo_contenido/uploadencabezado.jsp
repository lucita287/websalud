<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="data.CUsuarioPermiso" %>
    
    <%

	HttpSession sessiones = request.getSession(false);
	if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(231)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		
<form id="file_upload" action="../uploadimagen" method="POST" enctype="multipart/form-data">
    			<h2>Subir Imagenes</h2>
    			<h3 style="color:red;">Tama&ntilde;o recomendado:  [160px , 120px] </h3>
				<div id="validacion_imagen" class="validacion"></div>
				<table id="imagenes" style="display:none"></table>
				
				
				<div class="perfil">
				<div class="tabla">
							
							<div class="fila">
								<div class="col_titulo">Imagen</div>
								<div class="col">
									<input id="fileupload" type="file" name="files[]" ><BR/>
									<label id="pathimagen">NO SE HA SUBIDO IMAGEN</label><br/>
								</div>
							</div>
				</div>
				</div>
								
				<div class="center_button_2">
						<%if (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1){ %>
						<a href="#validacion_imagen" onclick="guardaareamulti()"   class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
						<% } %>	
				</div>
    
</form>
<script  type="text/javascript">
var idmultimedia2=0;
$(document).ready(function () {
	$("#imagenes").flexigrid
	({
		dataType : 'json',
	    colModel: [
		{display: 'Seleccionar', name : 'chkimagen', width : 30, sortable : false, align: 'left'},           
		{ display: 'ID', name: 'idencabezado', width: 40, sortable: true, align: 'left' },
		{ display: 'Area', name: 'nombre_area', width: 100, sortable: true, align: 'left' },
		{ display: 'Archivo', name: 'direccion', width: 250, sortable: true, align: 'left' }
		],
		<% if (user_permiso.getIdpermiso().indexOf(232)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
		buttons : [
		   		{name: 'Eliminar', bclass: 'delete', onpress : EliminarEncabe}
		],
		<%}%>
	    title: 'IMAGENES',
	    width: 600,
	    height: 200
	    
	});
	
	
});
function EliminarEncabe(com, grid){
	  if(com=="Eliminar"){
			  	var array_values = [];
					$('.delete_encabe').each( function() {
					    if( $(this).is(':checked') ) {
					        array_values.push( $(this).val() );
					    }
					});
					var arrayValues = array_values.join(',');
					cadena = [ 'a=eliminar_especifico',
					           'idarea='+editiarea,
					            'check_det_encabe='+arrayValues,
					        ].join('&');
					$.ajax({
				        url: "../SEncabezado",
				        data: cadena,
				  	    type: 'post',
				  	    dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje); 	
			        		if(data.resultado=='OK'){
			        			limpiar();
			        		}	
				        }
				    });
					
	  }		  
}

$(function () {
	 $('#fileupload').fileupload({
       dataType: 'json',
       url: '../uploadimagen',
       done: function (e, data) {
       	
       	cadena="";
       	ok=false;
           $.each(data.result, function (index, file) {
           	if(index=='result' ){
           		cadena=cadena+file+"<br/>";	
           		if(file=='OK')ok=true;
           	}
           	if(index=='name'&&ok==true){
           		$('#pathimagen').text(file);
           	}
           	if(index=='idsafe'&&ok==true){
           		idmultimedia2=file;
           	}
           	if(index=='Mensaje'&&ok==false){
           		cadena=cadena+file+"<br/>";	
           	}
           	
           });
           $("#validacion_imagen").html(cadena);
       },
       change: function (e, data) {
       	$("#pathimagen").text("Subiendo imagen por favor espere");
       }
   });
});
function CargarImagenes(){
	$.post("../SEncabezadoTable", {pidarea:editiarea},
	          function (data) {                    
	              var arr = Array();
	              arr = eval("(" + data + ")");                    
	              $('#imagenes').flexAddData(arr);                    
	       });  	 							
}
function LimpiarImagenes(){
				data="{total: 0, page: 1,rows: [] }";
	              var arr = Array();
	              arr = eval("(" + data + ")");                    
	              $('#imagenes').flexAddData(arr);                    
	        	 							
}


function guardaareamulti(){
	if(editiarea>0){
		if(idmultimedia2>0){
			
				cadena = [ 	'idimagen='   + idmultimedia2,
			             	'a=guardaredit',
				     		'idarea='+editiarea,
				        ].join('&');
				$.ajax({
			        url: "../SEncabezado",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){        		
			        		mensaje(data.mensaje); 	
			        		if(data.resultado=='OK'){
			        			limpiar();
			        		}
			        }
			    });
			
		}else $("#validacion_imagen").html("Debe seleccionar una imagen");	
	}else $("#validacion_imagen").html("Debe seleccionar una area");
	
}
function limpiar(){
	$("#pathimagen").text('');
	idmultimedia2=0;
	CargarImagenes();
}


</script>
<% 	}		} %>