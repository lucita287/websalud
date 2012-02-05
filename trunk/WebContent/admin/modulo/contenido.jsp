	<script>
	$(function() {
		$( "#tabs" ).tabs();
	});
	
	$().ready(function() {
		var opts = {
			cssClass : 'el-rte',
			// lang     : 'ru',
			height   : 300,
			width	 : 600,
			toolbar  : 'complete',
			cssfiles : ['../css/elrte-inner.css']
		};
		$('#cont-text').elrte(opts);
	});
	
	</script>	
	<style type="text/css">
        #tabs {width: 95%;
            margin:0 auto 0 auto;
			}
	
		
        </style>
    	<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Nueva Entrada</a></li>
				<li><a href="#tabs-2">Editar Entrada</a></li>

			</ul>
			<div id="tabs-1" style="width:1000px; ">
				Titulo: <input type="text" size="60" /><br/>
				Area Pertenece:<br/>
				Sub Parte:<br/>
					
			<textarea class="wysiwyg" rows="5" cols="80"></textarea>
				
			</div>
			<div id="tabs-2" style="width:1000px; ">
			
			<table id="flex1" style="display:none"></table>
				ID:  <label id="edit-id"></label><br/>
				Titulo: <input id="edit-titulo" type="text" size="60" /><br/>
				Area Pertenece:<br/>
				Sub Parte:<br/>
				<div id="cont-text"></div>

			<div style="clear: both;"></div>
			
			</div>
    </div>
    
  <script type="text/javascript">
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
  	        	
					$('edit-titulo').val();
  					$('#cont-text').elrte('val', data.contenido);
  				
  	        }
		
  	    });
  		
  	}
	


</script>