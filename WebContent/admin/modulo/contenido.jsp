	<script>
	$(function() {
		$( "#tabs" ).tabs();
	});
	(function($) {
		$(document).ready(function() {
			$('#wysiwyg').wysiwyg();
		});
	})(jQuery);
	
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
				
				
			<textarea id="wysiwyg" rows="5" cols="80"></textarea>
				
			</div>
			<div id="tabs-2" style="width:1000px; ">
			
			<table id="flex1" style="display:none"></table>
			<div style="clear: both;"></div>
			
			</div>
    </div>
    
  <script type="text/javascript">
  $(document).ready(function () {
      $("#flex1").flexigrid
		({
		    dataType: 'json',
		    colModel: [
			{ display: 'idmenu', name: 'idmenu', width: 150, sortable: true, align: 'left' },
			{ display: 'descripcion', name: 'descripcion', width: 100, sortable: true, align: 'left' },
			{ display: 'area', name: 'area', width: 100, sortable: true, align: 'left' },
			{ display: 'contenido', name: 'contenido', width: 150, sortable: true, align: 'left' },
			{ display: 'menu_rec', name: 'menu_rec', width: 100, sortable: true, align: 'left' },
			],
		    searchitems: [
			{ display: 'idmenu', name: 'idmenu' },
			{ display: 'descripcion', name: 'descripcion', isdefault: true }
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


	


</script>