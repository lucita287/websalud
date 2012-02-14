<script  type="text/javascript">
$(document).ready(function () {
$("#editconte").cleditor({
    width:        600,
    height:       250
    });
$("#editconte").cleditor()[0].focus();
});         

$( function(){


		var cledDesc = $("#editconte").cleditor()[0];
		var frameDesc =  cledDesc.$frame[0].contentWindow.document;

		$(frameDesc).catchpaste( 
					function (pasted,options){
						
						 return null; 
						} );
		    } );
		function editar(idmenu){
			$("#editconte").cleditor()[0].clear();
			$('#edit-id').text(idmenu);
			 cadena = [ 'idmenu='     + idmenu,
			            'a=show',
			        ].join('&');
			
			$.ajax({
		        url: "../SMenu",
		        data: cadena,
		  	    type: 'post',
		        success: function(data){
		        	editidmenu=idmenu;
					var result=eval("(" +Base64.decode(data)+")");
					$('#edit-area').text(result.areanombre);	
					$('#edit-submenu').text(result.submenu);
		        	$('#edit-titulo').val(result.descripcion);
					$("#editconte").cleditor()[0].execCommand("inserthtml", result.contenido,null,null);
					//$("#editconte").cleditor()[0].focus();
		        }
			
		    });
			
		}
</script>
				
				ID:  <label id="edit-id"></label><br/>
				Titulo: <input id="edit-titulo" type="text" size="60" /><br/>
				Area Pertenece: <label id="edit-area"></label><br/>
				Sub Menu: <label id="edit-submenu"></label><br/>
				Tama&ntilde;o:<select id="edit-tam"> 
						<option value="3">Grande</option>
						<option value="2">Mediano</option>
						<option value="1">Peque&ntilde;o</option>
						<option value="0">Sin Texto</option>
				</select>
				<textarea o id="editconte" class="editor"></textarea>
				
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardaredit()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>