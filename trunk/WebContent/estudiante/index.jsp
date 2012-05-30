<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CValidation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
HttpSession sessiones=request.getSession(false); 
if(sessiones!=null && sessiones.getAttribute("paciente")!=null){
	CValidation valid=new CValidation();
	Integer portal=valid.ConvertEntero(request.getParameter("portal"));
	String user=(String)sessiones.getAttribute("estudiante");
	
%>
<head>
<jsp:include page="modulo_perfil/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">



<div id="back"  class="ui-widget-content ui-corner-all">


<!-- header begins -->

 <div id="main">
<div style="clear: both;"></div>


<jsp:include page="modulo_perfil/menu.jsp" />


<div id="contenido">

<div id="cont_dato_personal">
<div class="unlogin">
						<div style="float:left;">
							<h1>UNIDAD DE SALUD/ EXAMEN DE SALUD</h1>
						</div>
						<div style="float:right;">
						<img src="../images/icon_online.png" />
						Bienvenido | <%=user %> |
						<a Style="color:#0000CD;" href="../SunLogin">(Salir)</a>	
						</div>
						<div style="clear: both;"></div>
</div>
<% if(portal==1){ %>
<jsp:include page="modulo_perfil/dato_personal.jsp" />
<% }else if(portal==5){ %>
<jsp:include page="modulo_perfil/multi.jsp" />
<% }else if(portal==6){ %>
<jsp:include page="modulo_perfil/auto_eva.jsp" />
<% }else if(portal==9){ %>
<jsp:include page="modulo_perfil/report.jsp" />
<% }else if(portal==7){ %>
<jsp:include page="modulo_perfil/evaluacion.jsp" />
<% }else if(portal==8){ %>
<jsp:include page="modulo_perfil/citas.jsp" />
<% }else if(portal==10){ %>
<jsp:include page="modulo_perfil/examen_categoria.jsp" />
<% }else if(portal==11){ %>
<jsp:include page="modulo_perfil/psico.jsp" />
<% }else{ %>
<jsp:include page="modulo_perfil/instru.jsp" />
<% } %>
</div>
</div>
<div style="clear: both;"></div>

</div>	
<!--content ends -->
</div>
<!--footer begins -->




<jsp:include page="../portal/footer.jsp" />

</div>

<!-- footer ends-->

</div>
</body>
<% }else{
	response.sendRedirect("../index.jsp");
	
} %>
</html>