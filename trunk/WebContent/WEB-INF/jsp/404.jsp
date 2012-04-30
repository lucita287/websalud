<%@ page import="framework.CDataBase" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%String area=request.getParameter("idarea");%>
<title>Unidad de Salud / USAC</title>
<jsp:include page="../../portal/top.jsp" />
<meta name=description content="Divisi&oacute;n de Bienestar EstudiantiL, USAC. Dentro de las actividades de servicio, se encuentra la realizaci&oacute;n del examen obligatorio de salud a todos los estudiantes de primer ingreso." />
</head>

<body>
<div class="back_all">
<div id="content">

<div class="top">
<jsp:include page="../../portal/titulo.jsp">
<jsp:param name="titulo" value="PAGINA NO ENCONTRADA" />	
</jsp:include>
</div>

<div id="back" class="ui-widget-content ui-corner-all">
<!-- header begins -->

	 <div id="main">
	 
				<p>Lo sentimos!! no encontramos lo que estabas buscando. Posibles causas:
				</p>
				<ul>
				<li type="disc">No escribiste correctamente la dirección web</li>
				<li type="disc">Posiblemente fue movido el contenido requerido</li>
				<li type="disc">No definitivamente no existe este contenido</li>
				</ul>
				<p>
				Regresa a la <a href="<%=CDataBase.getWebhost()%>">p&aacute;gina principal</a>. 
				</p>	 
	 
	 </div>
</div>

</div>
</div>
</body>
</html>

