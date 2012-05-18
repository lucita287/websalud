<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CMenu_Categoria" %> 
<%@ page import="data.CPaciente" %> 
<%@ page import="java.util.ArrayList" %> 
<%@ page import="java.util.Iterator" %>    
<%@ page import="data.CAnuncio" %>
 <% 
    HttpSession sessiones=request.getSession(false); 
 	
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    		
    %>

    <div style="float:right;">
	<a href="index.jsp?portal=9" class="siguiente">SIGUIENTE</a>
	</div>
<h2>PASO 2 / EXAMEN MULTIF&Aacute;SICO</h2>
    
	
    
    <% 
    CDataExam dbo=new CDataExam();
    if(dbo.Connect()){
    CAnuncio anuncio=dbo.getAnuncioEspecifico(3);
    ArrayList<CMenu_Categoria> lista=dbo.getListaMenu_Categoria(0,1);
    ArrayList<Integer> lista_menu=dbo.ListaMenu_Categoria_Multi(pac.getIdpaciente() );
    dbo.Close();
    Iterator<CMenu_Categoria> it=lista.iterator();
    out.println(anuncio.getContenido());
    %>
	<center>
    				<a href="index.jsp?portal=11" class="siguiente">AMBIENTE FAMILIAR</a>
    <table>
    <%
    while(it.hasNext()){
    	CMenu_Categoria menu=it.next();
    	
    %>
    	<tr>
	    	<td>
		    	<a class="menu" href="index.jsp?portal=10&idmenu=<%=menu.getIdmenu_categoria()%>&auto=0&multi=1">
		    	<img src="<%= (lista_menu.indexOf(menu.getIdmenu_categoria())>-1)?"../images/check.png":"../images/uncheck.png" %>" width="32px" heigth="32px" />
		    	
		    	<%= menu.getNombre() %>
		    	</a>
	    	</td>
	    	<% if(it.hasNext()){ 
    		menu=it.next();
    		%>
    		<td>
		    	<a class="menu" href="index.jsp?portal=10&idmenu=<%=menu.getIdmenu_categoria()%>&auto=0&multi=1&titulo=<%= menu.getNombre() %>">
		    	<img src="<%= (lista_menu.indexOf(menu.getIdmenu_categoria())>-1)?"../images/check.png":"../images/uncheck.png" %>" width="32px" heigth="32px" />
		    	
		    	<%= menu.getNombre() %>
		    	</a>
	    	</td>
    		<% } %>
    	</tr>   
    <%} %>
    </table>
    </center>
    <script>
	$(function() {
		$( "a.menu").button();
		$(".siguiente").button();		
	});
	</script>
	<% 
}	} %>