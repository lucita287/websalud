			<script  type="text/javascript">
			  $(document).ready(function () {
			              
			      $('.editor').elrte({
						cssClass : 'el-rte',
						lang     : 'es',
						width	 : 600,
					    height	 : 200,
					    toolbar  : 'complete',
						cssfiles : ['../css/elrte-inner.css']
					});
			  });
			  
			</script>
				Titulo: <input type="text" size="60" /><br/>
				Area Pertenece:<br/>
				Sub Parte:<br/>
				<div id="cont-text" class="editor"></div>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>	
				<div style="clear: both;"></div>