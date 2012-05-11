<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataExam" %>    
<%@ page import="data.CMenu_Categoria" %>
<%@ page import="data.CPaciente" %> 
<%@ page import="java.util.ArrayList" %> 
<%@ page import="java.util.Iterator" %>    

 <% 
    HttpSession sessiones=request.getSession(false); 
    if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
    	CPaciente pac=(CPaciente)sessiones.getAttribute("paciente");
    		
    %>
<h2>PASO 2 / EXAMEN AUTOEVALUACI&Oacute;N</h2>
    <% 
    CDataExam dbo=new CDataExam();
    dbo.Connect();
    ArrayList<CMenu_Categoria> lista=dbo.getListaMenu_Categoria(1,0);
    ArrayList<Integer> lista_menu=dbo.ListaMenu_Categoria_Auto(pac.getIdpaciente() );
    dbo.Close();
    Iterator<CMenu_Categoria> it=lista.iterator();
    
    %>
    <center>
    <% 
    while(it.hasNext()){
    	CMenu_Categoria menu=it.next();
    	
    %>
    	<a class="menu" href="index.jsp?portal=10&idmenu=<%=menu.getIdmenu_categoria()%>&auto=1&multi=0&titulo=<%= menu.getNombre() %>">
    	<img  src="<%= (lista_menu.indexOf(menu.getIdmenu_categoria())>-1)?"../images/check.png":"../images/uncheck.png" %>"  width="32px" heigth="32px" />
    	<%= menu.getNombre() %>
    	</a><br>
    <%} %>
    </center>
     <script>
	$(function() {
		$( "a.menu").button();
	});
	</script>
	<% } %>