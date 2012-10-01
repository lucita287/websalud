<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CNoticia" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="framework.CValidation" %>
<%
		CValidation valid=new CValidation();
		int idnoticia=valid.ConvertEntero(valid.ValidarRequest(request.getParameter("idnoticia")));
		CDataBase dbo=new CDataBase();
		dbo.Connect();
		String host=CDataBase.getWebhost();
		CNoticia info_new=dbo.getNoticiaEspecificaV(idnoticia);
		ArrayList<CNoticia> list_news=dbo.getNoticias();
		dbo.Close();
		
		
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> <%=(info_new!=null)?info_new.getTitulo():"NOTICIAS"%>/Unidad de Salud</title>
<jsp:include page="portal/top.jsp" />
<% if(info_new!=null){ %>
<meta name=description content="<%= info_new.getDescripcion_corta()%>" />
<% }else { %>
<meta name=description content="Divisi&oacute;n de Bienestar EstudiantiL, USAC. Dentro de las actividades de servicio, se encuentra la realizaci&oacute;n del examen obligatorio de salud a todos los estudiantes de primer ingreso." />
<%  }%>
</head>

<body>
<div class="back_all">
<div id="content">

<div id="back" class="ui-widget-content ui-corner-all">
<div style="float:left;">
	<a href="index.jsp">
	<img src="images/logousalud2.gif" width="250px"  alt="bt_1" onmouseout="this.src='images/logousalud2.gif';" onmouseover="this.src='images/logousac.png';" />
	</a>
</div>
<!-- header begins -->

 <div id="main">
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNAR A LA UNIDAD DE SALUD</a> <a href="noticia.jsp" class="ui-state-default ui-corner-all button">NOTICIAS</a> 
</div>
<div style="clear: both;"></div>
		<% if(info_new!=null){ %>
		<h3 id="Panel-texto-tit" class="ui-widget-header ui-corner-all"><%=info_new.getTitulo()%></h3>
		<br/>

				<div style="margin-left:20px;margin-right:20px;">
					<%=info_new.getDescripcion()%>				
				</div>
			<br/>
			<%if(info_new.getMultimediaidmultimedia()!=null &&info_new.getMultimediaidmultimedia().getidimagen()>0){ %>
				
				<center>
				<img width="750px"  src="<%=info_new.getMultimediaidmultimedia().getdireccion_relativa() %>"/>		
				</center>
						
			<%} %>
			<% if(info_new.getMultimediaidmultimedia_pdf()!=null&&info_new.getMultimediaidmultimedia_pdf().getidimagen()>0){ %>
					<div class="news_vermas_especifica">
						<a   target="_blank" href="<%= info_new.getMultimediaidmultimedia_pdf().getdireccion_relativa() %>">VER PDF</a>
					</div>
					<div style="clear: both;"></div>
					<% } %>
			
					<div class="news_vermas3">
						<a id="news_mas" target="_blank"  href="http://www.facebook.com/sharer.php?u=<%=host%>noticia.jsp?idnoticia=<%=info_new.getIdnoticia()%>"><img src="images/facebook.jpg" /></a>
						<a id="news_mas"  target="_blank" href="http://twitter.com/home?status=Leyendo ahora: <%=host%>noticia.jsp?idnoticia=<%=info_new.getIdnoticia()%>"><img src="images/twitter.jpg" /></a>
					</div>	
			<div style="clear: both;"></div>		
		<% }else{ 
		for(int i=0; i<list_news.size();i++){
				CNoticia temp_news=list_news.get(i);
				String sub_descrip=temp_news.getDescripcion_corta()+" [...]";
		%>
		<div class="news-todas">
		<div class="todas_noticias_titulo">
		<a href="noticia.jsp?idnoticia=<%=temp_news.getIdnoticia()%>"><b><%=temp_news.getTitulo()%></b></a>
		</div>
		
		<div style="border-top: 1px dotted #6699CC; height: 20px; "></div>
		<div class="todas_noticias_descripcion">
		<%=temp_news.getDescripcion()%>
		</div>
		<div style="clear: both;"></div>
					<div class="news_vermas">
						<a id="news_mas"  href="noticia.jsp?idnoticia=<%=temp_news.getIdnoticia() %>">VER MAS</a>
					</div>
					<% if(temp_news.getMultimediaidmultimedia_pdf()!=null&&temp_news.getMultimediaidmultimedia_pdf().getidimagen()>0){ %>
					<div class="news_vermas">
						<a   target="_blank" href="<%= temp_news.getMultimediaidmultimedia_pdf().getdireccion_relativa() %>">VER PDF</a>
					</div>
					<% } %>
					<% if(temp_news.getMultimediaidmultimedia()!=null&&temp_news.getMultimediaidmultimedia().getidimagen()>0){ %>
					<div class="news_vermas">
						<a   target="_blank" href="<%= temp_news.getMultimediaidmultimedia().getdireccion_relativa() %>">VER AFICHE</a>
					</div>
					<% } %>
					<div class="news_vermas2">
					<a id="news_mas" target="_blank"  href="http://www.facebook.com/sharer.php?u=<%=host%>/noticia.jsp?idnoticia=<%=temp_news.getIdnoticia()%>"><img src="images/facebook_counter.png" /></a>
					</div>
					<div class="news_vermas2">
					<a id="news_mas"  target="_blank" href="http://twitter.com/home?status=Leyendo ahora: <%=host%>/noticia.jsp?idnoticia=<%=temp_news.getIdnoticia()%>"><img src="images/twitter_counter.png" /></a>
					</div>
		
		<div style="clear: both;"></div>
		</div>
		<%} } %>



</div>	
<!--content ends -->
</div>
<!--footer begins -->

<jsp:include page="portal/addInfo.jsp" />				
	<div style="clear: both;"></div>
<jsp:include page="portal/footer.jsp" />
</div>

<!-- footer ends-->

</div>
</body>
</html>
			