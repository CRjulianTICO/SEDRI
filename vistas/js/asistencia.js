var tabla;
var count ;

function mostrarFormulario(estado){
    if(estado){
        $('#tabla').hide();
        $('#formulario').show();
      
    }else{
        $('#tabla').show();
        $('#formulario').hide();
      //  limpiar();
    }
}

function mostrarBotones(estado){
    if(estado){
        $('#btnGuardar').hide();
        $('#btnEditar').show();
        $('#btnCancelar').show();
    }else{
        $('#btnGuardar').show();
        $('#btnEditar').hide();
        $('#btnCancelar').hide();
    }
}


function cancelarForm(){
    mostrarFormulario(false);
    mostrarBotones(false);
    listar();
}







function guardar(){
    //e.preventDefault();
    count = $('#tblAsistenciaActual tbody tr').length; 
    
     $(".ced").prop("disabled", false);
     
for (index = 1; index <= count; index++) {
 var DATOS = ($("#frm"+index).serialize());
    
 
    console.log("->"+DATOS+"<-");
  	$.ajax({
  		url: "../controlador/asistencia.php?opcion=guardar",
        type: "POST",
          data: DATOS,

  	    success: function(datos)
  	    {
                tabla.ajax.reload();
              //  limpiar();
              mostrarFormulario(false);
              if(datos == 'Registrado'){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se registro exitosamente!</h5><br><h6>Si desea modificar alguna asistencia debe ir al Registro dentro de Asistencia.</h6>';
               
              }else if (datos == 'Error'){
                  $('#divResp').show();
                  
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se produjo un error. Vuelva a Intentarlo.</h5>';
              }else{
                  $('#divResp').show();
                  
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Registro ya existente!</h5><br><h6>Si desea modificar alguna asistencia debe ir al Registro dentro de Asistencia.</h6>';
              }
  	    }

      });    
    
}

         
}

function listar(){
    tabla = $('#tblAsistenciaActual').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/asistencia.php?opcion=listar',
  					type : "get",
  					dataType : "json",
  					error: function(e){
                          
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
          "order": [[ 1, "asc" ]],//Ordenar (columna,orden),
          /* "createdRow": function ( row, data, index ) {
        $('td', row).eq(0).attr('id',  index ),
        $('td', row).eq(0).attr('name',  "cedula")
        $('td', row).eq(5).attr('id',  index ),
        $('td', row).eq(5).attr('name',  "estado" ),
        $('td', row).eq(6).attr('id',  index ),
        $('td', row).eq(6).attr('name',  "nota")
          } */
    }).DataTable();

/*
    numRows = tabla.rows().count();
    console.log(numRows);
    alert(tabla.rows('.estado').count());

    */
}

document.getElementById('btnGuardar').onclick = function(){
    guardar();
    $(".ced").prop("disabled", true);
};


function INIT(){
     //$(".ced").prop("disabled", true);
     $('#divResp').hide();
    listar();
    
     $(".dropdown-content>li>a").css("color", "#000000");
/*
     $("#btnGuardar").on("click",function(e){
          guardar(e);
          $(".ced").prop("disabled", true);
     });*/
}



INIT();
