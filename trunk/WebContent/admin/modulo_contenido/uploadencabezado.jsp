<script  type="text/javascript">
var idmultimedia1=0;
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
	    title: 'IMAGENES',
	    width: 600,
	    height: 200
	    
	});
	
	
});
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

function editar_encabe(idmultimedia){
	idmultimedia1=idmultimedia;
	idmultimedia2=idmultimedia;
	$('#idimagen').text(idmultimedia);
	//$('pathimagen').text(path);
}

function guardaareamulti(){
	if(editiarea>0){
		if(idmultimedia2>0){
			//MODIFICAR
			if(idmultimedia1>0){
				cadena = [ 	'idimagen='   + idmultimedia2,
			             	'a=updateedit',
				     		'idarea='+editiarea,
				     		'idimagen_ant='+idmultimedia1
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
			//NUEVO
			}else{
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
			}
			
		}else{
			$("#validacion_imagen").html("Debe seleccionar una imagen");	
		}
	}else $("#validacion_imagen").html("Debe seleccionar una area");
	
}
function limpiar(){
	$("#idimagen").text('NEW');
	$("#pathimagen").text('');
	idmultimedia1=0;
	idmultimedia2=0;
	CargarImagenes();
}
function deleteenca(){
	cadena = [ 	'idimagen='   + idmultimedia2,
             	'a=deleteenca',
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
}

</script>
<form id="file_upload" action="../uploadimagen" method="POST" enctype="multipart/form-data">
    			<h2>Subir Imagenes</h2>
				<div id="validacion_imagen" class="validacion"></div>
				<table id="imagenes" style="display:none"></table>
				<table  width="80%" CELLSPACING="8">
					<tr>
						<td>IDEN</td>
						<td><label id="idimagen">NEW</label> </td>	
					</tr>
					<tr>
						<td>Imagen</td>
						<td>
						<input id="fileupload" type="file" name="files[]" ><BR/>
						<label id="pathimagen">NO SE HA SUBIDO IMAGEN</label><br/>
						</td>	
					</tr>	
				</table>
								
				<br/><br/>
				<div class="centerd">
						<a href="#validacion_imagen" onclick="limpiar()"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
						<a href="#validacion_imagen" onclick="guardaareamulti()"   class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
						<a href="#validacion_imagen" onclick="deleteenca()"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
							
				</div>
				<br/><br/>
	
    
</form>