<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
    <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
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
		<div class="center_button">
				<a  onclick="GuardarAnuncio()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									
		</div>		
<script>
var editanuncio=0;
	function GuardarAnuncio(){
		var contenido=convertirCaracter($('#cont-text').val());
		  var data_cont=Base64.encode(contenido);
		  cadena = [ 'idanuncio='     + editanuncio,
			         'a=guardaredit',
			         'contenido='+data_cont,
			        ].join('&');
		  
		  $.ajax({
		        url: "../SAnuncio",
		        data: cadena,
		  	    type: 'post',
		        dataType: 'json',
		        success: function(data){
		        	mensaje(data.mensaje);
		        }
			
		    });
	}
	
	function editaranuncio(id){
		$("#cont-text").cleditor()[0].clear();
		editanuncio=id;
		  cadena = [ 'idanuncio='     + id,
			            'a=show',
			        ].join('&');
		  $.ajax({
		        url: "../SAnuncio",
		        data: cadena,
		  	    type: 'post',
		  	  	success: function(data){
		  	  		$("#cont-text").cleditor()[0].execCommand("inserthtml",data,null,null);
					$("#cont-text").cleditor()[0].focus();
					
		        }});
	}
	$( function(){
		
		  var cledit = $("#cont-text").cleditor()[0];
		  $(cledit.$frame[0]).attr("id","cleditCool");

		  var cleditFrame;
		  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
		  else cleditFrame = document.frames["cleditCool"].document;
		    
	  $(cleditFrame).contents().find('body').bind('paste', function(){
		  
	        setTimeout(function() {
	            mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
	        	$("#cont-text").cleditor()[0].focus();
	        }, 100);
	       return false;
	  });
	  } );
	
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
			 url: '../SAnuncioTable',
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