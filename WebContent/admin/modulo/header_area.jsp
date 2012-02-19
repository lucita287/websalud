	<script  type="text/javascript">
			var editidmenu=0;
			 function convertirCaracter(caracter){
					caracter=replaceAll(caracter,"á","&aacute;");
					caracter=replaceAll(caracter,"é","&eacute;");
					caracter=replaceAll(caracter,"í","&iacute;");
					caracter=replaceAll(caracter,"ó","&oacute;");
					caracter=replaceAll(caracter,"ú","&uacute;");
					caracter=replaceAll(caracter,"Á","&Aacute;");
					caracter=replaceAll(caracter,"É","&Eacute;");
					caracter=replaceAll(caracter,"Í","&Iacute;");
					caracter=replaceAll(caracter,"Ó","&Oacute;");
					caracter=replaceAll(caracter,"Ú","&Uacute;");
					caracter=replaceAll(caracter,"ñ","&ntilde;");
					caracter=replaceAll(caracter,"Ñ","&Ntilde;");
					return caracter;
				}
			  function replaceAll( text, busca, reemplaza ){
				  while (text.toString().indexOf(busca) != -1)
				      text = text.toString().replace(busca,reemplaza);
				  return text;
				}					 
			  $(document).ready(function () {
				  $( "#dialog:ui-dialog" ).dialog( "destroy" );
				  $("#flex1").flexigrid
					({
						method: 'POST',
						 url: '../SMenuTable',
						 dataType : 'xml',
					    colModel: [
						{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
						{ display: 'idarea', name: 'idmenu', width: 40, sortable: true, align: 'left' },
						{ display: 'descripcion', name: 'descripcion', width: 100, sortable: true, align: 'left' },
						{ display: 'area', name: 'area', width: 100, sortable: true, align: 'left' },
						{ display: 'menu_rec', name: 'menu_rec', width: 100, sortable: true, align: 'left' }
						],
					    usepager: true,
					    sortname: "idmenu",
						sortorder: "asc",
					    title: 'Contenido',
					    useRp: true,
					    rp: 15,
					    showTableToggleBtn: true,
					    width: 600,
					    height: 200,
					    searchitems : [
						{display: 'Area', name : 'area'},
						{display: 'Descripcion', name : 'descripcion', isdefault: true}
						]
					});				  
			  
					
			  });
			  
			  function mensaje(mens){
				  
				  $( "#dialog-message" ).html(mens);
					$( "#dialog-message" ).dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						}
					});
			  }
			  
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<div class="centerd">
			<h2>Editar Areas Profesionales</h2>
			</div>
			<div id="validacion_prin" class="validacion"></div>
			