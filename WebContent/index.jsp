<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="framework.CValidation" %>
<%@ page import="data.CArea" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%String area=request.getParameter("idarea");%>
<title>Unidad de Salud / USAC</title>
<jsp:include page="portal/top.jsp" />
<% 
	int idarea=1;
	CValidation valid=new CValidation();
	if(area!=null) idarea=valid.ConvertEntero(area);
	CDataBase dbo=new CDataBase();
	if(dbo.Connect()){
		CArea earea=dbo.getCAreaEspecifico(idarea);
		if(earea!=null){	
			out.println("<meta name=description content='"+earea.getDescripcion_buscador()+"' />");
			out.println("<meta name=keywords content='"+earea.getPalabras_buscador()+"'>");
		}	
	}
%>

</head>
<body>
<div class="back_all">
<div id="content">

<div id="back" class="ui-widget-content ui-corner-all">
<!-- header begins -->

 <div id="main">

<jsp:include page="portal/header.jsp" />	
<div style="clear: both;"></div>
<div id="menu-principal" >

	<%if(area==null || area.equalsIgnoreCase("1") ){ %>
	<div id="menu-salud" class="ui-widget-content ui-corner-all">
	<jsp:include page="portal/menu.jsp" />
	</div>
	
	<%}else { %>
	<div id="menu-salud"  class="ui-widget-content ui-corner-all">
	<jsp:include page="portal/menu_area.jsp" />
	</div>
	<% }%>
	<jsp:include page="portal/login.jsp" />
</div>
     <div id="noticias">
<div id="Cont-Panel-texto" class="ui-widget-content ui-corner-all">
<jsp:include page="portal/inicio.jsp" />				
</div>
<jsp:include page="portal/noticias/noticias.jsp" />						
</div>
<div style="clear: both;"></div>

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