<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CNoticia" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="framework.CValidation" %>
<%
		CValidation valid=new CValidation();
		int idnoticia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idnoticia")));
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		CNoticia info_new=dbo.getNoticiaEspecifica(idnoticia);
		dbo.Close();
		
		if(info_new!=null){
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title> <%=info_new.getTitulo()%>/Unidad de Salud</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link type="text/css" href="css/custom-theme/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="lib/jquery-ui-1.8.17.custom.min.js"></script>
</head>
<style>
	#Panel-texto-tit { margin: 0; padding: 0.4em; text-align: center; }
</style>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<div style="float:left">
<img src="images/usalud.png" width="100px" height="100px" />
</div>
<div style="float:left">
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph">Noticias</a></h2>
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">



		<% if(info_new!=null){ %>
		<h3 id="Panel-texto-tit" class="ui-state-default ui-corner-all"><%=info_new.getTitulo()%></h3>
		<br/>

				<div style="margin-left:20px;margin-right:20px;">
					<%=info_new.getDescripcion()%>				
				</div>
			<br/>
			<%if(info_new.getMultimediaidmultimedia()!=null &&info_new.getMultimediaidmultimedia().getidimagen()>0){ %>
				<img src="<%=info_new.getMultimediaidmultimedia().getdireccion_relativa() %>"/>		
			<%} %>	
		<% } %>
		
		



</div>	
<!--content ends -->
</div>
<!--footer begins -->

<jsp:include page="portal/addInfo.jsp" />				
	<div style="clear: both;"></div>
<jsp:include page="portal/footer.jsp" />
</div>

<!-- footer ends-->

</div>
</body>
</html>
			<%} %>