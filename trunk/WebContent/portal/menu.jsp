<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CMenu> list_menu=dbo.getMenu(1);
ArrayList<CArea> list_area=dbo.getAreaLista();
dbo.Close();
%>
	
<ul id="menu">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
				ArrayList<CMenu> temp_list=temp_menu.getlist_menu();
				
	%>								
	<li>
	<a onclick="Actualizar(<%= temp_menu.getidmenu()%>);" ><%= temp_menu.getdescripcion()%></a>
			
			
			<ul>
				<% for(int j=0; j<temp_list.size();j++){ 
					CMenu temp_menu1=temp_list.get(j);
					%>
				<li>
					<a onclick="Actualizar(<%= temp_menu1.getidmenu()%>);"><%= temp_menu1.getdescripcion()%></a>
				</li>
				<% } %>
			</ul>
	</li>
	
	<%} %>
	<li>
		<a>Areas Profesionales</a>
			<ul>
				<% for(int h=0; h<list_area.size(); h++){ 
					CArea temp_area=list_area.get(h);
					%>
					<li>
					<a onclick="menuarea(<%= temp_area.getidarea()%>)"><%= temp_area.getdescripcion()%></a>
					</li>
				<% } %>
			</ul>	
	</li>
	
</ul>
