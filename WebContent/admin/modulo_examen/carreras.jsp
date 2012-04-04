		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idcarrera=0;
		  $(document).ready(function () {
		      $("#carreras").flexigrid
				({
					method: 'POST',
					url: '../SCarreraTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcarreras', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcarreras', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 350, sortable: true, align: 'left' }
					],
					sortname: "idcarreras",
					sortorder: "desc",
				    title: 'CARRERA',
				    usepager: true,
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					],
				    params : [ {name: 'a', value: 'carrera'} ]
				});
		  });  
		  function Editarcarrera(id,nombre){
			  $("#id_carrera").text(id);
			  $("#nombre_carrera").val(nombre);
			  idcarrera=id;
		  }
		  function limpiarcarrera(){
			  $("#id_carrera").text("NEW");
			  $("#nombre_carrera").val("");
			  idcarrera=0;
			  $('#carreras').flexReload();
		  }
		  function Guardarcarrera(){
			  var action="guardarcarrera";
			  if(idcarrera<=0){
				  action="newcarrera";
			  }
			  cadena = [ 	'id_carrera='   + idcarrera,
			             	'a='+action,
				            'nombre='+escape($("#nombre_carrera").val()),
				        ].join('&');
			  $.ajax({
			        url: "../SCarrera",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarcarrera();
			        	}
			        }
			    });
		  }
		  function Eliminarcarrera(){
			  var action="deletecarrera";
			  
			  cadena = [ 	'id_carrera='   + idcarrera,
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
			        		limpiarcarrera();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="carreras" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_carrera">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_carrera' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarcarrera()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarcarrera()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarcarrera()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
