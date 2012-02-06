

	<style type="text/css">
        #tabs {width: 95%;
            margin:0 auto 0 auto;
			}
	
		
        </style>
         <script type="text/javascript">
         
  $(function() {
		$( "#tabs" ).tabs();
	});
	
  $(document).ready(function () {
      $("#flex1").flexigrid
		({
		    dataType: 'json',
		    colModel: [
			{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
			{ display: 'idmenu', name: 'idmenu', width: 40, sortable: true, align: 'left' },
			{ display: 'descripcion', name: 'descripcion', width: 100, sortable: true, align: 'left' },
			{ display: 'area', name: 'area', width: 100, sortable: true, align: 'left' },
			{ display: 'contenido', name: 'contenido', width: 150, sortable: true, align: 'left' },
			{ display: 'menu_rec', name: 'menu_rec', width: 100, sortable: true, align: 'left' }
			],
		    sortname: "idmenu",
		    sortorder: "asc",
		    usepager: true,
		    title: 'Contenido',
		    useRp: true,
		    rp: 15,
		    showTableToggleBtn: true,
		    width: 600,
		    height: 200
		});


      
      $.post("../SEditContenido",
          function (data) {                    
              var arr = Array();
              arr = eval("(" + data + ")");                    
              $('#flex1').flexAddData(arr);                    
       });            
      $('#cont-text').elrte({
			cssClass : 'el-rte',
			lang     : 'es',
			width	 : 600,
		    height	 : 200,
		    toolbar  : 'complete',
			cssfiles : ['../css/elrte-inner.css']
		});
      });

  	function editar(idmenu){
  		$('#edit-id').text(idmenu);
  		 cadena = [ 'idmenu='     + idmenu,
  		        ].join('&');
  		
  		$.ajax({
  	        url: "../SMenu",
  	        data: cadena,
	  	    type: 'post',
	        dataType: 'json',
  	        success: function(data){
  	        	
				$('#edit-area').text(data.areanombre);	
				$('#edit-submenu').text(data.submenu);
  	        	$('#edit-titulo').val(data.descripcion);
  					$('#editconte').elrte({			
  							cssClass : 'el-rte',
  							lang     : 'es',
  							width	 : 600,
  						    height	 : 200,
  						    toolbar  : 'complete',
  							cssfiles : ['../css/elrte-inner.css']
  	        		});
  					$('#editconte').elrte('val', data.contenido);
  	        }
		
  	    });
  		
  	}
	</script> 
        
        
    	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Nueva Entrada</a></li>
				<li><a href="#tabs-2">Editar Entrada</a></li>

			</ul>
			<div id="tabs-1" style="width:1000px; ">
				Titulo: <input type="text" size="60" /><br/>
				Area Pertenece:<br/>
				Sub Parte:<br/>
					
			<div id="cont-text"></div>	
			</div>
			<div id="tabs-2" style="width:1000px; ">
			
			<table id="flex1" style="display:none"></table>
				ID:  <label id="edit-id"></label><br/>
				Titulo: <input id="edit-titulo" type="text" size="60" /><br/>
				Area Pertenece: <label id="edit-area"></label><br/>
				Sub Parte: <label id="edit-submenu"></label><br/>
				<div id="editconte"></div>
				
				<a href="#" id="button" class="ui-state-default ui-corner-all"> <img src="../images/save.png"/>Guardar</a>
			<div style="clear: both;"></div>
			
			</div>
    </div>
    
