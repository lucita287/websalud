		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idrespon=0;
		  $(document).ready(function () {
		      $("#tipo_sangre").flexigrid
				({
					method: 'POST',
					// url: '../SResponsableTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chktipo_sangre', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idtipo_sangre', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idtipo_sangre",
					sortorder: "desc",
				    title: 'TIPO DE SANGRE',
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Descripcion', name : 'nombre'}
					]
				});
		  });  
		  
		  
		</script>
		<table id="tipo_sangre" style="display:none"></table>
		<table>
					<tr>
						<td>ID</td>
						<td><label id="id_respon">NEW</label></td>
					</tr>
					<tr>
						<td>Descripci&oacute;n</td>
						<td><input id='nombre_respon' type="text" size="40"/></td>
					</tr>
						
				</table>
			<center>
									<br/><br/>
										<a href="#" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<br/><br/>		
			</center>
