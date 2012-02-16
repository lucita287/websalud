<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%@ page import="data.CContenido" %>
<%@ page import="java.util.ArrayList" %>
<%
int idmenu=1;
try {
idmenu=Integer.parseInt(request.getParameter("idmenu"));
} catch (NumberFormatException e) {
}
CDataBase dbo=new CDataBase();
dbo.Connect();
CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
ArrayList<CContenido> list=dbo.getContenidoLista(1, idmenu);
dbo.Close();
%>
<style>
 				#panel-texto-c1 {
                    width: 95%;
                    height: 150px;
                    overflow: auto;
                    background: #ccc;
   					margin: 0px 20px 20px 20px;
               }
               #panel-texto-c2 {
                    width: 95%;
                    height: 220px;
                    overflow: auto;
                    background: #ccc;
   					margin: 0px 20px 20px 20px;
               }
               #panel-texto-c3 {
                    width: 95%;
                    height: 300px;
                    overflow: auto;
                    background: #ccc;
   					margin: 0px 20px 20px 20px;
               }
</style>
<script>
$(function(){
	$('#panel-texto-c').jScrollPane();			
});
</script>
		<h3 id="Panel-texto-tit" class="ui-state-default ui-corner-all"><%=temp_menu.getdescripcion()%></h3>
		<br/>
		<% if(temp_menu.getsize()>0 & temp_menu.getsize()<4){ %>
		<div id="panel-texto-c<%=temp_menu.getsize()%>" class="panel-texto-desc" >
				<div style="margin-left:20px;margin-right:20px;">
					<%=temp_menu.getcontenido()%>				
				</div>
		</div>
		<% } %>
		<br/>
		
	<style>

		#gallery img {
			border: none;
		}

		#gallery_nav {
			float: left;
			width: 150px;
			text-align: center;
		}

		#gallery_output {
			float: left;
			width: 600px;
			height: 550px;
			overflow: hidden;
		}

		#gallery_output img {
			display: block;
			margin: 20px auto 0 auto;
		}

	</style>
	<script language="javascript">
	
		$(document).ready(function() {
			$("#gallery_output img").not(":first").hide();

			$("#gallery a").click(function() {
				if ( $("#" + this.rel).is(":hidden") ) {
					$("#gallery_output img").slideUp();
					$("#" + this.rel).slideDown();
				}
			});
		});

	</script>
				
		
		<div id="gallery">
			<div id="gallery_nav">
			<% for(int h=0; h<list.size(); h++){ 
									CContenido conte=list.get(h);
								%>
				<a rel="img"<%=h%> href="javascript:;"><img src="<%=conte.getmultimedia().getdireccion_relativa()%>"></a>
	
			<% } %>
			</div>
			
			<div id="gallery_output">
				<% for(int h=0; h<list.size(); h++){ 
									CContenido conte=list.get(h);
						if(h==0){%>
							<img id="img"<%=h%> src="<%=conte.getmultimedia().getdireccion_relativa()%>">
						<% }else{%>
							<img style="display: none;" id="img<%=h%>" src="<%=conte.getmultimedia().getdireccion_relativa()%>">
						<%}%>

				<% 
					
					}
				%>
			</div>
		</div>	
		

		
		
	<div style="clear: both;"></div>					
