<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CMenu> list_menu=dbo.getMenu(1);
dbo.Close();
%>
<script>


	$(function() {
		$( "#sub-menu" ).selectable();
	});
	</script>
	<style type="text/css">
		#menu-principal {  width:25%;  float:left; }
		#sub-menu .ui-selecting { background: #646D7E; }
		#sub-menu .ui-selected { background: #646D7E; color: white; }
		#sub-menu { list-style-type: none; margin: 0; padding: 0; }
		#sub-menu li { margin: 3px; padding: 0.4em; font-size: 1.4em; }
	</style>
	
<ol id="sub-menu">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
	%>								

	<li class="ui-widget-content"><%= temp_menu.getdescripcion()%></li>
	<%} %>
</ol>