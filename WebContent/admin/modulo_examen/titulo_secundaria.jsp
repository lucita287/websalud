		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idtsecundaria=0;
		  $(document).ready(function () {
		      $("#titulo_secundaria").flexigrid
				({
					method: 'POST',
					url: '../SPropiedadTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chktitulo_secundaria', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idtitulo_secundaria', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 350, sortable: true, align: 'left' }
					],
					sortname: "idtitulo_secundaria",
					sortorder: "desc",
				    title: 'TITULO DE SECUNDARIA',
				    usepager: true,
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					],
				    params : [ {name: 'a', value: 'tsecundaria'} ]
				});
		  });  
		  function Editartsecundaria(id,nombre){
			  $("#id_tsecundaria").text(id);
			  $("#nombre_tsecundaria").val(nombre);
			  idtsecundaria=id;
		  }
		  function limpiartsecundaria(){
			  $("#id_tsecundaria").text("NEW");
			  $("#nombre_tsecundaria").val("");
			  idtsecundaria=0;
			  $('#titulo_secundaria').flexReload();
		  }
		  function Guardartsecundaria(){
			  var action="guardartsecundaria";
			  if(idtsecundaria<=0){
				  action="newtsecundaria";
			  }
			  cadena = [ 	'id_tsecundaria='   + idtsecundaria,
			             	'a='+action,
				            'nombre='+$("#nombre_tsecundaria").val(),
				        ].join('&');
			  $.ajax({
			        url: "../SPropiedad",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiartsecundaria();
			        	}
			        }
			    });
		  }
		  function Eliminartsecundaria(){
			  var action="deletetsecundaria";
			  
			  cadena = [ 	'id_tsecundaria='   + idtsecundaria,
			             	'a='+action
			            ].join('&');
			  $.ajax({
			        url: "../SPropiedad",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiartsecundaria();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="titulo_secundaria" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_tsecundaria">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_tsecundaria' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiartsecundaria()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardartsecundaria()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminartsecundaria()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
