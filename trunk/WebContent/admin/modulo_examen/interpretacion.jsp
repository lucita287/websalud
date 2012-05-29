<%@ page import="data.CUsuarioPermiso" %>
<%
HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){
	CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

		if (user_permiso.getIdpermiso().indexOf(257)>-1  || user_permiso.getIdusuario().getidusuario()==1){

%>

		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <%@ page import="framework.CDataExam" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="data.CTipo_Interpretacion" %>
    <% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    ArrayList<CTipo_Interpretacion> list=dbo.getListaTipo_Interpretacion();
    Iterator<CTipo_Interpretacion> it=list.iterator();
    %>
    
Busqueda por tipo Interpretaci&oacute;n<select id="tipo_inter_result" name="tipo_inter_result" onchange="cambiarTipo()">
<% while(it.hasNext()){
	CTipo_Interpretacion ctipo=it.next();
	%>
  <option value="<%=ctipo.getIdtipo_interpretacion() %>"><%=ctipo.getDescripcion() %></option>
<% } %>
</select>
<table id="interpretacion" style="display:none"></table>


    
    
 <script>
 $(document).ready(function () {
     $("#interpretacion").flexigrid
		({
			method: 'POST',
			 url: '../SInterpretacionTable',
			 dataType : 'xml',
		    colModel: [
			{display: 'Seleccionar', name : 'chkactividad', width : 30, sortable : false, align: 'left'},           
			{ display: 'ID', name: 'idresultado', width: 40, sortable: true, align: 'left' },
			{ display: 'Titulo', name: 'titulo', width: 250, sortable: true, align: 'left' },
			{ display: 'Tipo', name: 'tipo', width: 200, sortable: true, align: 'left' }
			],
			usepager: true,
		    sortname: "idresultado",
			sortorder: "desc",
		    title: 'Interpretacion',
		    useRp: true,
		    rp: 20,
		    showTableToggleBtn: true,
		    width: 600,
		    height: 200,
		    params : [{name: 'a', value: 'interpre'},{name: 'idtipo', value:$("#tipo_inter_result").val()} ],
		    searchitems : [
			{display: 'Titulo', name : 'nombre'}
			]
		});
 });
 $('.pSearch').click();
 var interpreta=0;
 function LimpiarInterPret(){
	 $("#id_interpre").text("NEW");
	 $("#titulo_interpre").val("");
	 $("#size_interpre").val("1");
	 $("#inter_interpre").val("");
	 interpreta=0;	
	 cambiarTipo();
 }
 function EditarInterpre(id){
	 interpreta=id;
	 $("#inter_interpre").val("");
		cadena = [ 'a=show_interpetar',
		            'id_interpre='     + id,
		        ].join('&');
		$("#id_interpre").text(id);
		$.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	  	    
	        success: function(data){
	        	
	        	result=eval("("+data+")");
	        	    
			        $("#titulo_interpre").val(result.titulo);
			       	$("#size_interpre").val(result.size);
			       	$("#inter_interpre").val(result.interpretacion);
			       	$("#tipo_interpre").val(result.tipo);
	        	}
	    });
		
 }
 function GuardarInterPret(){
	 if(interpreta==0){
			action="new_interpreta";
		}else{
			action="safe_interpreta";						
		}
	 
		cadena = [ 'a='+action,
		            'id_interpre='     +  interpreta,
		            'titulo='+$("#titulo_interpre").val(),
		            'size='+$("#size_interpre").val(),
		            'interpretacion='+$("#inter_interpre").val(),
		            'tipo='+$("#tipo_interpre").val()
		        ].join('&');
		 $.ajax({
		        url: "../SInterpretacion",
		        data: cadena,
		  	    type: 'post',
		        dataType: 'json',
		        success: function(data){
		        	mensaje(data.mensaje);
		        	if(data.resultado=='OK'){
		        		LimpiarInterPret();
		        	}
		        }
		    });
 }
 function cambiarTipo(){
	 $('#interpretacion').flexOptions({params : [{name: 'a', value: 'interpre'},{name: 'idtipo', value:$("#tipo_inter_result").val()} ]});
	  $('#interpretacion').flexReload();
	 $("#tipo_interpre").val( $("#tipo_inter_result").val());
}
 function EliminarInterPret(){
	 var action="deleteinter";
	  
	  cadena = [ 	'id_interpre='     + interpreta,
	             	'a='+action
	            ].join('&');
	  $.ajax({
	        url: "../SInterpretacion",
	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
	        success: function(data){
	        	mensaje(data.mensaje);
	        	if(data.resultado=='OK'){
	        		LimpiarInterPret();
	        	}
	        }
	    });
 }
 </script>
 <div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
 <div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_interpre" >NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Titulo</div>
								<div class="col"><input id='titulo_interpre' type="text" size="50"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Tama&ntilde;o</div>
								<div class="col">
											<select id="size_interpre" name="size_interpre">
											  <option value="1">Sin texto</option>
											  <option value="2">Pequeño</option>
											  <option value="3">Mediano</option>
											  
											</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Interpretacion</div>
								<div class="col">
									<textarea id='inter_interpre' name='inter_interpre' rows="6" cols="60"></textarea>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Tipo Interpretaci&oacute;n</div>
								<div class="col">
									<select id="tipo_interpre" name="tipo_interpre">
									<% 
									Iterator<CTipo_Interpretacion> it2=list.iterator();
									while(it2.hasNext()){
										CTipo_Interpretacion ctipo=it2.next();
										%>
									  <option value="<%=ctipo.getIdtipo_interpretacion() %>"><%=ctipo.getDescripcion() %></option>
									<% } %>
									</select>
								
								</div>
							</div>
				</div>
		</div>
		<div style="clear: both;"></div>
			<div class="center_button_2">
										<a  class="ui-state-default ui-corner-all button-save" onclick="LimpiarInterPret()" > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a  class="ui-state-default ui-corner-all button-save" onclick="GuardarInterPret()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a  class="ui-state-default ui-corner-all button-delete" onclick="EliminarInterPret()"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
									
			</div>
 <%
    dbo.Close();
    }
    }	}%>