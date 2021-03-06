<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="framework.CValidation" %>
<%@ page import="data.CArea" %>
<%
CDataBase dbo=new CDataBase();
if(dbo.Connect()){

CArea area=null;

String mes=request.getParameter("mes");

int idarea=1;
	try{
		idarea=Integer.parseInt(request.getParameter("idarea"));
		area=dbo.getCAreaEspecifico(idarea);
	}catch(Exception e){}
dbo.Close();
%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title> <%="CALENDARIO"%>/Unidad de Salud</title>
<jsp:include page="portal/top.jsp" />
<meta name=description content="Divisi&oacute;n de Bienestar EstudiantiL, USAC. Dentro de las actividades de servicio, se encuentra la realizaci&oacute;n del examen obligatorio de salud a todos los estudiantes de primer ingreso." />
<script type='text/javascript' src='lib/jquery.weekcalendar.js'></script>
<script type='text/javascript' src='lib/date.js'></script>
<script src="lib/i18n/ui.datepicker-es.js"></script>
</head>
<body>
<div class="back_all">
<div id="content">


<div id="back"  class="ui-widget-content ui-corner-all">

<div style="float:left;">
	<a href="index.jsp">
	
	<img src="images/logousalud2.gif" width="250px"  alt="bt_1" onmouseout="this.src='images/logousalud2.gif';" onmouseover="this.src='images/logousac.png';" />
	</a>
</div>
<!-- header begins -->

 <div id="main">
<div id="retorna_unidad">

<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNA A UNIDAD DE SALUD</a> 
<% if(idarea!=1&&area!=null){%> 
<a href="index.jsp?idarea=<%=idarea%>" class="ui-state-default ui-corner-all button">RETORNA A <%=area.getnombre().toUpperCase() %></a>
<% }%>
</div>
<div class="bt_actividad_calendario"><a href="calendario.jsp?mes=&idarea=<%=idarea%>" class="ui-state-default ui-corner-all button">MENSUAL</a></div>
<div class="bt_actividad_calendario"><a href="calendario.jsp?idarea=<%=idarea%>" class="ui-state-default ui-corner-all button">SEMANAL</a></div>
<% if(mes==null&&area!=null){%> 
<div id="titulo_area_calendario"><%=area.getnombre() %></div>
<% }else{ %>
<div id="titulo_area_calendario">UNIDAD DE SALUD</div>
<% } %>
<div style="clear: both;"></div>

<% if(mes==null&&area!=null){%>  
   			<jsp:include page="portal/calendar/weekcalendar.jsp" />
<% }else { %>
			<jsp:include page="portal/calendar/actividad_mes.jsp" />
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
<%} %>			