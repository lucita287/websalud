<script  type="text/javascript">
$(document).ready(function () {
	$("#imagenes").flexigrid
	({
		method: 'POST',
		 url: '',
		 dataType : 'xml',
	    colModel: [
		{display: 'Seleccionar', name : 'chkimagen', width : 30, sortable : false, align: 'left'},           
		{ display: 'ID', name: 'idcontenido', width: 40, sortable: true, align: 'left' },
		{ display: 'Titulo', name: 'titulo', width: 100, sortable: true, align: 'left' },
		{ display: 'Archivo', name: 'direccion', width: 100, sortable: true, align: 'left' }
		],
	    title: 'IMAGENES',
	    width: 600,
	    height: 200
	    
	});
});
$(function () {
	var input = $('#input');
    $('#fileupload').fileupload({
        dataType: 'json',
        url: '../uploadimagen',
        formData: {"area": editarea},
        done: function (e, data) {
        	
        	cadena="";
            $.each(data.result, function (index, file) {
            	cadena=cadena+file+"<br/>";	
            });
            $('#validacion_imagen').html(cadena);
        }
    });
});
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
						<input id="fileupload" type="file" name="files[]" >
						 
						</td>	
					</tr>	
				</table>
	
    
</form>