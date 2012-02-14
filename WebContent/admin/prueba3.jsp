<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>
</head>
<body>
<input id="fileupload" type="file" name="files[]" >
<jsp:include page="modulo/top.jsp" />
<script>
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        url: '../uploadimagen',
        formData: {area: '1'},
        done: function (e, data) {
            $.each(data.result, function (index, file) {
            	$('<p/>').text(file).appendTo(document.body);
            });
        }
    });
});
</script>
</body> 
</html>