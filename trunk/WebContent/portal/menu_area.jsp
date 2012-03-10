<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}
ArrayList<CMenu> list_menu=dbo.getMenu(idarea);
ArrayList<CArea> list_submenu=dbo.getAreaListaMenuSubmenu(idarea);
dbo.Close();
%>
<link href="css/style_portal.css" rel="stylesheet" type="text/css" media="screen" />
<script src="lib/system.js" type="text/javascript"></script>
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
	<%if(list_submenu.size()>0){ %>
		

	<li><a >Programas</a>
		<ul>
			<% for(int j=0; j<list_submenu.size();j++){ 
					CArea temp=list_submenu.get(j);
					%>
				<li>
					<a onclick="menuarea(<%= temp.getidarea()%>);"><%= temp.getnombre()%></a>
				</li>
				<% } %>
		</ul>
	</li>
		<% } %>
	<li><a target="_blank" href="calendario.jsp">CALENDARIO</a></li>
	<li><a href="index.jsp">REGRESAR A MENU</a></li>	
</ul>
