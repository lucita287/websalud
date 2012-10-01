<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}
if(dbo.Connect()){
ArrayList<CMenu> list_menu=dbo.getMenu(1);
ArrayList<CArea> list_area=dbo.getAreaListaMenu();
dbo.Close();
%>
<link href="css/style_portal.css" rel="stylesheet" type="text/css" media="screen" />	
<script src="lib/system.js" type="text/javascript"></script>
<ul id="menu" class="INICIAL_MENU">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
				ArrayList<CMenu> temp_list=temp_menu.getlist_menu();	
	%>								
	<li>
	<a  href="#"  onclick="Actualizar(<%= temp_menu.getidmenu()%>);" ><%= temp_menu.getdescripcion()%></a>
			
			
			<ul class="PARTE1_MENU">
				<% for(int j=0; j<temp_list.size();j++){ 
					CMenu temp_menu1=temp_list.get(j);
					%>
				<li>
					<a href="#" onclick="Actualizar(<%= temp_menu1.getidmenu()%>);"><%= temp_menu1.getdescripcion()%></a>
				</li>
				<% } %>
			</ul>
	</li>
	
	<%} %>
	<li>
		<a href="calendario.jsp?mes=&idarea=<%=idarea%>">Calendario</a>
	</li>
	<li>
		<a href="#">Areas Profesionales</a>
			<ul>
				<% for(int h=0; h<list_area.size(); h++){ 
					CArea temp_area=list_area.get(h);
					%>
					<li>
					<a  href="index.jsp?idarea=<%= temp_area.getidarea()%>"><%= temp_area.getnombre()%></a>							
					</li>
				<% 	} %>
					
			</ul>	
	</li>
	
</ul>
<% } %>