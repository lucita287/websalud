		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var iddependencia=0;
		  $(document).ready(function () {
		      $("#dependencia_uni").flexigrid
				({
					method: 'POST',
					url: '../SCarreraTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkdependencia_uni', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'iddependencia_uni', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 250, sortable: true, align: 'left' }
					],
					usepager: true,
					sortname: "iddependencia_uni",
					sortorder: "desc",
				    title: 'Dependencia',
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    useRp: true,
				    rp: 15,
				    searchitems : [{display: 'Departamento', name : 'departamento'}],
				    params : [ {name: 'a', value: 'dependencia'} ]
				});
		  });  
		  function Editardependencia(id,nombre){
			  $("#id_dependencia").text(id);
			  $("#nombre_dependencia").val(nombre);
			  iddependencia=id;
		  }
		  function limpiardependencia(){
			  $("#id_dependencia").text("NEW");
			  $("#nombre_dependencia").val("");
			  iddependencia=0;
			  $('#dependencia_uni').flexReload();
		  }
		  function Guardardependencia(){
			  var action="guardardependencia";
			  if(iddependencia<=0){
				  action="newdependencia";
			  }
			  cadena = [ 	'id_dependencia='   + iddependencia,
			             	'a='+action,
				            'nombre='+$("#nombre_dependencia").val(),
				        ].join('&');
			  $.ajax({
			        url: "../SCarrera",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiardependencia();
			        	}
			        }
			    });
		  }
		  function Eliminardependencia(){
			  var action="deletedependencia";
			  
			  cadena = [ 	'id_dependencia='   + iddependencia,
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
			        		limpiardependencia();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="dependencia_uni" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_dependencia">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_dependencia' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiardependencia()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardardependencia()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminardependencia()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
