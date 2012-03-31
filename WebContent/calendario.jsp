<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="framework.CValidation" %>
<%@ page import="data.CArea" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();

CArea area=null;

String mes=request.getParameter("mes");


if(request.getParameter("idarea")!=null){
	try{
		int idarea=Integer.parseInt(request.getParameter("idarea"));
		area=dbo.getCAreaEspecifico(idarea);
	}catch(Exception e){}
	
	dbo.Close();
}
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
<jsp:include page="portal/titulo.jsp">
<jsp:param name="titulo" value="Calendario de Actividades" />	
</jsp:include>
</div>

<div id="back"  class="ui-widget-content ui-corner-all">
<!-- header begins -->

 <div id="main">
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNA A LA UNIDAD DE SALUD</a> 
</div>
<div class="bt_actividad_calendario"><a href="calendario.jsp" class="ui-state-default ui-corner-all button">ACTIVIDADES</a></div>
<div class="bt_actividad_calendario"><a href="calendario.jsp?mes=" class="ui-state-default ui-corner-all button">MENSUAL</a></div>
<div class="bt_actividad_calendario"><a href="calendario.jsp?idarea=1" class="ui-state-default ui-corner-all button">SEMANAL</a></div>
<% if(area!=null){%> 
<div id="titulo_area_calendario"><%=area.getnombre() %></div>
<% }else{ %>
<div id="titulo_area_calendario">UNIDAD DE SALUD</div>
<% } %>
<div style="clear: both;"></div>

<% if(area!=null){%>  
   			<jsp:include page="portal/weekcalendar.jsp" />
<% }else if(mes!=null){ %>
			<jsp:include page="portal/actividad_mes.jsp" />
<% }else{ %>
   			<jsp:include page="portal/actividad.jsp" />
<% }%>	
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

</body>

</html>
			