<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<%
CDataBase dbo=new CDataBase();
if(dbo.Connect()){
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}
CArea area=dbo.getCAreaEspecifico(idarea);
dbo.Close();
if(area!=null){

%>
<link href="css/style_portal.css" rel="stylesheet" type="text/css" media="screen" />	
<h3 id="Panel-texto-tit" class="ui-state-default ui-corner-all"><%=area.getnombre()%></h3>
<br/>
		<% if(area.getsize()>0 & area.getsize()<5){ %>
		<div id="panel-texto-c<%=area.getsize()%>" class="ui-widget-content ui-corner-all  panel-texto-desc" >
				<div style="margin-left:20px;margin-right:20px;">
					<%=area.getdescripcion()%>				
					<%=area.getHtml_adicional() %>
				</div>
		</div>
		<% } %>
		<br/>
		<% if(area.getidmultimedia().getidimagen()>0){ %>
			<center>
			<a target="_blank" href="<%=area.getidmultimedia().getdireccion_relativa()%>">
			<img src="<%=area.getidmultimedia().getdireccion_relativa()%>" width="550" heigth="440">
			</a>
			</center>
		<%} %>
	<div style="clear: both;"></div>						
<script >
$(function(){
	$('#panel-texto-c1').jScrollPane();
	$('#panel-texto-c2').jScrollPane();
	$('#panel-texto-c3').jScrollPane();
	$('#panel-texto-c4').jScrollPane();
});

</script>
<%}	} %>