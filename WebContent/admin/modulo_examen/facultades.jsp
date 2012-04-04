		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idfacultad=0;
		  $(document).ready(function () {
		      $("#unidad_aca").flexigrid
				({
					method: 'POST',
					url: '../SCarreraTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkunidad_aca', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idunidad_aca', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 350, sortable: true, align: 'left' }
					],
					sortname: "idunidad_aca",
					sortorder: "desc",
				    title: 'Facultad/Unidad Academica',
				    usepager: true,
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					],
				    params : [ {name: 'a', value: 'facultad'} ]
				});
		  });  
		  function Editarfacultad(id,nombre){
			  $("#id_facultad").text(id);
			  $("#nombre_facultad").val(unescape(nombre));
			  idfacultad=id;
		  }
		  function limpiarfacultad(){
			  $("#id_facultad").text("NEW");
			  $("#nombre_facultad").val("");
			  idfacultad=0;
			  $('#unidad_aca').flexReload();
		  }
		  function Guardarfacultad(){
			  var action="guardarfacultad";
			  if(idfacultad<=0){
				  action="newfacultad";
			  }
			  cadena = [ 	'id_facultad='   + idfacultad,
			             	'a='+action,
				            'nombre='+escape($("#nombre_facultad").val()),
				        ].join('&');
			  $.ajax({
			        url: "../SCarrera",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarfacultad();
			        	}
			        }
			    });
		  }
		  function Eliminarfacultad(){
			  var action="deletefacultad";
			  
			  cadena = [ 	'id_facultad='   + idfacultad,
			             	'a='+action
			            ].join('&');
			  $.ajax({
			        url: "../SCarrera",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarfacultad();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="unidad_aca" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_facultad">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_facultad' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarfacultad()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarfacultad()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarfacultad()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
