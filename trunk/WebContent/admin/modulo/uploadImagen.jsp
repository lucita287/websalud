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
function editar_conte(idconte){
	mensaje("HOlaaaaaaa");
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
	var input = $('#input');
	
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
            $('#validacion_imagen').html(cadena);
        }
    });
});
function limpiar(){
	   idimagen=0;
	   idmultimedia=0;
	   $('#idimagen').text('NEW');
	   $('#tituloimagen').val('');
	   $('#descripcionimagen').val('');
	   $('#pathimagen').text('NO SE HA SUBIDO IMAGEN');
}
function guardarImagen(){
	var titulo=convertirCaracter($.trim($("#tituloimagen").val()));
	var descripcion=convertirCaracter($.trim($("#descripcionimagen").val()));	
	
	if(idmultimedia==0){
		cadena = [ 	'idimagen='   + idimagen,
	             	'a=guardaredit',
		            'titulo='+Base64.encode(titulo),
		            'contenido='+Base64.encode(descripcion),
		            'idmenu='     + editidmenu
		        ].join('&');

		if(titulo!=''){
			if(descripcion!=""){
			 $("#validacion").html("No se ha actualizado"); 
			  $.ajax({
			        url: "../SContenido",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        		$("#validacion").html(data.mensaje); 	
			        }
			    });
			}else{
				$('#validacion_imagen').html("Debe ingresar la descripcion");
			}
		}else{
			$('#validacion_imagen').html("Debe ingresar el titulo");	
		}
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
	        		$("#validacion").html(data.mensaje); 	
	        		limpiar();
	        }
	    });
		
	}
	CargarImagenes();
	
}

</script>
<form id="file_upload" action="../uploadimagen" method="POST" enctype="multipart/form-data">
    			<h2>Subir Imagenes</h2>
				<div id="validacion_imagen" class="validacion"></div>
				<table id="imagenes" style="display:none"></table>
				<table  width="80%" CELLSPACING="8">
					<tr>
						<td>IDEN</td>
						<td><label id="idimagen">NEW</label> <input type="hidden" id="" value="3"></td>	
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
						<a href="#" onclick="limpiar()" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
						<a href="#" onclick="guardarImagen()" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
						<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
							
				</div>
				<br/><br/>
	
    
</form>