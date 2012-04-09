		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idparen=0;
		$(function() {
			$( ".check" ).button();
		});
		  $(document).ready(function () {
		      $("#parentesco").flexigrid
				({
					method: 'POST',
					url: '../SPropiedadTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkparentesco', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idparentesco', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 150, sortable: true, align: 'left' },
					{ display: 'Grupo Familiar', name: 'grupo_familiar', width: 80, sortable: true, align: 'left' },
					{ display: 'Antecedentes Familiares', name: 'antec_familiar', width: 120, sortable: true, align: 'left' },
					{ display: 'Emergencias', name: 'emergencia', width: 80, sortable: true, align: 'left' }
					],
					sortname: "idparentesco",
					sortorder: "desc",
				    title: 'Parentesco',
				    usepager: true,
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					],
				    params : [ {name: 'a', value: 'parentesco'} ]
				});
		  });  
		  function Editarparentesco(id,nombre,g1,g2,g3){
			  $("#id_paren").text(id);
			  $("#nombre_paren").val(nombre);
			  $("#grupo_familiar").attr('checked', g1);
      		  $("#grupo_familiar").button('refresh');
      		  $("#antecedentes").attr('checked', g2);
     		  $("#antecedentes").button('refresh');
     		 $("#emergencias").attr('checked', g3);
    		  $("#emergencias").button('refresh');
			  idparen=id;
		  }
		  function limpiarparen(){
			  $("#id_paren").text("NEW");
			  $("#nombre_paren").val("");
			  $("#grupo_familiar").attr('checked', false);
      		  $("#grupo_familiar").button('refresh');
      		  $("#antecedentes").attr('checked', false);
     		  $("#antecedentes").button('refresh');
     		 $("#emergencias").attr('checked', false);
    		  $("#emergencias").button('refresh');
			  idparen=0;
			  $('#parentesco').flexReload();
		  }
		  function Guardarparen(){
			  var action="guardarparen";
			  if(idparen<=0){
				  action="newparen";
			  }
			  cadena = [ 	'id_paren='   + idparen,
			             	'a='+action,
				            'nombre='+escape($("#nombre_paren").val()),
				            'grupo_familiar='+(($("#grupo_familiar").is(":checked")==true)?1:0),
				            'antecedentes='+(($("#antecedentes").is(":checked")==true)?1:0),
				            'emergencias='+(($("#emergencias").is(":checked")==true)?1:0),
				        ].join('&');
			  $.ajax({
			        url: "../SPropiedad",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarparen();
			        	}
			        }
			    });
		  }
		  function Eliminarparen(){
			  var action="deleteparen";
			  
			  cadena = [ 	'id_paren='   + idparen,
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
			        		limpiarparen();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="parentesco" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_paren">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_paren' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Areas</div>
								<div class="col">
										<input type="checkbox" id="grupo_familiar" class="check" /><label for="grupo_familiar">FORMULARIO DE GRUPO FAMILIAR</label>
										<input type="checkbox" id="antecedentes" class="check" /><label for="antecedentes">FORMULARIO DE ANTECENDENTES FAMILIARES</label>
										<input type="checkbox" id="emergencias" class="check" /><label for="emergencias">FORMULARIO DE EMERGENCIAS</label>
										
								</div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarparen()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarparen()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarparen()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
