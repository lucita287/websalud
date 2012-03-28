<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
String titulo=(request.getParameter("titulo")==null)?"":request.getParameter("titulo");


%>    
<div style="float:left">
<img src="images/usalud.png" width="100px" height="100px" />
</div>
<div style="float: right;" class="ui-widget-content ui-corner-all">
<h2>Compatible con</h2>
<p>
<img width="31px" height="30px" title="Internet Explorer" alt="Internet Explorer" src="images/compatible_ie.gif"/>
<img width="31px" height="30px" title="Firefox" alt="Firefox" src="images/compatible_firefox.gif"/>
<img width="28px" height="30px" title="Opera" alt="Opera" src="images/compatible_opera.gif"/>
<img width="31px" height="30px" title="Google Chrome" alt="Google Chrome" src="images/compatible_chrome.gif"/>
<img width="28px" height="30px" title="Safari" alt="Safari" src="images/compatible_safari.gif"/>
</p>
</div>
<div style="float:left" >
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph"><%=titulo%></a></h2>
</div>
<div style="clear: both;"></div>    