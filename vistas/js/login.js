

function guardar(e){
   

    e.preventDefault();
    
    var DATOS = ($("#formLogin").serialize());
    console.log(DATOS);
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
                $(location).attr('href','../vistas/UIMantenimientoAlumno.php');
            }else if(datos == "2"){
                $(location).attr('href','../vistas/UIListaAlumno.php');
            }else{
                document.getElementById('resp').innerHTML="Credenciales incorrectas!";
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
}

INIT();
