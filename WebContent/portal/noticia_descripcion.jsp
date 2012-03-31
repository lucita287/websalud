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
		CNoticia info_new=dbo.getNoticiaEspecifica(idnoticia);
		dbo.Close();
		if(info_new!=null){
		%>
		<link href="css/style_portal.css" rel="stylesheet" type="text/css" media="screen" />
		<div id="widget-info"> 
					<h3 id="titulo_noticia_descripcion"><%=info_new.getTitulo()%></h3>
					<div style="border-top: 1px dotted #6699CC; height: 20px; margin-top: 20px;"></div>
					<div id="news_descripcion">
						<%=info_new.getDescripcion()%>
					</div>
					
					<div class="news_vermas">
					<a  target="_blank" href="noticia.jsp">VER TODAS</a>
					</div>
					<div class="news_vermas">
					<a id="news_mas"  target="_blank" href="noticia.jsp?idnoticia=<%=idnoticia%>">VER MAS</a>
					</div>
					<% if(info_new.getMultimediaidmultimedia_pdf()!=null&&info_new.getMultimediaidmultimedia_pdf().getidimagen()>0){ %>
					<div class="news_vermas">
					<a   target="_blank" href="<%= info_new.getMultimediaidmultimedia_pdf().getdireccion_relativa() %>">VER PDF</a>
					</div>
					<% } %>
					<% if(info_new.getMultimediaidmultimedia()!=null&&info_new.getMultimediaidmultimedia().getidimagen()>0){ %>
					<div class="news_vermas">
					<a   target="_blank" href="<%= info_new.getMultimediaidmultimedia().getdireccion_relativa() %>">VER AFICHE</a>
					</div>
					<% } %>
			</div>
		<%} %>
		