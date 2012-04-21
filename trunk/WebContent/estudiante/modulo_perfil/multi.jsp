<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CMenu_Categoria" %> 
<%@ page import="java.util.ArrayList" %> 
<%@ page import="java.util.Iterator" %>    
<h2>PASO 2 / EXAMEN MULTIF&Aacute;SICO</h2>
    <% 
    CDataExam dbo=new CDataExam();
    dbo.Connect();
    ArrayList<CMenu_Categoria> lista=dbo.getListaMenu_Categoria(1,0);
    dbo.Close();
    Iterator<CMenu_Categoria> it=lista.iterator();
    while(it.hasNext()){
    	CMenu_Categoria menu=it.next();
    	
    %>
    	<div class="ui-state-error menu_categoria" >
    	<a href="index.jsp?portal=9&idmenu=<%=menu.getIdmenu_categoria()%>&auto=0&multi=1&titulo=<%= menu.getNombre() %>">
    	<%= menu.getNombre() %>
    	</a>
    	</div>
    <%} %>