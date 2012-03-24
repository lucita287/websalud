<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CArea" %>
<%@ page import="data.CEncabezado" %>
<%@ page import="java.util.ArrayList" %>
<%
int idarea=1;
try {
idarea=Integer.parseInt(request.getParameter("idarea"));
} catch (NumberFormatException e) {
}
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CEncabezado> lista=dbo.getEncabezadoLista(idarea);
CArea area=dbo.getCAreaEspecifico(idarea);
dbo.Close();

if(lista.size()>0){
%>

	<script>	
	$(function() {
		$(".menu_header").jCarouselLite({
			hoverPause:true,
			visible: <%=(lista.size()>5?"5":lista.size())%>,
			auto:500,
			speed:1000,
			scroll:1
			});
		});	
    </script>
   <%} %> 
	<style type="text/css">
		#header_carousel { float:right; }
		.foto-inicio{	width:100%; height:100px;	}
		
	</style>
		
<div id="header_carousel">
	<div class="menu_header">

									<ul>
					<% for(int h=0; h<lista.size(); h++){ 
					CEncabezado temp=lista.get(h);
					%>
										<li>
										<div class="foto-inicio" >
												
													<img src="<%=temp.getMultimediaidmultimedia().getdireccion_relativa()%>" width="160px" height="120px" />												
	
											
										</div>
										</li>
					<%} %>					
									</ul>

								</div>
	
	
<h2><%=(area!=null)?area.getnombre().toUpperCase():""%></h2>

    </div>	