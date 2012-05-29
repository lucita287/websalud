		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="data.CUsuarioPermiso" %>
<%

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(239)>-1  || user_permiso.getIdusuario().getidusuario()==1){
%>
		<script>
		var idcivil=0;
		  $(document).ready(function () {
		      $("#estado_civil").flexigrid
				({
					method: 'POST',
					url: '../SPropiedadTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkestado_civil', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idestado_civil', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 250, sortable: true, align: 'left' }
					],
					sortname: "idestado_civil",
					sortorder: "desc",
				    title: 'ESTADO CIVIL',
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    params : [ {name: 'a', value: 'civil'} ]
				});
		  });  
		  function EditarEstadoCivil(id,nombre){
			  $("#id_civil").text(id);
			  $("#nombre_civil").val(nombre);
			  idcivil=id;
		  }
		  function limpiarCivil(){
			  $("#id_civil").text("NEW");
			  $("#nombre_civil").val("");
			  idcivil=0;
			  $('#estado_civil').flexReload();
		  }
		  function GuardarCivil(){
			  var action="guardarcivil";
			  if(idcivil<=0){
				  action="newcivil";
			  }
			  cadena = [ 	'id_civil='   + idcivil,
			             	'a='+action,
				            'nombre='+$("#nombre_civil").val(),
				        ].join('&');
			  $.ajax({
			        url: "../SPropiedad",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarCivil();
			        	}
			        }
			    });
		  }
		  function EliminarCivil(){
			  var action="deletecivil";
			  
			  cadena = [ 	'id_civil='   + idcivil,
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
			        		limpiarCivil();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="estado_civil" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_civil">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_civil' type="text" size="40"/></div>
							</div>
				</div>
		</div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarCivil()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="GuardarCivil()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="EliminarCivil()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
<%	}	} %>