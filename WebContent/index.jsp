<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CNoticia" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CNoticia> lista=dbo.getNoticias();
dbo.Close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<jsp:include page="portal/top.jsp" />
</head>
<body>
	<div id="bg_top"></div>
    <div id="wrap">
        <div id="white_bg_top"></div>
        <div id="white_bg">
				<jsp:include page="portal/header.jsp" />
			<div style="clear: both;"></div>
			<div id="menu-principal" >
				<jsp:include page="portal/menu.jsp" />
				<div>
					<jsp:include page="portal/login.jsp" />
				</div>
			</div>
			<jsp:include page="portal/noticias.jsp" />
        	<div id="white_bg_bot"></div>
    		</div>
    </div>	
	<div id="footer_bot">
		<p>USAC 2012, Unidad de Salud </p>
	</div>
</body>
</html>