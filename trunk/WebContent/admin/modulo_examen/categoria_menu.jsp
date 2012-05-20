		<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    	<%@ page import="data.CArea_Examen" %>
    	<%@ page import="framework.CDataExam" %>
    	<%@ page import="java.util.ArrayList" %>
    	<%@ page import="java.util.Iterator" %>
<%
CDataExam dbo=new CDataExam();
if(dbo.Connect()){
ArrayList<CArea_Examen> list= dbo.getListaArea_Examen();
	%>
		<script>
		
		var idmenu_categoria=0;
		  $(document).ready(function () {
			  	
		      $("#m_categoria").flexigrid
				({
					method: 'POST',
					url: '../SCategoriaTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkm_categoria', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idm_categoria', width: 40, sortable: true, align: 'left' },
					{ display: 'Menu', name: 'nombre', width: 250, sortable: true, align: 'left' },
					{ display: 'Area', name: 'area', width: 250, sortable: true, align: 'left' }
					],
					usepager: true,
					sortname: "idm_categoria",
					sortorder: "desc",
				    title: 'Menu Categoria',
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    useRp: true,
				    rp: 20,
				    searchitems : [{display: 'Menu', name : 'menu'}],
				    params : [ {name: 'a', value: 'menu_categoria'} ]
				});
		      
		      $("#cont-text").cleditor({
				    width:        500,
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
		        	$("#cont-text").cleditor()[0].focus();
		        }, 100);
		       return false;
		  });
		  } );
		  function Editarmenu_categoria(id,nombre){
			  $("#cont-text").cleditor()[0].clear();
			  $("#id_menu_categoria").text(id);
			  idmenu_categoria=id;
			  cadena = [ 'idmenu_categoria='     + idmenu_categoria,
				            'a=show_menu_categoria',
				        ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			  	  	success: function(data){
			  	  		var data_desc=Base64.decode( data );
			        	result=eval("("+data_desc+")");
			        	
			        	$('#nombre_menu_categoria').val(result.nombre);
			        	$('#area_menu_categoria').val(result.area);
			        	$("#cont-text").cleditor()[0].execCommand("inserthtml",result.contenido,null,null);
						$("#cont-text").cleditor()[0].focus();
						
			        }});
		  }
		  
		  
		  function limpiarmenu_categoria(){
			  $("#cont-text").cleditor()[0].clear();
			  $("#id_menu_categoria").text("NEW");
			  $("#nombre_menu_categoria").val("");
			  idmenu_categoria=0;
			  $('#m_categoria').flexReload();
		  }
		  function Guardarmenu_categoria(){
			  var action="guardarmenu_categoria";
			  if(idmenu_categoria<=0){
				  action="newmenu_categoria";
			  }
			  var contenido=convertirCaracter($('#cont-text').val());
			  var data_cont=Base64.encode(contenido);
			  var titulo=convertirCaracter($('#nombre_menu_categoria').val());
			  var data_titulo=Base64.encode(titulo);
			  cadena = [ 	'id_menu_categoria='   + idmenu_categoria,
			             	'a='+action,
				            'nombre='+data_titulo,
				            'idarea='+$("#area_menu_categoria").val(),
				            'contenido='+data_cont,
				        ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarmenu_categoria();
			        	}
			        }
			    });
		  }
		  function Eliminarmenu_categoria(){
			  var action="deletemenu_categoria";
			  
			  cadena = [ 	'id_menu_categoria='   + idmenu_categoria,
			             	'a='+action
			            ].join('&');
			  $.ajax({
			        url: "../SCategoria",
			        data: cadena,
			  	    type: 'post',
			        dataType: 'json',
			        success: function(data){
			        	mensaje(data.mensaje);
			        	if(data.resultado=='OK'){
			        		limpiarmenu_categoria();
			        	}
			        }
			    });
		  }
		  
		  
		</script>
		<div id="dialog-message" title="Mensaje de Informaci&oacute;n"></div>
		<table id="m_categoria" style="display:none"></table>
		
		
		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_menu_categoria">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Menu</div>
								<div class="col"><input id='nombre_menu_categoria' type="text" size="40"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">Area profesional</div>
								<div class="col">
											<select  id='area_menu_categoria'>
											<% 
												Iterator<CArea_Examen> it=list.iterator();
												while(it.hasNext()){
													CArea_Examen area=it.next();
											%>
												
												  <option value="<%= area.getIdarea_examen() %>"><%= area.getNombre() %></option>
												  
											<% }%>
											</select>
								</div>
							</div>
							<div class="fila">
								<div class="col_titulo">Descripci&oacute;n</div>
								<div class="col"><textarea id="cont-text" class="editor"></textarea>
								<div style="clear: both;"></div></div>
							</div>
							
				</div>
		</div>
		<div style="clear: both;"></div>				
					<div class="center_button_2">
										<a href="#" onclick="limpiarmenu_categoria()" class="ui-state-default ui-corner-all button-save"  > <img  width="24px"  height="24px" src="../images/add.png" /> Nuevo</a>
										<a href="#" onclick="Guardarmenu_categoria()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a href="#" onclick="Eliminarmenu_categoria()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>
					</div>
<% } %>