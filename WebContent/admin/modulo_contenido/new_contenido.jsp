<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CUsuarioPermiso" %>
<%
	CDataBase	data=new CDataBase();
		data.Connect();
		ArrayList<CArea> list=data.getAreaLista();
		ArrayList<CMenu> list_me=data.getMenu(1); 
		data.Close();

HttpSession sessiones = request.getSession(false);
if(sessiones!=null &&  sessiones.getAttribute("user_permiso")!=null){

CUsuarioPermiso user_permiso=(CUsuarioPermiso)sessiones.getAttribute("user_permiso");

if (user_permiso.getIdpermiso().indexOf(224)>-1  || user_permiso.getIdusuario().getidusuario()==1){%>
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
							<option value="<%=area.getidarea()%>" <%=(area.getidarea()==1?"selected":"") %>><%= area.getnombre()%></option>
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
				
				<script  type="text/javascript">

			  $(document).ready(function () {
				  $("#cont-text").cleditor({
					    width:        600,
					    height:       250,
					    controls:     // controls to add to the toolbar
	                        "bold italic underline strikethrough subscript superscript | font size " +
	                        "style | color highlight removeformat | bullets numbering | outdent " +
	                        "indent | alignleft center alignright justify | undo redo | " +
	                        "rule image link unlink | cut copy paste pastetext | print"
					    });
				  $("#cont-text").cleditor()[0].focus();
			  });
			  $( function(){
					
				  var cledit = $("#cont-text").cleditor()[0];
				  $(cledit.$frame[0]).attr("id","cleditCool");

				  var cleditFrame;
				  if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
				  else cleditFrame = document.frames["cleditCool"].document;
				    
			$(cleditFrame).contents().find('body').bind('paste', function(){
				  
			      setTimeout(function() {
			          mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
			      	$("#cont-text").cleditor()[0].clear();
			      }, 100);
			     
			});
			} );
			  
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
	<%	}
} %>			