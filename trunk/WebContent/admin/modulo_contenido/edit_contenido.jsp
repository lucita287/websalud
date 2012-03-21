			
	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CUsuarioPermiso" %>
	<%

	HttpSession sessiones = request.getSession(false);
	if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
		
		CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(221)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
				
			<script  type="text/javascript">
			var editidmenu=0;
					 
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
			
			<div id="tabs-1" style="width:750px; ">
				<jsp:include page="editDatos.jsp" />			
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-2" style="width:750px; ">
				<jsp:include page="uploadImagen.jsp" />
				<div style="clear: both;"></div>
			</div>
			<div id="tabs-3" style="width:750px; ">
				<jsp:include page="uploadPDF.jsp" />
			</div>
			</div>
			<% }
		} %>			