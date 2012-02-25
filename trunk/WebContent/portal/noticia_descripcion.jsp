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
		<div id="widget-info"> 
					<h3><%=info_new.getTitulo()%></h3>
					<div style="border-top: 1px dotted #6699CC; height: 20px; margin-top: 20px;"></div>
					<div id="news_descripcion">
						<%=info_new.getDescripcion()%>
					</div>
					<div id="news_vermas"><a id="news_mas"  target="_blank" href="noticia.jsp?idnoticia=<%=idnoticia%>">VER MAS</a></div>
			</div>
		<%} %>
		
		<style>
		#news_descripcion {
		width:450px; 
		float:left; 
		height: 220px;
        overflow: auto;
        margin: 0px 20px 20px 20px;
		}
		#news_vermas{
		float:right;
		}
		</style>