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
		CNoticia info_new=dbo.getNoticiaEspecificaV(idnoticia);
		ArrayList<CNoticia> list_news=dbo.getNoticias();
		dbo.Close();
		
		
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> <%=(info_new!=null)?info_new.getTitulo():"NOTICIAS"%>/Unidad de Salud</title>
<jsp:include page="portal/top.jsp" />
</head>

<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="portal/titulo.jsp">
<jsp:param name="titulo" value="Noticias" />	
</jsp:include>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">
<div id="retorna_unidad">
<a href="index.jsp" class="ui-state-default ui-corner-all button">RETORNAR A LA UNIDAD DE SALUD</a> <a href="noticia.jsp" class="ui-state-default ui-corner-all button">NOTICIAS</a> 
</div>

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
		<% }else{ 
		for(int i=0; i<list_news.size();i++){
				CNoticia temp_news=list_news.get(i);
				String sub_descrip=temp_news.getDescripcion_corta()+" [...]";
		%>
		<div class="news-todas">
		<a href="noticia.jsp?idnoticia=<%=temp_news.getIdnoticia()%>"><b><%=temp_news.getTitulo()%></b></a>
		<div style="border-top: 1px dotted #6699CC; height: 20px; "></div>
		<%=temp_news.getDescripcion_corta()%>
		
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
			