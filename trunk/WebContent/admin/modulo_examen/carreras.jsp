		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idcarrera=0;
		  $(document).ready(function () {
		      $("#carrera").flexigrid
				({
					method: 'POST',
					// url: '../ScarrerasableTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcarrera', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcarrera', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idcarrera",
					sortorder: "desc",
				    title: 'CARRERA',
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
		<table id="carrera" style="display:none"></table>
		<table>
					<tr>
						<td>ID</td>
						<td><label id="id_carrera">NEW</label></td>
					</tr>
					<tr>
						<td>Descripci&oacute;n</td>
						<td><input id='nombre_carrera' type="text" size="40"/></td>
					</tr>
						
				</table>
			<center>
									<br/><br/>
										<a href="#" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<br/><br/>		
			</center>