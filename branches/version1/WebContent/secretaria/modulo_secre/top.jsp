<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<link type="text/css" href="../css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link rel='stylesheet' type='text/css' href="../css/jquery.weekcalendar.css" />
<link rel='stylesheet' type='text/css' href="../css/system_secre.css" />
<link rel='stylesheet' type='text/css' href="../css/styles.css" />
<link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
<script type="text/javascript" src="../lib/jquery-1.7.1.min.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery-ui-1.8.17.custom.min.js" charset="utf-8"></script>
<script type='text/javascript' src='../lib/jquery.weekcalendar.js'></script>
<script type='text/javascript' src='../lib/date.js'></script>
<script src="../lib/i18n/ui.datepicker-es.js"></script>
<script type="text/javascript" src="../lib/flexigrid.js" charset="utf-8"></script>
<script type="text/javascript" src="../lib/jquery.maskedinput-1.2.2.js"></script>
<script type="text/javascript" src="../lib/system_admin.js"></script>
<link rel="shortcut icon" href="../favi.ico" type="image/x-icon" />

<script type="text/javascript">
     

function onBlur() {
	document.body.className = 'blurred';
};
function onFocus(){
	document.body.className = 'focused';
	$.ajax({
        url: "../SValidSecre",
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