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

$("#flex1").flexigrid({

	url: '../SContenido',

	dataType: 'json',

	colModel : [

		{display: 'ISO', name : 'iso', width : 40, sortable : true, align: 'center'},

		{display: 'Name', name : 'name', width : 100, sortable : true, align: 'left'},

		{display: 'Printable Name', name : 'printable_name', width : 100, sortable : true, align: 'left'},

		{display: 'ISO3', name : 'iso3', width : 100, sortable : true, align: 'left', hide: true},

		{display: 'Number Code', name : 'numcode', width : 80, sortable : true, align: 'right'}

		],

	searchitems : [

		{display: 'ISO', name : 'iso'},

		{display: 'Name', name : 'name', isdefault: true}

		],

	sortname: "iso",

	sortorder: "asc",

	usepager: true,

	title: 'Countries',

	useRp: true,

	rp: 15,

	showTableToggleBtn: true,

	width: 600,

	onSubmit: addFormData,

	height: 200

});



//This function adds paramaters to the post of flexigrid. You can add a verification as well by return to false if you don't want flexigrid to submit			

function addFormData(){

	//passing a form object to serializeArray will get the valid data from all the objects, but, if the you pass a non-form object, you have to specify the input elements that the data will come from

	var dt = $('#sform').serializeArray();

	$("#flex1").flexOptions({params: dt});

	return true;

}

	


</script>