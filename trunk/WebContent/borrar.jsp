
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>jQuery Validation Plugin Password Extension demo</title>



<link rel="stylesheet" type="text/css" media="all" href="css/jquery.validate.password.css" />


<script type="text/javascript" src="lib/jquery-1.7.1.min.js"></script>

<script src="lib/jquery.validate.js"></script>
<script src="lib/jquery.validate.password.js"></script>

<script id="demo" type="text/javascript">
$(document).ready(function() {
	$("#register").validate();
	$("#password").valid();
	
});
</script>
<style>
label, input { float: left; }
input { margin-left: 1em; } 
label.error { display: none !important; }
.password-meter {
	float: left;
}
</style>

</head>
<body>

<form id="register">
	<label for="password">Password:</label>
	<input class="password" name="password" id="password" />
	<div class="password-meter">
		<div class="password-meter-message">&nbsp;</div>
		<div class="password-meter-bg">
			<div class="password-meter-bar"></div>
		</div>
	</div>
</form>


</body>
</html>