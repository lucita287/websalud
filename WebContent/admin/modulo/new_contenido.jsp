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
			 function convertirCaracter(caracter){
					caracter=replaceAll(caracter,"á","&aacute;");
					caracter=replaceAll(caracter,"é","&eacute;");
					caracter=replaceAll(caracter,"í","&iacute;");
					caracter=replaceAll(caracter,"ó","&oacute;");
					caracter=replaceAll(caracter,"ú","&uacute;");
					caracter=replaceAll(caracter,"Á","&Aacute;");
					caracter=replaceAll(caracter,"É","&Eacute;");
					caracter=replaceAll(caracter,"Í","&Iacute;");
					caracter=replaceAll(caracter,"Ó","&Oacute;");
					caracter=replaceAll(caracter,"Ú","&Uacute;");
					caracter=replaceAll(caracter,"ñ","&ntilde;");
					caracter=replaceAll(caracter,"Ñ","&Ntilde;");
					return caracter;
				}
			  function replaceAll( text, busca, reemplaza ){
				  while (text.toString().indexOf(busca) != -1)
				      text = text.toString().replace(busca,reemplaza);
				  return text;
				}
			  $(document).ready(function () {
				  $("#cont-text").cleditor({
					    width:        600,
					    height:       250
					    });
				  $("#cont-text").cleditor()[0].focus();
			  });
			  
			  function Guardarnew(){

					  if($.trim($('#new-titulo').val())!=""){
						  if($('#new-submenu').val()>0){	
								  var data_cont=Base64.encode(convertirCaracter($('#cont-text').val()));
								  var titulo=Base64.encode(convertirCaracter($('#new-titulo').val()));
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
									        	mensaje(data.mensaje);
									        	if(data.resultado=="OK"){
									        		limpiar();
									        	}
									        }
										
									    }); 
						  }else{
							  $("#validacion_prin").html("Debe seleccionar un SubMenu");
						  }		  
							  
					  }else{
						  $("#validacion_prin").html("El titulo no puede estar vacio");
					  }
			  }
			function mensaje(mens){
				  
				  $( "#dialog-message" ).html(mens);
					$( "#dialog-message" ).dialog({
						modal: true,
						buttons: {
							Ok: function() {
								$( this ).dialog( "close" );
							}
						}
					});
			  }
			function limpiar(){
				$("#cont-text").cleditor()[0].clear();
        		$('#new-titulo').val('');
			}
			</script>
			<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
			<div class="centerd">
			<H2>Nuevo Contenido</H2>
			</div>
				<div id="validacion_prin" class="validacion"></div>
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
						<option value="3">Grande</option>
						<option value="2">Mediano</option>
						<option value="1">Peque&ntilde;o</option>
						<option value="0">Sin Texto</option>
				</select>
				<textarea id="cont-text" class="editor"></textarea>
				<br/><br/>
				<div class="centerd">
						<a href="#validacion_prin" class="ui-state-default ui-corner-all button-save" onclick="Guardarnew()"> <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
					<a href="#validacion_prin" class="ui-state-default ui-corner-all button-delete" onclick="limpiar()"> <img  width="24px"  height="24px" src="../images/add.png" /> Limpiar</a>	
				</div>
				<br/><br/>	
				<div style="clear: both;"></div>