<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Unidad de Salud / USAC</title>
<meta name="keywords" content="" />
<meta name="description" content="" />

<link type="text/css" href="../css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link href="../css/style_admin.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
<link rel="stylesheet" type="text/css" href="../css/jquery.cleditor.css" />
<link rel="stylesheet" type="text/css" href="../css/colorbox.css" />

<script type="text/javascript" src="../lib/jquery-1.7.1.min.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/system_admin.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery-ui-1.8.17.custom.min.js" charset="utf-8"></script>
<script src="../lib/jcarousellite_1.0.1c4.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/base64.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../lib/flexigrid.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery.cleditor.min.js"></script>
<script src="../lib/fileupload/vendor/jquery.ui.widget.js"></script>
<script src="../lib/fileupload/jquery.iframe-transport.js"></script>
<script src="../lib/fileupload/jquery.fileupload.js"></script>
<script src="../lib/jquery.colorbox-min.js"></script>

<script>
$(document).ready(function () {
	 
});
    function abrir(mens){
    	$('#text_line').html(mens);
        parent.$.colorbox({
        	href:'#inline_content', 
            onOpen:function(){},
             onLoad:function(){
             $('#cboxClose').remove();},
             overlayClose:false,
             width:'300px',
             height:'300px',
             close:'',
             escKey:false,
             arrowKey:false
             });   

    	
    }
	$(function() {
		
		
		$("#prueba").keypress(function(e) {
		    if(e.keyCode == 13) {
		    	abrir('aaaaaaaaa aaaaaa');
		    }
		});
		
	});
    </script>
   <input type="text" id="prueba"/>
   <a onclick="abrir('mensajeeee holaaaaaaaaa')">guardar</a>
   <div style='display:none'>
			<div id='inline_content' style='padding:10px; background:#fff;'>
			<h3 class="ui-widget-header ui-corner-all">Mensaje de Informaci&oacute;n</h3>
				<div id="text_line"></div>
				<input type="button" id="button_login" class="ui-state-default ui-corner-all" value="OK"/>
			</div>
		</div>