		$(document).ready(
		        function() {
		            // translate validator error msg
		            $.extend($.validator.messages, {
		            	required: "Campo Obligatorio",
		        		remote: "Por favor componga este campo.",
		        		email: "Por favor ingrese un correo electronico valido",
		        		url: "Por favor ingrese una URL valida",
		        		date: "Por favor ingrese una fecha valida.",
		        		dateISO: "Please enter a valid date (ISO).",
		        		dateDE: "Bitte geben Sie ein gültiges Datum ein.",
		        		number: "Por favor ingrese un numero.",
		        		numberDE: "Bitte geben Sie eine Nummer ein.",
		        		digits: "Por favor ingrese solo digitos",
		        		creditcard: "Por favor ingrese un numero de tarjeta de credito.",
		        		equalTo: "Por favor ingrese el mismo valor otra vez.",
		        		accept: "Please enter a value with a valid extension.",
		        		maxlength: $.format("Por favor no ingrese no mas de {0} caracteres."),
		        		minlength: $.format("Por favor ingrese almenos {0} caracteres."),
		        		rangelength: $.format("Por favor ingrese los valores entre {0} y {1} longitud de caracteres."),
		        		range: $.format("Please enter a value between {0} and {1}."),
		        		max: $.format(" Por favor ingrese un valor menor o igual a  {0}."),
		        		min: $.format("Por favor ingrese un valor mayor o igual a {0}.")
		            });                          
		 
		            $.extend($.validator.passwordRating.messages , {
		            		"similar-to-username": "Muy similar al nombre de usuario",
		            		"too-short": "Muy corto",
		            		"very-weak": "Muy debil",
		            		"weak": "Debil",
		            		"good": "Bueno",
		            		"strong": "Fuerte"
		            	}
		            );
		        }
		    );