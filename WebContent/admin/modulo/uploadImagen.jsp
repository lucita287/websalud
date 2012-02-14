<form id="file_upload" action="../SUploadContenido" method="POST" enctype="multipart/form-data">
    <div id="drop_zone_1">
    			<h1>Subir Imagenes</h1>
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
						<input id="file_1" type="file" name="file_1" >
						<table id="files_1" style="background:yellow;"></table> 
						</td>	
					</tr>	
				</table>
	</div>			

    
</form>


<script>

/*global $ */
$(function () {
    var initFileUpload = function (suffix) {
        $('#file_upload').fileUploadUI({
            namespace: 'file_upload_' + suffix,
            fileInputFilter: '#file_' + suffix,
            dropZone: $('#drop_zone_' + suffix),
            uploadTable: $('#files_' + suffix),
            downloadTable: $('#files_' + suffix),
            buildUploadRow: function (files, index) {
                return $('<tr><td>' + files[index].name + '<\/td>' +
                        '<td class="file_upload_progress"><div><\/div><\/td>' +
                        '<td class="file_upload_cancel">' +
                        '<button class="ui-state-default ui-corner-all" title="Cancel">' +
                        '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
                        '<\/button><\/td><\/tr>');
            },
            buildDownloadRow: function (file) {
                return $('<tr><td>' + file.name + '<\/td><\/tr>');
            }
        });
    };
    initFileUpload(1);
});
</script> 
