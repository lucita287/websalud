		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		function RecargarMenu_Categoria(){
			  cadena = [ 'a=show_menu_cate',].join('&');
				 
				 $.ajax({
				        url: "../SCategoria",
				        data: cadena,
				  	    type: 'post',
				  	  	success: function(data){
				        	result=eval("("+data+")");
				        	var array=result.rows;
				        	$('#menu_cate').empty();
				        	for (var x = 0 ; x < array.length ; x++) {
				        		$('#menu_cate').append('<option value="'+array[x].value+'" >'+array[x].text+'</option>');
				        	}
				        }
				    });
		  }
		var idmenu_categoria=0;
		  $(document).ready(function () {
		      $("#m_categoria").flexigrid
				({
					method: 'POST',
					url: '../SCategoriaTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkm_categoria', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idm_categoria', width: 40, sortable: true, align: 'left' },
					{ display: 'Menu', name: 'nombre', width: 250, sortable: true, align: 'left' }
					],
					usepager: true,
					sortname: "idm_categoria",
					sortorder: "desc",
				    title: 'Menu Categoria',
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    useRp: true,
				    rp: 15,
				    searchitems : [{display: 'Menu', name : 'menu'}],
				    params : [ {name: 'a', value: 'menu_categoria'} ]
				});
		  });  
		  function Editarmenu_categoria(id,nombre){
			  $("#id_menu_categoria").text(id);
			  $("#nombre_menu_categoria").val(nombre);
			  idmenu_categoria=id;
		  }
		  function limpiarmenu_categoria(){
			  $("#id_menu_categoria").text("NEW");
			  $("#nombre_menu_categoria").val("");
			  idmenu_categoria=0;
			  $('#m_categoria').flexReload();
			  RecargarMenu_Categoria();
		  }
		  function Guardarmenu_categoria(){
			  var action="guardarmenu_categoria";
			  if(idmenu_categoria<=0){
				  action="newmenu_categoria";
			  }
			  cadena = [ 	'id_menu_categoria='   + idmenu_categoria,
			             	'a='+action,
				            'nombre='+$("#nombre_menu_categoria").val(),
				        ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarmenu_categoria();
			        	}
			        }
			    });
		  }
		  function Eliminarmenu_categoria(){
			  var action="deletemenu_categoria";
			  
			  cadena = [ 	'id_menu_categoria='   + idmenu_categoria,
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
			        		limpiarmenu_categoria();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="m_categoria" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_menu_categoria">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Menu</div>
								<div class="col"><input id='nombre_menu_categoria' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarmenu_categoria()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarmenu_categoria()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarmenu_categoria()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
