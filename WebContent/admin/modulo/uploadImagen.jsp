<script  type="text/javascript">
$(document).ready(function () {
	$("#imagenes").flexigrid
	({
		dataType : 'json',
	    colModel: [
		{display: 'Seleccionar', name : 'chkimagen', width : 30, sortable : false, align: 'left'},           
		{ display: 'ID', name: 'idcontenido', width: 40, sortable: true, align: 'left' },
		{ display: 'Titulo', name: 'titulo', width: 150, sortable: true, align: 'left' },
		{ display: 'Archivo', name: 'direccion', width: 250, sortable: true, align: 'left' }
		],
	    title: 'IMAGENES',
	    width: 600,
	    height: 200
	    
	});
	
	
});
function CargarImagenes(){
	$.post("../SContenidoTable", {ptipo:1,pmenu:editidmenu},
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
function editar_conte1(idconte){
	$("#idimagen").text(idconte);
	idmultimedia=idconte;
	 cadena = [ 'idcontenido='     + idconte,
	            'a=editconte',
	        ].join('&');
	
	$.ajax({
       url: "../SContenido",
       data: cadena,
 	    type: 'post',
 	   dataType : 'json',
       success: function(result){
    	   idimagen=result.idimagen;
    	   $('#tituloimagen').val(Base64.decode(result.titulo));
    	   $('#descripcionimagen').val(Base64.decode(result.descripcion));
    	   $('#pathimagen').text(result.direccion);
       }});	

}
var idimagen=0;
var idmultimedia=0;
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
            		idimagen=file;
            	}
            	if(index=='Mensaje'&&ok==false){
            		cadena=cadena+file+"<br/>";	
            	}
            	
            });
            $("#validacion_imagen").html(cadena);
        }
    });
});
function limpiar(){
	   idimagen=0;
	   idmultimedia=0;
	   $('#idimagen').text('NEW');
	   $('#tituloimagen').val('');
	   $('#descripcionimagen').val('');
	   $('#validacion_prin').html("");
	   $("#validacion_data").html("");
	   $('#pathimagen').text('NO SE HA SUBIDO IMAGEN');
	   $("#validacion_imagen").html("");
	   idpdf=0;
	   idmultimedia2=0;
	   $('#idpdf').text('NEW');
	   $('#titulopdf').val('');
	   $('#descripcionpdf').val('');
	   $('#pathpdf').text('NO SE HA SUBIDO PDF');
	   $("#validacion_pdf").html("");
}
function guardarImagen(){
	if(editidmenu>0){
	var titulo=convertirCaracter($.trim($("#tituloimagen").val()));
	var descripcion=convertirCaracter($.trim($("#descripcionimagen").val()));	
		if(titulo!=''){
			if(descripcion!=""){
			
			if(idmultimedia==0){
				cadena = [ 	'idimagen='   + idimagen,
			             	'a=guardaredit',
				            'titulo='+Base64.encode(titulo),
				            'contenido='+Base64.encode(descripcion),
				            'idmenu='     + editidmenu
				        ].join('&');
			
			
						  $.ajax({
						        url: "../SContenido",
						        data: cadena,
						  	    type: 'post',
						        dataType: 'json',
						        success: function(data){
						        	mensaje(data.mensaje);
						        	if(data.resultado=='OK'){
						        		CargarImagenes();
						        		limpiar();
						        	}
						        }
						    });
			}else{
				cadena = [ 	'idimagen='   + idimagen,
			             	'a=updateedit',
				            'titulo='+Base64.encode(titulo),
				            'contenido='+Base64.encode(descripcion),
				            'idmenu='     + editidmenu,
				            'idconte='+idmultimedia
				        ].join('&');
				$.ajax({
			        url: "../SContenido",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje); 	
			        	if(data.resultado=='OK'){
			        		limpiar();
			        		CargarImagenes();
			        	}
			        }
			    });
			}		  
			}else{
				$("#validacion_imagen").html("Debe ingresar la descripcion");
			}
		}else{
			$("#validacion_imagen").html("Debe ingresar el titulo");	
		}
	}else{
		$("#validacion_imagen").html("Debe seleccionar un item");
	}
}

function eliminar_Contenido(id){
	var idenviar=0;
	if(id==1)
		idenviar=idmultimedia;
	else
		idenviar=idmultimedia2;
	
	
	 if(idenviar>0){
			if(confirm("Confirma que desea eliminar el archivo ")) {
				cadena = [ 'idcontenido='     + idenviar,
				            'a=deleteconte',
				        ].join('&');
				$.ajax({
			        url: "../SContenido",
			        data: cadena,
			  	    type: 'post',
			  	  	dataType: 'json',
			  	  	success: function(data){
			  	  		mensaje(data.mensaje);
			  	  		if(data.resultado=='OK'){
				  	  		limpiar();
				  	  		CargarImagenes(); CargarPDF();
			  	  		}	
			        }});
				
			}
	 }else{
		 mensaje("Debe Seleccionar un archivo");

	}
		
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
						
						<td>Titulo</td>
						<td><input id="tituloimagen" type="text" size="40"/> </td>	
					</tr>
					<tr>
						<td>Descripci&oacute;n</td>
						<td><textarea id="descripcionimagen" rows="2" cols="40"></textarea> </td>	
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
						<a href="#validacion_imagen"  onclick="limpiar()" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
						<a href="#validacion_imagen" onclick="guardarImagen()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
						<a href="#validacion_imagen"  onclick="eliminar_Contenido(1)"  class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
							
				</div>
				<br/><br/>
	
    
</form>