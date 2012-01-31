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


	</style>
	
<ul id="menu">
	<% 		
	for(int i=0; i<list_menu.size();i++){
				CMenu temp_menu=list_menu.get(i);
				ArrayList<CMenu> temp_list=temp_menu.getlist_menu();
				
	%>								
	<li>
	<a onclick="Actualizar(<%= temp_menu.getidmenu()%>);" ><%= temp_menu.getdescripcion()%></a>
			
			
			<ul>
				<% if (temp_list!=null)
					for(int j=0; j<temp_list.size();j++){ 
					CMenu temp_menu1=temp_list.get(j);
					%>
				<li>
					<a onclick="Actualizar(<%= temp_menu1.getidmenu()%>);"><%= temp_menu1.getdescripcion()%></a>
				</li>
				<% } %>
			</ul>
	</li>
	<%} %>
</ul>
	<script>

	function Actualizar(idmenu){
		 cadena = [
		           'idmenu='     + idmenu,
		        ].join('&');

		$.ajax({
	        url: "SMenu",
            type: 'post',
            dataType: 'json',
	        data:cadena,
	        success: function(data){
	        	$("#Panel-texto-tit").html(data['titulo']);
	        	$("#panel-texto-desc").html(data['texto']);
	        }
	    });
		

		
	}
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