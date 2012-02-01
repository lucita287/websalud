	<script>
	$(function() {
		$( "#tabs" ).tabs();
	});
	(function($) {
		$(document).ready(function() {
			$('#wysiwyg').wysiwyg();
		});
	})(jQuery);
	
	</script>	
	<style type="text/css">
        #tabs {width: 95%;
            margin:0 auto 0 auto;
			}
	
		
        </style>
        
    	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Nueva Entrada</a></li>
				<li><a href="#tabs-2">Editar Entrada</a></li>

			</ul>
			<div id="tabs-1" style="width:1000px; ">
				Titulo: <input type="text" size="60" /><br/>
				Area Pertenece:<br/>
				Sub Parte:<br/>
				
				
			<textarea id="wysiwyg" rows="5" cols="80"></textarea>
				
			</div>
			<div id="tabs-2" style="width:1000px; ">
			</div>
    </div>