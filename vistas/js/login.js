

function guardar(e){
   

    e.preventDefault();
    var DATOS = ($("#formLogin").serialize());
    var cedula = $("#user").val();
    console.log(cedula);
  	$.ajax({
  		url: "../controlador/autenticacion.php?opcion=login",
  	    method: "POST",
        data: DATOS,
        beforeSend:function(){
            $('#btn_login').val("Conectando");
        },
          success: function(datos)
  	    {
            document.getElementById('resp').innerHTML="";
            $('#btn_login').val("Iniciar Sesión");
            if(datos=="1"){

                console.log('Datos recibidos es 1');
                $(location).attr('href','../vistas/UIMantenimientoAlumno.php');
           
            }else if(datos == "2"){
                console.log('Datos recibidos es 2');
                $(location).attr('href','../vistas/UIListaAlumno.php');
            }else if(datos == "3"){
                console.log('Datos recibidos es 3');
                $(location).attr('href','../vistas/cambiarPassword.php?cedula='+cedula);

            }else{
                $('#resp').show();
                document.getElementById('resp').innerHTML="<h6 class='subtitle'>Credenciales incorrectas! <br> Intente de nuevo.</h6>";
            }
        }
          
      });
      
}
/* 
function enviar(){
    passs = document.getElementById("pass");
    users = document.getElementById("user");
    
    var xhttp = new XMLHttpRequest();
    
    xhttp.open("POST", "../controlador/autenticacion.php?opcion=login", true);
    xhttp.onreadystatechange = function() {
*/

function recupera(e){
    e.preventDefault();
    var DATOS = ($("#formRecupera").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/autenticacion.php?opcion=recuperar",
  	    method: "POST",
        data: DATOS,
        beforeSend:function(){ 
            $('#aviso').css({display:'block'});
        },
          success: function(datos)
  	    {
            if(datos=="1"){
                swal(
                    'Recuperación de Contraseña',
                    'Se le enviaran los datos a su cuenta de correo',
                    'success'
                  ).then(function() {
                    $(location).attr('href','../vistas/Login.php');
                });
                  
                  $('#aviso').css({display:'none'});               
            }else{
                
                swal(
                    'Recuperación de Contraseña',
                    'Ocurrio un error al procesar los datos',
                    'error'
                  );
                  $('#aviso').css({display:'none'});
            }
        }
          
      });


    }

    
function cambio(e){
    console.log('DATOS RECOLECTADOS DE USUARIO = '+user);
    if (user==0){
        swal(
            'Error',
            'Por favor ingrese de nuevo los datos',
            'error'
          );
    }else{
    e.preventDefault();
    var cont = $('#pass').val();
    console.log(cont+'Pass encontrada');
  	$.ajax({
  		url: "../controlador/autenticacion.php?opcion=cambiar",
  	    method: "POST",
        data: {pass:cont,cedula:user},
        beforeSend:function(){ 
            $('#aviso').css({display:'block'});
        },
          success: function(datos)
  	    {
            if(datos=="1"){
                swal(
                    'Cambio de contraseña',
                    'Se ha cambiado la contraseña',
                    'success'
                  ).then(function() {
                    $(location).attr('href','../vistas/Login.php');
                });
                  
                  $('#aviso').css({display:'none'});               
            }else if(datos==0){
                
                swal(
                    'Recuperación de Contraseña',
                    'No se encontraron datos',
                    'error'
                  );
                  $('#aviso').css({display:'none'});
            }else{
                swal(
                    'Ya había utilizado esta contraseña',
                    'Por su seguridad le solicitamos ingresar una contraseña nueva',
                    'error'
                  );
                  $('#aviso').css({display:'none'});
            }
        }          
      });
    }
}
/* 
function enviar(){
    passs = document.getElementById("pass");
    users = document.getElementById("user");
    
    var xhttp = new XMLHttpRequest();
    
    xhttp.open("POST", "../controlador/autenticacion.php?opcion=login", true);
    xhttp.onreadystatechange = function() {


    xhttp.onprogress = function () {
        console.log('LOADING', xhttp.status);
    };

    xhttp.onload = function () {
        console.log('DONE', xhttp.status);
    };

        alert(this.readyState+" nop/ready");
        alert(this.status+" nop/status");
    if (this.readyState == 4 && this.status == 200) {
       // Typical action to be performed when the document is ready:
       document.getElementById("contenido").innerHTML = "xhttp.responseText";
       
    }
    
};
  xhttp.send("user=users&pass=passs");   
}
 */

function INIT(){
    console.log('Datos INIT');
     $("#formLogin").on("submit",function(e){
  		guardar(e);
       })

       $('#resp').hide();

       $("#formRecupera").on("submit",function(e){
        recupera(e);
     })
     $("#formCambio").on("submit",function(e){
        cambio(e);
     })

}

INIT();
