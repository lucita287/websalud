<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
String titulo=(request.getParameter("titulo")==null)?"":request.getParameter("titulo");


%>    
<div style="float:left">

<a href="http://www.usac.edu.gt/"> <img src="../images/usac.png" width="100px" height="100px" /></a>
<a href="../index.jsp"><img src="../images/usalud.png" width="100px" height="100px" /></a>
</div>
<div class="ui-widget-content ui-corner-all" style="float: right;">
						
						<div style="float: right;" >
						<%if(request.getParameter("usuario")!=null){
								out.println("Bienvenido<br/>"+request.getParameter("usuario"));
							}%>
						<br/>
						<a Style="color:#0000CD;" href="../SunLogin">(Salir)</a>	
						</div>
						<div style="float: right;" >
						<img src="../images/login.png" />
						</div>
		<div style="clear: both;"></div>				
</div>
<div style="float:left" >
<h1><a href="../index.jsp">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph"><%=titulo%></a></h2>
</div>
<div style="clear: both;"></div>    