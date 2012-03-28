		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

		<script>
		var idfacult=0;
		  $(document).ready(function () {
		      $("#facultad").flexigrid
				({
					method: 'POST',
					// url: '../SfacultsableTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkfacultad', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idfacultad', width: 40, sortable: true, align: 'left' },
					{ display: 'Descripcion', name: 'nombre', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idfacultad",
					sortorder: "desc",
				    title: 'FACULTAD',
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
		<table id="facultad" style="display:none"></table>
		<table>
					<tr>
						<td>ID</td>
						<td><label id="id_facult">NEW</label></td>
					</tr>
					<tr>
						<td>Descripci&oacute;n</td>
						<td><input id='nombre_facult' type="text" size="40"/></td>
					</tr>
						
				</table>
			<center>
									<br/><br/>
										<a href="#" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<br/><br/>		
			</center>