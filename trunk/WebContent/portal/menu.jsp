<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<script type="text/javascript" src="../lib/jquery-1.5.2.min.js"></script>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CMenu> list_menu=dbo.getMenu(1);
ArrayList<CArea> list_area=dbo.getAreaListaMenu();
ArrayList<CArea> list_area_sub=dbo.getAreaListaMenuSubmenu();
dbo.Close();
%>
<style>
ul#menu, ul#menu ul {
  list-style-type:none;
  margin: 0;
  padding: 0;
  width: 20em;
}
ul#menu a {
  display: block;
  text-decoration: none;	
}
ul#menu li {
  margin-top: 1px;
}
ul#menu li a {
  background: #333;
  color: #fff;	
  padding: 0.5em;
}
ul#menu li a:hover {
  background: #000;
}
ul#menu li ul li a {
  background: #ccc;
  color: #000;
  padding-left: 20px;
}
ul#menu li ul li a:hover {
  background: #aaa;
  border-left: 5px #000 solid;
  padding-left: 15px;
}
ul#menu li ul li ul li a {
  background: #BCBCBC;
  color: #000;
  padding-left: 40px;
}
ul#menu li ul li ul li  a:hover {
  background: #aaa;
  border-left: 20px #000 solid;
  padding-left: 35px;
}
</style>
	
<ul id="menu" class="INICIAL_MENU">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
				ArrayList<CMenu> temp_list=temp_menu.getlist_menu();	
	%>								
	<li>
	<a onclick="Actualizar(<%= temp_menu.getidmenu()%>);" ><%= temp_menu.getdescripcion()%></a>
			
			
			<ul class="PARTE1_MENU">
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
				<% 	} %>
					<li>
						<a>SubAreas Medicina</a>
							<ul>
								<% for(int h=0; h<list_area_sub.size(); h++){ 
									CArea temp_area=list_area.get(h);
								%>
								<li>
									<a onclick="menuarea(<%= temp_area.getidarea()%>)"><%= temp_area.getdescripcion()%></a>
								</li>
								<% } %>
							</ul>
					</li>
			</ul>	
	</li>
	
</ul>
<script>
$('#menu').hover(function() {
	
	$(this).css('cursor','pointer');
	
	}, function() {
	
	$(this).css('cursor','auto');
	
});		

$('#menu').hover(function() {
	
	$(this).css('cursor','pointer');
	
	}, function() {
	
	$(this).css('cursor','auto');
	
});		
function initMenu() {
	  $('#menu ul').hide();
	  $('#menu ul:first').show();
	  $('#menu li a').click(
	    function() {
	      var checkElement = $(this).next();
	      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
	        return false;
	        }
	      
	      if((checkElement.is('ul li ul li ul')) && (!checkElement.is(':visible'))) {
	        checkElement.slideDown('normal');
	        return false;
	        }
	      if((checkElement.is('ul li ul')) && (!checkElement.is(':visible'))) {
		        $('#menu ul:visible').slideUp('normal');
		        checkElement.slideDown('normal');
		        return false;
		        }
	      }
	    );
	  }
	$(document).ready(function() {initMenu();});
</script>