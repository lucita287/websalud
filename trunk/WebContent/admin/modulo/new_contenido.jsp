<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CMenu> list_me=data.getMenu(1); 
		data.Close();
%>

			<script  type="text/javascript">
			  $(document).ready(function () {
			              
			      $('.editor').elrte({
						cssClass : 'el-rte',
						lang     : 'es',
						width	 : 600,
					    height	 : 200,
					    toolbar  : 'complete',
						cssfiles : ['../css/elrte-inner.css']
					});
			  });
			  
			  function Guardarnew(){

					  if($.trim($('#new-titulo').val())!=""){
						  if($('#new-submenu').val()>0){	
								  var data_cont=Base64.encode($('#cont-text').elrte('val'));
								  var titulo=Base64.encode($('#new-titulo').val());
								  var submenu=$('#new-submenu').val();
									cadena = [ 	'a=guardarnew',
										            'titulo='+titulo,
										            'contenido='+data_cont,
										            'size='+$('#new-tam').val(),
										            'area='+$('#new-area').val(),
										            'submenu='+submenu
										        ].join('&');
									 $("#validacion").html("No se ha actualizado"); 
									  $.ajax({
									        url: "../SMenu",
									        data: cadena,
									  	    type: 'post',
									        dataType: 'json',
									        success: function(data){
									        	if(data.resultado=="OK"){
									        		$("#validacion").html(data.mensaje);
									        	}else{
									        		$("#validacion").html(data.mensaje);	
									        	}
									        }
										
									    }); 
						  }else{
							  $("#validacion").html("Debe seleccionar un SubMenu");
						  }		  
							  
					  }else{
						  $("#validacion").html("El titulo no puede estar vacio");
					  }
			  }
			  
			</script>
				<div id="validacion"></div>
				Titulo: <input id="new-titulo" type="text" size="60" /><br/>
				Area Pertenece:
					<select id="new-area" onchange="cambiarArea()">
						<% for(int j=0; j<list.size();j++){ 
							CArea area=list.get(j);
						%>
							<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getdescripcion()%></option>
						<% } %>
					</select><br/>
				Sub Parte: <select id="new-submenu">
						<% for(int i=0; i<list_me.size(); i++){
							CMenu men=list_me.get(i);%>
							<option value="<%=men.getidmenu()%>"><%= men.getdescripcion()%></option>
						<%} %> 
						
						</select>
				<br/>
				Tama&ntilde;o:<select id="new-tam"> 
						<option value="4">Grande</option>
						<option value="3">Mediano</option>
						<option value="1">Peque&ntilde;o</option>
						<option value="0">Sin Texto</option>
				</select>
				<div id="cont-text" class="editor"></div>
				<br/><br/>
				<div class="centerd">
						<a href="#" class="ui-state-default ui-corner-all button-save" onclick="Guardarnew()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#" class="ui-state-default ui-corner-all button-delete"> <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
				</div>
				<br/><br/>	
				<div style="clear: both;"></div>