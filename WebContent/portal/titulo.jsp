<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%
String titulo=(request.getParameter("titulo")==null)?"":request.getParameter("titulo");


%>    
<div style="float:left">
<a href="http://www.usac.edu.gt/"><img src="<%=CDataBase.getWebhost() %>images/usac.png" width="100px" height="100px" /></a>
<a href="index.jsp"><img src="<%=CDataBase.getWebhost() %>images/usalud.png" width="100px" height="100px" /></a>

</div>

<div style="float:left" >
<h1><a href="index.jsp">Unidad de Salud USAC</a></h1>
<h2><a href="#" id="metamorph"><%=titulo%></a></h2>
</div>
<div style="clear: both;"></div>    