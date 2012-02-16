<script  type="text/javascript">

var idpdf=0;
$(function () {
	var input = $('#input');
	
    $('#fileupload_pdf').fileupload({
        dataType: 'json',
        url: '../uploadpdf',
        done: function (e, data) {
        	
        	cadena="";
        	ok=false;
            $.each(data.result, function (index, file) {
            	if(index=='result' ){
            		cadena=cadena+file+"<br/>";	
            		if(file=='OK')ok=true;
            	}
            	if(index=='name'&&ok==true){
            		$('#pathpdf').text(file);
            	}
            	if(index=='idsafe'&&ok==true){
            		idpdf=file;
            	}
            	if(index=='Mensaje'&&ok==false){
            		cadena=cadena+file+"<br/>";	
            	}
            	
            });
            $('#validacion_pdf').html(cadena);
        }
    });
});
</script>						
						
						<div id="validacion_pdf" class="validacion"></div>
						<input id="fileupload_pdf" type="file" name="files[]" ><BR/>
						<label id="pathpdf">NO SE HA SUBIDO PDF</label><br/>