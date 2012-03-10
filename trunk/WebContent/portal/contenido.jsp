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
if(temp_menu!=null){
ArrayList<CContenido> list=dbo.getContenidoLista(1, idmenu);
ArrayList<CContenido> listpdf=dbo.getContenidoLista(2, idmenu);
dbo.Close();

%>
<link href="css/style_portal.css" rel="stylesheet" type="text/css" media="screen" />
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
		

<% if(list.size()>0){ %>				
		
<div id="gallery">
			<div id="container">
				<div id="gallery_nav" >
					<p style="width: <%=((list.size()+1)*130)%>px;">
					<% for(int h=0; h<list.size(); h++){ 
					CContenido temp=list.get(h);
					%>
						<a rel="img<%=h %>" href="javascript:;"><img src="<%=temp.getmultimedia().getdireccion_relativa()%>" width="120px" heigth="120px"></a>
						
					<% }%>	
					</p>
				<div style="clear: both;"></div>	
				</div>
				
			</div>
			
			<div id="gallery_output">
			<h3><label id="first_imagen" ></label></h3>
			<div id="first_conte"></div>
			<% for(int h=0; h<list.size(); h++){ 
					CContenido temp=list.get(h);%>	
				<%if(h==0){%>
					<img id="img<%=h %>" width="550px" heigth="450px" src="<%=temp.getmultimedia().getdireccion_relativa()%>">
				<%}else{ %>					
					<img style="display: none;" id="img<%=h %>" width="550px" heigth="450px" src="<%=temp.getmultimedia().getdireccion_relativa()%>">
				<%}
			} %>
				<div style="clear: both;"></div>	
				
			
			</div>
					
	</div>
		
<% } 
if(listpdf.size()>0){ %>
	<div id="pdf_div">
		<table >	
		<% for(int h=0; h<listpdf.size(); h++){ 
					CContenido temp=listpdf.get(h);%>
				
					<tr>
						<td rowspan="2">		
						<td>
							
							<div id="pdf_titulo">
							<a  target="_blank" href="<%=temp.getmultimedia().getdireccion_relativa()%>">
								<%= temp.gettitulo() %>
							</a>
							</div>
						</td>
					</tr>
					
					<tr>
						<td>
							<%if(temp.getdescripcion().length()>0){ %>
							<div id="pdf_descripcion">
								<%= temp.getdescripcion() %>
							</div>
							<% }%>
						</td>
					</tr>		
				
		<%} %>	
		</table>
	</div>
<% }%>	
	<br/>
						
<script language="javascript">
$(function(){
	$('#panel-texto-c1').jScrollPane();
	$('#panel-texto-c2').jScrollPane();
	$('#panel-texto-c3').jScrollPane();
	$('#gallery_nav').jScrollPane();
	$('#pdf_div').jScrollPane();
});
var ArrayContenido=new Array(<%=list.size()%>);
$(document).ready(function() {
	<% for(int h=0; h<list.size(); h++){ 
	CContenido temp=list.get(h);%>
	ArrayContenido[<%=h%>]=new Array(2);
	ArrayContenido[<%=h%>][0]="<%= temp.gettitulo()%>";
	ArrayContenido[<%=h%>][1]="<%= temp.getdescripcion()%>";
	<% } %>
	<% if(list.size()>0) {%>
	$("#first_imagen").text(ArrayContenido[0][0]);
	$("#first_conte").html(ArrayContenido[0][1]);
	<%}%>
	$("#gallery_output img").not(":first").hide();

	$("#gallery a").click(function() {
		if ( $("#" + this.rel).is(":hidden") ) {
			$("#gallery_output img").slideUp();
			$("#" + this.rel).slideDown();
			id=this.rel.replace("img","");
			$("#first_imagen").text(ArrayContenido[id][0]);
			$("#first_conte").html(ArrayContenido[id][1]);
		}
	});
});

</script>
<%} %>