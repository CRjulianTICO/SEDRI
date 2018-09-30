

function guardar(e){
   // window.location='../controlador/autenticacion.php?opcion=login';

    e.preventDefault();
    
    var DATOS = ($("#formLogin").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/autenticacion.php?opcion=login",
  	    method: "POST",
  	    data: DATOS,
      });
      
}


function INIT(){
    console.log('Datos INIT');
     $("#formLogin").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();
