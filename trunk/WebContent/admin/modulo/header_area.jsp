	<script  type="text/javascript">
			var editidmenu=0;
			 function convertirCaracter(caracter){
					caracter=replaceAll(caracter,"�","&aacute;");
					caracter=replaceAll(caracter,"�","&eacute;");
					caracter=replaceAll(caracter,"�","&iacute;");
					caracter=replaceAll(caracter,"�","&oacute;");
					caracter=replaceAll(caracter,"�","&uacute;");
					caracter=replaceAll(caracter,"�","&Aacute;");
					caracter=replaceAll(caracter,"�","&Eacute;");
					caracter=replaceAll(caracter,"�","&Iacute;");
					caracter=replaceAll(caracter,"�","&Oacute;");
					caracter=replaceAll(caracter,"�","&Uacute;");
					caracter=replaceAll(caracter,"�","&ntilde;");
					caracter=replaceAll(caracter,"�","&Ntilde;");
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
			