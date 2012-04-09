<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Unidad de Salud / USAC</title>
<link rel="stylesheet" type="text/css" media="all" href="css/jquery.validate.password.css" />
<jsp:include page="portal/top.jsp" />

<script src="lib/jquery.maskedinput-1.2.2.js"></script>
<script src="lib/jquery.validate.js"></script>
<script src="lib/jquery.validate.password.js"></script>
<script src="lib/i18n/jquery.validator-es.js"></script>
<script src="lib/i18n/ui.datepicker-es.js"></script>
</head>
<body>
<div class="back_all">
<div id="content">
<div class="top">
<jsp:include page="portal/titulo.jsp">
<jsp:param name="titulo" value="Portal" />	
</jsp:include>
</div>
<div id="back" class="ui-widget-content ui-corner-all">
<div id="main">

<%

String action=((request.getParameter("a")==null)?"":request.getParameter("a"));

if(action.equalsIgnoreCase("registrarse")) {%>
<jsp:include page="portal/registro/registrarse.jsp" />
<%}else if(action.equalsIgnoreCase("get_pass")){ %>
<jsp:include page="portal/registro/olvido_password.jsp" />
<% } %>     
<div style="clear: both;"></div>
</div>	
</div>
<jsp:include page="portal/addInfo.jsp" />				
	<div style="clear: both;"></div>
<jsp:include page="portal/footer.jsp" />
</div>
</div>
</body>
</html>