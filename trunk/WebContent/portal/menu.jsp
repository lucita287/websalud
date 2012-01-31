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


ul#menu, ul#menu ul {
  list-style-type:none;
  margin: 0;
  padding: 0;
  width: 15em;
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

.code { border: 1px solid #ccc; list-style-type: decimal-leading-zero; padding: 5px; margin: 0; }
.code code { display: block; padding: 3px; margin-bottom: 0; }
.code li { background: #ddd; border: 1px solid #ccc; margin: 0 0 2px 2.2em; }
.indent1 { padding-left: 1em; }
.indent2 { padding-left: 2em; }
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