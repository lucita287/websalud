	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <script>
		function EditarCatePonderacion(id){
			 $("#editor").cleditor()[0].clear();
			idcate_pond=id;
			cadena = [ 'a=show_cate_pond',
			            'idcate_pond='     + id,
			        ].join('&');
			$("#id_ponde").text(id);
			$.ajax({
		        url: "../SCategoria",
		        data: cadena,
		  	    type: 'post',
		        success: function(data){
		        	var data_desc=Base64.decode( data );
		        	result=eval("("+ data_desc+")");
				        	$("#min_ponde").val(result.min);
				        	$("#max_ponde").val(result.max);
				        	$("#editor").cleditor()[0].execCommand("inserthtml",result.interpretacion,null,null);
							$("#editor").cleditor()[0].focus();
		        	}
		    });
		}
		  $(document).ready(function () {
			  $("#categoria_ponderacion").flexigrid
				({
					method: 'POST',
					url: '../SCategoriaTable',
					dataType : 'xml',
				    colModel: [
					{display: 'Seleccionar', name : 'chkcategoria', width : 30, sortable : false, align: 'left'},           
					{ display: 'ID', name: 'idcategoria_ponderacion', width: 40, sortable: true, align: 'left' },
					{ display: 'Max', name: 'min', width: 40, sortable: true, align: 'left' },
					{ display: 'Min', name: 'max', width: 40, sortable: true, align: 'left' },
					{ display: 'Categoria', name: 'Categoria', width: 200,  align: 'left' }
					],
					sortname: "idcategoria_ponderacion",
					sortorder: "desc",
				    title: 'Categoria Ponderaci&oacute;n',
				    showTableToggleBtn: true,
				    width: 600,
				    height: 200,
				    params : [ {name: 'idcategoria', value: '0'},{name: 'a', value: 'ponderacion'} ]
				});
		      $("#editor").cleditor({
				    width:        450,
				    height:       300,
				    controls:     // controls to add to the toolbar
                    "bold italic underline strikethrough subscript superscript | font size " +
                    "style | color highlight removeformat | bullets numbering | outdent " +
                    "indent | alignleft center alignright justify | undo redo | " +
                    "rule image link unlink | cut copy paste pastetext | print"
				    });
				$("#editor").cleditor()[0].focus();
		  });  
		  var idcate_pond=0;
			$(function() {
				$( ".check" ).button();
				var cledit = $("#editor").cleditor()[0];
				$(cledit.$frame[0]).attr("id","cleditCool");
			
				var cleditFrame;
				if(!document.frames) cleditFrame = $("#cleditCool")[0].contentWindow.document;
				else cleditFrame = document.frames["cleditCool"].document;
				    
			$(cleditFrame).contents().find('body').bind('paste', function(){
				  
			      setTimeout(function() {
			          mensaje("Utilice el pegar, de la barra de herramientas \n pegar como texto");
			      	$("#editor").cleditor()[0].clear();
			      }, 100);
			     
			});
			} );  
			function NewPonde(){
				$("#min_ponde").val("0");
	        	$("#max_ponde").val("0");
	        	idcate_pond=0;
				$("#id_ponde").text("NEW");
				$('#categoria_ponderacion').flexOptions({ params : [{name: 'idcategoria', value: idcate},{name: 'a', value: 'ponderacion'}]});
				$('#categoria_ponderacion').flexReload();
				$("#editor").cleditor()[0].clear();
				$("#editor").cleditor()[0].focus();
			}
			function GuardarPonde(){
				var interpretacion=Base64.encode(($.trim($("#editor").val())));
				if(idcate_pond==0){
					action="new_cate_pond";
				}else{
					action="safe_cate_pond";						
				}
				cadena = [ 'a='+action,
				            'idcate_pond='     + idcate_pond,
				            'interpretacion='+interpretacion,
				            'min='+$("#min_ponde").val(),
				            'max='+$("#max_ponde").val(),
				            'idcategoria='   + idcate,
				        ].join('&');
				 $.ajax({
				        url: "../SCategoria",
				        data: cadena,
				  	    type: 'post',
				        dataType: 'json',
				        success: function(data){
				        	mensaje(data.mensaje);
				        	if(data.resultado=='OK'){
				        		NewPonde();
				        	}
				        }
				    });
			}
			function DelPonde(){
				 var action="deletecate_ponde";
				  
				  cadena = [ 	'idcate_pond='     + idcate_pond,
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
				        		NewPonde();
				        	}
				        }
				    });
			}
		</script>
		<H2><label id="cate_catego_ponde">SELECCIONE LA CATEGORIA</label></H2>
<table id="categoria_ponderacion" style="display:none"></table>	

		<div class="perfil">
				<div class="tabla">
							<div class="fila">
								<div class="col_titulo">ID</div>
								<div class="col"><label id="id_ponde">NEW</label></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Minimo</div>
								<div class="col"><input id='min_ponde' type="text" size="10"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Maximo</div>
								<div class="col"><input id='max_ponde' type="text" size="10"/></div>
							</div>
							<div class="fila">
								<div class="col_titulo">*Interpretaci&oacute;n</div>
								<div class="col">
									<div style="clear: both;"></div>
									<textarea  id="editor" class="editor" ></textarea>
									<div style="clear: both;"></div>
								</div>
							</div>
				</div>
		</div>					
	<div style="clear: both;"></div>
					<div class="center_button_2">
										<a  onclick="NewPonde()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/add.png" />Nuevo</a>
										<a  onclick="GuardarPonde()" class="ui-state-default ui-corner-all button-save" > <img  width="24px"  height="24px" src="../images/guardar.png" /> Guardar</a>
										<a  onclick="DelPonde()" class="ui-state-default ui-corner-all button-delete" > <img  width="24px"  height="24px" src="../images/delete.png" /> Eliminar</a>	
									
					</div>