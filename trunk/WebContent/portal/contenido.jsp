<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%

int idmenu=Integer.parseInt(request.getParameter("idmenu"));
CDataBase dbo=new CDataBase();
dbo.Connect();
CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
%>

		<h3 id="Panel-texto-tit" class="ui-widget-header ui-corner-all"><%=temp_menu.getdescripcion()%></h3>
		<div id="panel-texto-c" class="panel-texto-desc">
			<div id="panel-texto-conte">
					<%=temp_menu.getcontenido()%>				
			</div>
		</div>
	<div style="clear: both;"></div>					
