		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
		<script>
		var idcate=0;
		$(function() {
			$( ".check" ).button();
		});
		  $(document).ready(function () {
		      $("#categoria").flexigrid
				({
					method: 'POST',
					url: '../SCategoriaTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcategoria', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcategoria', width: 40, sortable: true, align: 'left' },
					{ display: 'Orden', name: 'orden', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 250, sortable: true, align: 'left' },
					{ display: 'Autoevaluaci&oacute;n', name: 'auto', width: 80, sortable: true, align: 'left' },
					{ display: 'Multif&aacute;sico', name: 'multifa', width: 80, sortable: true, align: 'left' }
					],
					sortname: "idcategoria",
					sortorder: "desc",
				    title: 'Categoria',
				    usepager: true,
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					],
				    params : [ {name: 'a', value: 'categoria'} ]
				});
		  });  
		  function Editarcategoria(id,nombre,orden,g1,g2){
			  $("#id_cate").text(id);
			  $("#nombre_cate").val(nombre);
			  $("#orden_cate").val(orden);
			  $("#auto_cate").attr('checked', g1);
      		  $("#auto_cate").button('refresh');
      		  $("#multifa_cate").attr('checked', g2);
     		  $("#multifa_cate").button('refresh');
     		  idcate=id;
     		 $('#categoria_ponderacion').flexOptions({ params : [{name: 'idcategoria', value: idcate},{name: 'a', value: 'ponderacion'}]});
			  $('#categoria_ponderacion').flexReload();
			  $('#editor').cleditor()[0].clear();
			  $("#editor").cleditor()[0].focus();
			  $("#cate_catego_ponde").text(nombre);
			  idcate_pond=0;
		  }
		  function limpiarcate(){
			  $("#id_cate").text("NEW");
			  $("#nombre_cate").val("");
			  $("#auto_cate").attr('checked', false);
      		  $("#auto_cate").button('refresh');
      		  $("#multifa_cate").attr('checked', false);
     		  $("#multifa_cate").button('refresh');
     		  $("#orden_cate").val("0");
     		  idcate=0;
			  $('#categoria').flexReload();
			  $('#categoria_ponderacion').flexOptions({ params : [{name: 'idcategoria', value: 0},{name: 'a', value: 'ponderacion'}]});
			  $('#categoria_ponderacion').flexReload();
			  $('#editor').cleditor()[0].clear();
			  $("#editor").cleditor()[0].focus();
			  $("#cate_catego_ponde").text("SELECCIONE LA CATEGORIA");
			  idcate_pond=0;
		  }
		  function Guardarcate(){
			  var action="guardarcate";
			  if(idcate<=0){
				  action="newcate";
			  }
			  cadena = [ 	'id_cate='   + idcate,
			             	'a='+action,
				            'nombre='+$("#nombre_cate").val(),
				            'auto='+(($("#auto_cate").is(":checked")==true)?1:0),
				            'multifa='+(($("#multifa_cate").is(":checked")==true)?1:0),
				            'orden='+$("#orden_cate").val(),
				            'estado='+$("#estado_pregunta").val(),
				        ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarcate();
			        	}
			        }
			    });
		  }
		  function Eliminarcate(){
			  var action="deletecate";
			  
			  cadena = [ 	'id_cate='   + idcate,
			             	'a='+action
			            ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarcate();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="categoria" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_cate">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_cate' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Orden</div>
								<div class="col"><input id='orden_cate' type="text" size="10"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Estado</div>
								<div class="col">
									<select id="estado_pregunta" name="estado_pregunta"  >
													<option value="0" >DESHABILITADA</option>
													<option value="1" selected>HABILITADO</option>
												</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Examenes</div>
								<div class="col">
									<input type="checkbox" id="auto_cate" class="check" /><label for="auto_cate">Examen de AutoEvaluaci&oacute;n</label>
									<input type="checkbox" id="multifa_cate" class="check" /><label for="multifa_cate">Examen Multif&aacute;sico</label>										
								</div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarcate()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarcate()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarcate()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
    