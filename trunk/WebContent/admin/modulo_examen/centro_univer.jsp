		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>
<%@ page import="data.CDepartamento" %>
<%@ page import="java.util.ArrayList" %>
<% 
CDataExam dbo=new CDataExam();
dbo.Connect();
ArrayList<CDepartamento> list_dep=dbo.getListaDepartamentos();
dbo.Close();

%>

		<script>
		var idcentro=0;
		  $(document).ready(function () {
		      $("#centro_uni").flexigrid
				({
					method: 'POST',
					url: '../SCarreraTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcentro_uni', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcentro_uni', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 100, sortable: true, align: 'left' },
					{ display: 'Departamento', name: 'departamento', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idcentro_uni",
					sortorder: "desc",
				    title: 'CENTRO UNIVERSITARIO',
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
									{display: 'Descripcion', name : 'nombre'},
									{display: 'Departamento', name : 'departamento'}
									],
					params : [ {name: 'a', value: 'centro'} ]
				});
		  });  
		  function Editarcentro(id,nombre,iddepto){
			  $("#id_centro").text(id);
			  $("#nombre_centro").val(nombre);
			  $("#dep-centro").val(iddepto);
			  idcentro=id;
		  }
		  function limpiarcentro(){
			  $("#id_centro").text("NEW");
			  $("#nombre_centro").val("");
			  idcentro=0;
			  $('#centro_uni').flexReload();
		  }
		  function Guardarcentro(){
			  var action="guardarcentro";
			  if(idcentro<=0){
				  action="newcentro";
			  }
			  cadena = [ 	'id_centro='   + idcentro,
			             	'a='+action,
				            'nombre='+escape($("#nombre_centro").val()),
				            'departamento='+$("#dep-centro").val()
				        ].join('&');
			  $.ajax({
			        url: "../SCarrera",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarcentro();
			        	}
			        }
			    });
		  }
		  function Eliminarcentro(){
			  var action="deletecentro";
			  
			  cadena = [ 	'id_centro='   + idcentro,
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
			        		limpiarcentro();
			        	}
			        }
			    });
		  }
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="centro_uni" style="display:none"></table>
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_centro">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><input id='nombre_centro' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Departamento</div>
								<div class="col">
										<select id="dep-centro">
													<option value="0"  SELECTED>INDEFINIDO</option>
													<% for(int j=0; j<list_dep.size();j++){ 
														CDepartamento dep=list_dep.get(j);%>
														<option value="<%=dep.getIddepartamento() %>"  ><%= dep.getNombre() %></option>
													<% } %>
										</select>
								</div>
							</div>
				</div>
		</div>

			<div class="center_button_2">
										<a onclick="limpiarcentro()"  class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a onclick="Guardarcentro()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a onclick="Eliminarcentro()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
			</div>