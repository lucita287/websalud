<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Unidad de Salud / USAC</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link type="text/css" href="../css/redmond/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
<link rel="stylesheet" href="../css/nivo-slider.css" type="text/css" media="screen" />
<script type="text/javascript" src="../lib/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../lib/jquery.nivo.slider.pack.js"></script>
<script type="text/javascript" src="../lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="../lib/jcarousellite_1.0.1c4.js" type="text/javascript"></script>
<style>
div {
background-color:#6495ED;
width:100px;
border:1px solid #FFF8DC;
}
</style>
</head>
<body>

  <button id="go">&raquo; Run</button>

<div id="block"><img src="../images/u-salud.png" width="100px" height="80px" /></div>
<script>
$(window).load(function() {
    $('#slider').nivoSlider();
});
$("#go").click(function(){
  $("#block").animate({
    width: "70%",
    opacity: 0.4,
    marginLeft: "0.6in",
    fontSize: "3em",
    borderWidth: "10px"
  }, 1500 );
});
</script>
<div id="slider-wrapper">        

					    <div id="slider" class="nivoSlider">

									<img src="images/u-salud.png" alt=""  title="Examen de Salud / Primer Ingreso" />

									<img src="images/header2.jpg" alt="" title="Universidad de San Carlos de Guatemala" />

									<img src="images/header3.jpg" alt="" title="Areás de la unidad de salud" />									

						</div>        

				</div>

</body>
</html>

