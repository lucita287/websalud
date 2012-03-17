		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuario" %>
<%@ page import="data.CUsuarioPermiso" %>

<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CUsuario> list_usuario=data.getListaUsuarios();
		
		data.Close();
		
		HttpSession sessiones = request.getSession(false);
		if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
			
			CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

			if (user_permiso.getIdpermiso().indexOf(228)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>		

		<script>
		var idedificio=0;
		  $(document).ready(function () {
		      $("#lugar").flexigrid
				({
					method: 'POST',
					 url: '../SEdificioTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idedificio', width: 40, sortable: true, align: 'left' },
					{ display: 'Nombre', name: 'nombre', width: 100, sortable: true, align: 'left' },
					{ display: 'Direccion', name: 'dir', width: 100, sortable: true, align: 'left' },
					{ display: 'Telefono', name: 'telefono', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idedificio",
					sortorder: "desc",
				    title: 'LUGAR',
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Nombre', name : 'nombre'},
					{display: 'Direccion', name : 'dir', isdefault: true}
					]
				});
		  });  
		  function LimpiarEdificio(){
		  	$("#id_lugar").text("NEW");
		  	$("#nombre_lugar").val("");
		  	$("#dir_lugar").val("");
		  	$("#tel_lugar").val("");
		  	$("#lugar").flexReload();
		  	RecargarEdificio();
		  	idedificio=0;
		  }
		  function GuardarEdificio(){
			  var action='guardar_edificio';
			  if(idrespon==0){
				  action='guardar_edificio';
			  }else{
				  action='modificar_edificio';
			  }
			  
			  
			  var nombre=convertirCaracter($.trim($("#nombre_lugar").val()));
			   var direccion=convertirCaracter($.trim($("#dir_lugar").val()));
			  cadena = [ 'idedificio='     + idedificio,
				            'a='+action,
				            'nombre='+Base64.encode(nombre),
				            'direccion='+Base64.encode(direccion),
				            'telefono='+$("#tel_lugar").val()
				        ].join('&');
			  $.ajax({
			        url: "../SEdificio",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		LimpiarEdificio();
			        	}
			        }
			    });
			  
		  }
		  function EliminarEdificio(){
			  cadena = [ 'a=eliminar_edificio',
				            'idedificio='     + idedificio,
				        ].join('&');
				 
				 $.ajax({
				        url: "../SEdificio",
				        data: cadena,
				  	    type: 'post',
				  	  	dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		LimpiarEdificio();
				        	}
				        }
				    });
		  }
		  function EditarEdificio(id){
			  $("#id_lugar").text(id);
			  idedificio=id;
			  cadena = [ 'idedificio='     + idedificio,
				            'a=show_edificio',
				        ].join('&');
			  $.ajax({
			        url: "../SEdificio",
			        data: cadena,
			  	    type: 'post',
			        success: function(data){
			        	result=eval("("+ data+")");
			        	$("#nombre_lugar").val(result.nombre);
					  	$("#dir_lugar").val(result.direccion);
					  	$("#tel_lugar").val(result.telefono); 
			        }
			    });
		  }
		</script>
		<table id="lugar" style="display:none"></table>
		<table>
					<tr>
						<td>ID</td>
						<td><label id="id_lugar" >NEW</label></td>
					</tr>
					<tr>
						<td>Nombre</td>
						<td><input id='nombre_lugar' type="text" size="50"/></td>
					</tr>
					<tr>
						<td>Direccion</td>
						<td><input id='dir_lugar' type="text" size="50"/></td>
					</tr>
					<tr>	
						<td>Telefono</td>
						<td><input id='tel_lugar' type="text" size="20"/></td>
					</tr>
						
				</table>
				
			<center>
									<br/><br/>
									
										<a href="#" class="ui-state-default ui-corner-all button-save" onclick="LimpiarEdificio()" > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
									<%if (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
										<a href="#" class="ui-state-default ui-corner-all button-save" onclick="GuardarEdificio()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<%} %>
									<%if (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
										<a href="#" class="ui-state-default ui-corner-all button-delete" onclick="EliminarEdificio()"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<%} %>
									<br/><br/>		
			</center>
<% }	} %>				