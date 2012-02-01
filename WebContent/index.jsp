<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="portal/top.jsp" />
</head>
<body>
<div class="back_all">
<div id="content">

<div class="top">
<table>
<tr>
<td>
<img src="images/usalud.png" width="100px" height="100px" />
</td>
<td>
<h1><a href="#">Unidad de Salud</a></h1>
<h2><a href="#" id="metamorph">Universidad de San Carlos de Guatemala</a></h2>
</td>
</tr>
</table>
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
							<div class="col-1">
								<h2>Address:</h2>
								<dl class="address">
									<dt><span>Country:</span> USA</dt>
									<dd><span>City:</span> Faucibus</dd>
									<dd><span>Address:</span> Bearchmond dr. 32</dd>
									<dd><span>Email:</span><a href="#"> yourmail@mail.com</a></dd>
								</dl>
							</div>
							<div class="col-2">
								<h2>Follow Us:</h2>
								<ul class="list-services">
									<li class="item-1"><a href="#">Facebook</a></li>
									<li class="item-2"><a href="#">Twitter</a></li>
									<li class="item-3"><a href="#">LinkedIn</a></li>
								</ul>
							</div>
							<div class="col-3">
								<h2>Why Us:</h2>
								<ul class="list-1">
									<li><a href="#">Lorem ipsum dolor</a></li>
									<li><a href="#">Aonsect adipisic</a></li>
									<li><a href="#">Eiusmjkod tempor</a></li> 
									<li><a href="#">Incididunt ut labore</a></li>
								</ul>
							</div>
							<div class="col-4">
								<div class="indent3">
									<strong class="footer-logo">Company Name</strong>
									<strong class="phone"><strong>Toll Free:</strong> 1-800-343-5454</strong>
								</div>
							</div>
						</div>
					</div>
				</div>

<div id="footer">
<p>Copyright &copy; 2011. <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a> | <a href="http://validator.w3.org/check/referer" title="This page validates as XHTML 1.0 Transitional"><abbr title="eXtensible HyperText Markup Language">XHTML</abbr></a> | <a href="http://jigsaw.w3.org/css-validator/check/referer" title="This page validates as CSS"><abbr title="Cascading Style Sheets">CSS</abbr></a></p> 
	<p><!-- Do not remove -->Designed by <a href="http://www.metamorphozis.com/" title="Free Web Templates">Free Web Templates</a>, coded by <a href="http://www.myfreecsstemplates.com/" title="Free CSS Templates">Free CSS Templates</a><!-- end -->               
		</p>
	</div>
</div>

<!-- footer ends-->

</div>
</body>
</html>