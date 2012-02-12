<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CMenu" %>
<%
int idmenu=1;
try {
idmenu=Integer.parseInt(request.getParameter("idmenu"));
} catch (NumberFormatException e) {
}
CDataBase dbo=new CDataBase();
dbo.Connect();
CMenu temp_menu=dbo.getMenuEspecifico(idmenu);
%>
<style>
 				#panel-texto-c {
                                        width: 95%;
                                        height: 150px;
                                        overflow: auto;
                                        background: #ccc;
                                        margin: 0px auto 0px auto;
                                }
</style>
<script>
$(function(){
	$('#panel-texto-c').jScrollPane();			
});
</script>
		<h3 id="Panel-texto-tit" class="ui-state-default ui-corner-all"><%=temp_menu.getdescripcion()%></h3>
		<br/>
		<div id="panel-texto-c" class="panel-texto-desc" style="margin-left:20px;margin-right:20px;">
				<div style="margin-left:20px;margin-right:20px;">
					<%=temp_menu.getcontenido()%>				
				</div>
		</div>
		<br/>
	<div style="clear: both;"></div>					
