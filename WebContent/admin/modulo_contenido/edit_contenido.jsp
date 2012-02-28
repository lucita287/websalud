			<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
	<%

HttpSession ss=request.getSession(false); 
if(ss!=null && session.getAttribute("user")!=null){
%>				
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
					caracter=replaceAll(caracter,"Ü","&Uuml;");
					caracter=replaceAll(caracter,"ü","&uuml;");
					caracter=replaceAll(caracter,String.fromCharCode(8211),"&#8211;");
					caracter=replaceAll(caracter,String.fromCharCode(8212),"&#8212;");
					caracter=replaceAll(caracter,String.fromCharCode(8226),"&#8226;");
					caracter=replaceAll(caracter,String.fromCharCode(183),"&#183;");
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
						{ display: 'idmenu', name: 'idmenu', width: 40, sortable: true, align: 'left' },
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
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n">
		
			</div>
			<div class="centerd">
			<h2>Editar Contenido</h2>
			</div>
			<div style="width: 600px; margin:0 auto 0 auto;">
			<div id="validacion_prin" class="validacion"></div>
			<table id="flex1" style="display:none"></table>
			</div>
			
			
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Contenido</a></li>
				<li><a href="#tabs-2">Imagenes</a></li>
				<li><a href="#tabs-3">PDF</a></li>
			</ul>
			
			<div id="tabs-1" style="width:1000px; ">
				<jsp:include page="editDatos.jsp" />			
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-2" style="width:1000px; ">
				<jsp:include page="uploadImagen.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-3" style="width:1000px; ">
				<jsp:include page="uploadPDF.jsp" />
			</div>
			</div>
<% } %>			