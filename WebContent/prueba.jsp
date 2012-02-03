<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Flexigrid</title>

<link rel="stylesheet" type="text/css" href="css/flexigrid.css"></link>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.5.2.min.js"></script>

<script type="text/javascript" src="lib/flexigrid.js"></script>

</head>

<body>

<p>This is a sample implementation attached to a form, to add additional parameters.</p>



<form id="sform">

	<p>

	The values you entered will be place in name column for demo's sake.<br />

	Value 1 : <input type="text" name="val1" value="" autocomplete="off" /><br />

    Value 2 : Is a hidden input with value 3<input type="hidden" name="val2" value="3" /><br />

    Value 3 : 

    <select name="val3">

    	<option value="1">One</option>

        <option value="2">Two</option>

        <option value="3">Three</option>

        <option value="4">Four</option>

        <option value="5">Five</option>

    </select><br />

    Value 4 : <input type="checkbox" name="val4" id="val4" value="4" /><label for="val4">This will pass a value 4 if checked</label>

    </p>

    <p>

	    <input type="submit" value="Submit" />

    </p>

</form>



<table id="flex1" style="display:none"></table>

<script type="text/javascript">

$("#flex1").flexigrid({

	url: 'post2.php',

	dataType: 'json',

	colModel: [
				{display: 'Seleccionar', name : 'chkDelete', width : 30, sortable : false, align: 'left'},           
				{ display: 'idmenu', name: 'idmenu', width: 40, sortable: true, align: 'left' },
				{ display: 'descripcion', name: 'descripcion', width: 100, sortable: true, align: 'left' },
				{ display: 'area', name: 'area', width: 100, sortable: true, align: 'left' },
				{ display: 'contenido', name: 'contenido', width: 150, sortable: true, align: 'left' },
				{ display: 'menu_rec', name: 'menu_rec', width: 100, sortable: true, align: 'left' }
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

	width: 700,

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

	

$('#sform').submit(function (){

	$('#flex1').flexOptions({newp: 1}).flexReload();

	return false;

});

</script>

</body>

</html>