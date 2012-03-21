<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Unidad de Salud / USAC</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link rel="shortcut icon" href="../favi.ico" type="image/x-icon" />
<link type="text/css" href="../css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../css/style_admin.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
<link rel="stylesheet" type="text/css" href="../css/jquery.cleditor.css" />

<script type="text/javascript" src="../lib/jquery-1.7.1.min.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/system_admin.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery-ui-1.8.17.custom.min.js" charset="utf-8"></script>
<script src="../lib/i18n/ui.datepicker-es.js"></script>
<script src="../lib/base64.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../lib/flexigrid.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery.cleditor.min.js"></script>
<script src="../lib/fileupload/vendor/jquery.ui.widget.js"></script>
<script src="../lib/fileupload/jquery.iframe-transport.js"></script>
<script src="../lib/fileupload/jquery.fileupload.js"></script>
<script src="../lib/jquery.maskedinput-1.2.2.js"></script>

<script type="text/javascript">
     

function onBlur() {
	document.body.className = 'blurred';
};
function onFocus(){
	document.body.className = 'focused';
	$.ajax({
        url: "../SValidLogin",
  	    type: 'post',
        success: function(data){
        	    	if (data==1){	
		                document.location='../index.jsp';
		            }
        }
    });
};

if (/*@cc_on!@*/false) { 
	document.onfocusin = onFocus;
	document.onfocusout = onBlur;
} else {
	window.onfocus = onFocus;
	window.onblur = onBlur;
}

     


    </script>