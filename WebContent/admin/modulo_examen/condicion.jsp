		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
    <script>
		var idcivil=0;
		  $(document).ready(function () {
		      $("#estado_civil").flexigrid
				({
					method: 'POST',
					//url: '../SPropiedadTable',
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
	</script>	  
    <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="estado_civil" style="display:none"></table>
    Descripcion de la condici&oacute;n: <br>
    <textarea rows="3" cols="70"></textarea>
    
    