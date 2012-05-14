<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<div class="centerd">
			<h2>Editar Anuncios del Examen</h2>
</div>
<div style="width: 600px; margin:0 auto 0 auto;">
			
			<table id="flex1" style="display:none"></table>
			</div>
		<div style="clear: both;"></div>
		<label id="Titulo"></label><br>
		<div id="descripcion"></div>		
		<textarea id="cont-text" class="editor"></textarea>			
		<div style="clear: both;"></div>		
<script>
$(document).ready(function () {
	  $("#cont-text").cleditor({
		    width:        600,
		    height:       250,
		    controls:     // controls to add to the toolbar
		    	                        "bold italic underline strikethrough subscript superscript | font size " +
		    	                        "style | color highlight removeformat | bullets numbering | outdent " +
		    	                        "indent | alignleft center alignright justify | undo redo | " +
		    	                        "rule image link unlink | cut copy paste pastetext | print"					    
		    });
	  $("#cont-text").cleditor()[0].focus();
	  $( "#dialog:ui-dialog" ).dialog( "destroy" );
	  $("#flex1").flexigrid
		({
			method: 'POST',
			 url: '../SAnuncio_Table',
			 dataType : 'xml',
		    colModel: [
			{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
			{ display: 'idmenu', name: 'idmenu', width: 40, sortable: true, align: 'left' },
			{ display: 'nombre', name: 'nombre', width: 200, sortable: true, align: 'left' },
			{ display: 'descripcion', name: 'descripcion', width: 250, sortable: true, align: 'left' }
			],
		    title: 'Area',
		    width: 600,
		    height: 200
		});				  

		
});
</script>