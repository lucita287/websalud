<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CNoticia" %>
<%@ page import="java.util.ArrayList" %>
<%  
CDataBase dbo=new CDataBase();
dbo.Connect();
ArrayList<CNoticia> list_news=dbo.getNoticias();
dbo.Close();
%>

<% 
if(list_news.size()>0){ %>
<div id="Panel-inicio" class="ui-widget-content ui-corner-all">
						<h3 class="ui-widget-header ui-corner-all">Noticias</h3>				


			<div id="tabs1-inicio-info">
				<div class="toggler">
							
							<div class="info-noticias">
							
								<div id="prev_info">
								<h3 class="ui-state-default ui-corner-all"><img src="images/up.png" /></h3>
								</div>
								
								<div class="jCarouselLite2">
								
									<ul>

		<% 
		for(int i=0; i<list_news.size();i++){
				CNoticia temp_news=list_news.get(i);
				String sub_descrip=temp_news.getDescripcion_corta()+" [...]";
		%>
										<li>
										<div class="news-inicio" name="<%=temp_news.getIdnoticia()%>">
												
												<div class="news-text"  >
												<b><%=temp_news.getTitulo() %></b> 
												<br/><%= sub_descrip %>
												</div>
										</div>
										<div style="clear: both;"></div>
										</li>										
		<% } %>	
									</ul>

								</div>
								<div id="next_info">
									<h3 class="ui-state-default ui-corner-all"><img src="images/down.png" /></h3>
								</div>
								<div style="clear: both;"></div>
							</div>
							
							
					</div>
				</div>
			<jsp:include page="noticia_descripcion.jsp" >
			    <jsp:param name="idnoticia" value="<%=list_news.get(0).getIdnoticia() %>" />
			</jsp:include>	
		

<% } %>

<script>

$(function() {
	$(".jCarouselLite2").jCarouselLite({
		vertical: true,
		btnNext: "#next_info",
		btnPrev: "#prev_info",
		visible: <%=(list_news.size()<3)?list_news.size():3%>
	});
});
</script>
<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>