<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="framework.CDataBase" %>
<%@ page import="data.CConfiguracion" %>
<%
CDataBase dbo=new CDataBase();
dbo.Connect();
CConfiguracion temp=dbo.getConfiguracion();
dbo.Close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="portal/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<div style="float:left">
<img src="images/usalud.png" width="100px" height="100px" />
</div>
<div style="float:left">
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph">Administraci&oacute;n</a></h2>
</div>
<div style="clear: both;"></div>
</div>

<div id="back">
<!-- header begins -->

 <div id="main">

<jsp:include page="portal/header.jsp" />	
<div style="clear: both;"></div>
<div id="menu-principal" >

	<jsp:include page="portal/menu.jsp" />
<div>

	<jsp:include page="portal/login.jsp" />
</div>
</div>
     <div id="noticias">
<div id="Cont-Panel-texto" class="ui-widget-content ui-corner-all">
<jsp:include page="portal/contenido.jsp" />				
</div>
<jsp:include page="portal/noticias.jsp" />						
</div>
<div style="clear: both;"></div>

</div>	
<!--content ends -->
</div>
<!--footer begins -->

				<div class="row-top">
					<div class="row-padding">
						<div class="wrapper">
							<div id="contactanos">
								<h2>CONTACTANOS</h2>
									<table>
										<tr>
											<td><span>Direccion:</span></td> <td><%=temp.getdireccion()%></td>
										</tr>
										<tr>
											<td><span>Telefono:</span></td><td><%=temp.gettelefono()%></td>
										</tr>
										<tr>
											<td><span>Fax:</span></td><td><%=temp.getfax()%></td>
										</tr>	
									 	<tr>
											<td><span>Email:</span></td><td><%=temp.getcorreo_electronico()%></td>
										</tr>
									</table>	
							</div>
							<div id="ppivs">
								<img src="images/final_user/PPIVS.jpg" width="550px" heigth="300px"/>
							</div>	
						</div>
					</div>
				</div>

<div id="footer">
<p>Unidad de Salud 2012. | <a href="http://www.usac.edu.gt/">USAC</a>  </p> 
	              
		</p>
	</div>
</div>

<!-- footer ends-->

</div>
</body>
</html>