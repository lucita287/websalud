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

	function initMenu() {
	  $('#menu ul').hide();
	  $('#menu ul:first').show();
	  $('#menu li a').click(
	    function() {
	      var checkElement = $(this).next();
	      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
	        return false;
	        }
	      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
	        $('#menu ul:visible').slideUp('normal');
	        checkElement.slideDown('normal');
	        return false;
	        }
	      }
	    );
	  }
	$(document).ready(function() {initMenu();});
	</script>
	<style type="text/css">
	
#menu-principal {  width:25%;  float:left; }
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
  background: #6495ED;
  color: #fff;	
  padding: 0.5em;
}

ul#menu li a:hover {
  background: #0000FF;
}

ul#menu li ul li a {
  background: #E6E6FA;
  color: #000;
  padding-left: 20px;
}

ul#menu li ul li a:hover {
  background: #778899;
  border-left: 5px #000 solid;
  padding-left: 15px;
}

	</style>
	
<ul id="menu">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
	%>								
	<li>
	<a ><%= temp_menu.getdescripcion()%></a>
			<ul>
				<li>
					<a>hola</a>
				</li>
				<li>
					<a>hola</a>
				</li>
			</ul>
	</li>
	<%} %>
</ul>