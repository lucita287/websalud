<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="framework.CValidation" %>
<%@ page import="data.CArea" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}
CArea area=dbo.getCAreaEspecifico(idarea);
dbo.Close();

if(area!=null){		
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title> <%="CALENDARIO"%>/Unidad de Salud</title>
<jsp:include page="portal/top.jsp" />
<script type='text/javascript' src='lib/jquery.weekcalendar.js'></script>
<script type='text/javascript' src='lib/date.js'></script>
<script src="lib/i18n/ui.datepicker-es.js"></script>
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<div style="float:left">
<img src="images/usalud.png" width="100px" height="100px" />
</div>

<div style="float:left">
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph">Calendario de Actividades</a></h2>
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNA A LA UNIDAD DE SALUD</a> 
</div>
<div id="titulo_area_calendario"><%=area.getnombre() %></div>
<div style="clear: both;"></div>


   <div id="tabs">
			<ul>
				<li><a href="#tabs-1">SEMANAL</a></li>
				<li><a href="#tabs-2">MENSUAL</a></li>
				<li><a href="#tabs-3">ACTIVIDADES</a></li>
				
			</ul>
			<div id="tabs-1" style="width:950px; ">
			<jsp:include page="portal/weekcalendar.jsp" />
			</div>
			<div id="tabs-2" style="width:950px; ">
			hola
			</div>
			<div id="tabs-3" style="width:950px; ">
			hola2
			</div>
	</div>	
	<div style="clear: both;"></div>


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
<% } %>
</body>

</html>
			