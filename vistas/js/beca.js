var tabla;
var estado;


function validar(){
  
  var expRegCedula = new RegExp("^[^0\-][0-9+]{1,9}");
  var expRegNombre = new RegExp("[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+");

  var descripcion = document.getElementById("descripcionBeca").value;
  var cedula  = document.getElementById("cedula").value;
  //var cedulaaawda  = document.getElementsById("cedula").value;
  var monto = document.getElementById("monto").value;

  
    if (expRegCedula.test(cedula)) {
      console.log("Nombre validacion");
      if (expRegNombre.test(descripcion)==true && expRegCedula.test(monto)==true) {
        console.log("descripcion y monto validacion");
        estado = true;
      }else{
        estado = false;
      }
      
    }else{
      estado = false;
    }
 //console.log(cedulaaawda);
  console.log(cedula);
  console.log(expRegCedula.test(cedula));
  console.log("estado: "+estado);
  return estado;
}




function mostrarFormularioBeca(estado){
    if(estado){
        $('#tabla').hide();
        $('#formulario').show();
        mostrarBotones(false);
    }else{
        $('#divResp').hide();
        $('#tabla').show();
        $('#formulario').hide();
        limpiar();
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
        $('#cedula').removeAttr("readonly");
    }
}

function cancelarForm(){
    mostrarFormularioBeca(false);
    mostrarBotones(false);
}


function limpiar(){
    $('#cedula').val('');
    $('#descripcionBeca').val('');
    $('#monto').val('');
}


function listar(){
    tabla = $('#tblBeca').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/beca.php?opcion=listar',
  					type : "get",
  					dataType : "json",
  					error: function(e){
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
  	    "order": [[ 0, "asc" ]]//Ordenar (columna,orden)
    }).DataTable();
    $('#divResp').hide();
}

function guardar(e){
    var resp = true;
    if (validar()) {
        e.preventDefault();
    var DATOS = ($("#formBeca").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/beca.php?opcion=guardar",
  	    method: "POST",
  	    data: DATOS,

  	    success: function(datos)
  	    {
                
                tabla.ajax.reload();
                if(datos=="Registrado"){
                  
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se guardo exitosamente!</h5>';
                }else{
                    
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }

                limpiar();
                mostrarFormularioBeca(false);

  	    }

      });
      limpiar();
    }else{
        $('#divResp').show();
        document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
        document.getElementById('divResp').innerHTML='<h5>Debe llenar los campos en el formato requerido!</h5>';
        resp = false;
    }
    return resp;
}

function mostrar(id){
  console.log('Variable recibida'+id);
    $.post("../controlador/beca.php?opcion=mostrar",{cedula : id}, function(data, status){
        limpiar();
        mostrarFormularioBeca(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#cedula').val(data.cedula);
        $('#descripcionBeca').val(data.descripcion_beca);
        $('#monto').val(data.monto_beca);
        $('#cedula').attr("readonly","readonly");
    })
}

function editar(e){
    var resp = true;
    if (validar()) {
       var DATOS = ($("#formBeca").serialize());
    $.ajax({
        url: "../controlador/beca.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
              tabla.ajax.reload();
              limpiar();
              if(datos=="Registrado"){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se actualizo exitosamente!</h5>';
                  mostrarFormularioBeca(false);
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }

              mostrarFormularioBeca(true);
              $('#cedula').attr("readonly","readonly");

        }

    }); 
    }else{
        $('#divResp').show();
        document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
        document.getElementById('divResp').innerHTML='<h5>Debe llenar los campos en el formato requerido!</h5>';
        resp = false;
    }
    return resp;

}

document.getElementById('btnEditar').onclick = function(){
    editar();
};


function desactivar(cedula)
{
          $.post("../controlador/beca.php?opcion=desactivar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}
function activar(cedula)
{
          $.post("../controlador/beca.php?opcion=activar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}

$(document).ready(function (){
    if (window.location.hash === '#mostrarFormularioBeca') {mostrarFormularioBeca(true);}
})

function INIT(){
    limpiar();
  	mostrarFormularioBeca(false);
    mostrarBotones(false);
    listar();
    $('#divResp').hide();

     $("#formBeca").on("submit",function(e){

  		guardar(e);
  	 })
}

INIT();
