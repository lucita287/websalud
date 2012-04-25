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
		var idrespon=0;
		  $(document).ready(function () {
		      $("#responsable").flexigrid
				({
					method: 'POST',
					 url: '../SResponsableTable',
					 dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idresponsable', width: 40, sortable: true, align: 'left' },
					{ display: 'Nombre', name: 'nombre', width: 100, sortable: true, align: 'left' },
					{ display: 'Apellido', name: 'apellido', width: 100, sortable: true, align: 'left' },
					{ display: 'Area', name: 'area', width: 100, sortable: true, align: 'left' }
					],
					usepager: true,
				    sortname: "idactividad",
					sortorder: "desc",
				    title: 'ACTIVIDAD',
				    useRp: true,
				    rp: 15,
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    searchitems : [
					{display: 'Nombre', name : 'nombre'},
					{display: 'Apellido', name : 'apellido', isdefault: true},
					{display: 'Area', name : 'area'}
					]
				});
		  });  
		  function EditarResponsable(idresponsable){
			  idrespon=idresponsable;
			  cadena = [ 'idresponsable='     + idrespon,
				            'a=show_responsable',
				        ].join('&');
			  $.ajax({
			        url: "../SResponsable",
			        data: cadena,
			  	    type: 'post',
			        success: function(data){
			        	result=eval("("+ data+")");
			        	  $('#nombre_respon').val(result.nombre);
						  $('#apellido_respon').val(result.apellido);
						  $('#area_respon').val(result.idarea);
						  $('#usuario_respon').val(result.idusuario);
						  $('#id_respon').text(idresponsable);
			        }
			    });
		  }
		  function EliminarResponsable(){
			  cadena = [ 'a=eliminar_responsable',
				            'idresponsable='     + idrespon,
				        ].join('&');
				 
				 $.ajax({
				        url: "../SResponsable",
				        data: cadena,
				  	    type: 'post',
				  	  	dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		LimpiarResponsable();
				        	}
				        }
				    });
		  }
		  function GuardarResponsable(){
			  var action='guardar_responsable';
			  if(idrespon==0){
				  action='guardar_responsable';
			  }else{
				  action='modificar_responsable';
			  }
			  var nombre=($.trim($('#nombre_respon').val()));
				var apellido=($.trim($('#apellido_respon').val()));
			  cadena = [ 'idresponsable='     + idrespon,
				            'a='+action,
				            'nombre='+nombre,
				            'apellido='+apellido,
				            'idarea='+$('#area_respon').val(),
				            'usuario='+$('#usuario_respon').val(),
				        ].join('&');
			  $.ajax({
			        url: "../SResponsable",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		LimpiarResponsable();
			        	}
			        }
			    });
			  
		  }
		  function LimpiarResponsable(){
			  $('#nombre_respon').val("");
			  $('#apellido_respon').val("");
			  $('#area_respon').val(1);
			  $('#usuario_respon').val(0);
			  $('#id_respon').text('NEW');
			  $("#responsable").flexReload(); 
			  idrespon=0;
			  RecargarResponsable();
		  }
		  
		</script>
		<table id="responsable" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_respon">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Nombre</div>
								<div class="col"><input id='nombre_respon' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Apellido</div>
								<div class="col"><input id='apellido_respon' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Area Profesional</div>
								<div class="col">
								<select id='area_respon'>
									<% for(int j=0; j<list.size();j++){ 
											CArea area=list.get(j);%>
											<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
									<% } %>
								</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Usuario</div>
								<div class="col">
								<select id='usuario_respon' >
										<option value="0"  >No tiene asignado Usuario</option>
									<% for(int j=0; j<list_usuario.size();j++){ 
											CUsuario user=list_usuario.get(j);%>
											<option value="<%=user.getidusuario()%>"  ><%= user.getnick()+"/"+user.getnombre()+" "+user.getapellido()%></option>
									<% } %>
								</select>
								</div>
							</div>
		
					</div>
			</div>		
			<div class="center_button_2">
										<a href="#" class="ui-state-default ui-corner-all button-save" onclick="LimpiarResponsable()" > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
									<%if (user_permiso.getIdpermiso().indexOf(229)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>	
										<a href="#" class="ui-state-default ui-corner-all button-save" onclick="GuardarResponsable()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
									<%} %>
									<%if (user_permiso.getIdpermiso().indexOf(230)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
										<a href="#" class="ui-state-default ui-corner-all button-delete" onclick="EliminarResponsable()"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									<%} %>
		</div>
<% }	} %>				 