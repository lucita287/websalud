<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CArea" %>
<%@ page import="java.util.ArrayList" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
int idarea=1;
try{
idarea=Integer.parseInt(((request.getParameter("idarea")==null)?"1":request.getParameter("idarea")));
}catch(Exception e){}


CArea area=dbo.getCAreaEspecifico(idarea);
if(area!=null){
dbo.Close();
%>

		<h3 id="Panel-texto-tit" class="ui-state-default ui-corner-all"><%=area.getnombre()%></h3>
		<br/>
		<% if(area.getsize()>0 & area.getsize()<4){ %>
		<div id="panel-texto-c<%=area.getsize()%>" class="panel-texto-desc" >
				<div style="margin-left:20px;margin-right:20px;">
					<%=area.getdescripcion()%>				
				</div>
		</div>
		<% } %>
		<br/>
		<% if(area.getidmultimedia().getidimagen()>0){ %>
			<div id="center_img">
			<img src="<%=area.getidmultimedia().getdireccion_relativa()%>" width="550" heigth="440">
			</div>
		<%} %>
	<div style="clear: both;"></div>
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
               #center_img{
               		margin:0 auto 0 auto;
					width: 550px;
					height: 500px;
               }
		</style>						
<script language="javascript">
$(function(){
	$('#panel-texto-c1').jScrollPane();
	$('#panel-texto-c2').jScrollPane();
	$('#panel-texto-c3').jScrollPane();
});

</script>
<%} %>