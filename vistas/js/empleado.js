var tabla;


function mostrarFormulario(estado){
    if(estado){
        $('#tabla').hide();
        $('#formulario').show();
        cargarPais();
        cargarPuesto()
    }else{
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
    }
}

function cancelarForm(){
    mostrarFormulario(false);
    mostrarBotones(false);
    listar();
}


function limpiar(){
    $('#cedula').val('');
    $('#nombre').val('');
    $('#apellido1').val('');
    $('#apellido2').val('');
    $('#telefono').val('');
    $('#direccion').val('');
}


function listar(){
    tabla = $('#tblEmpleado').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/empleado.php?opcion=listar',
  					type : "get",
  					dataType : "json",
  					error: function(e){
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
  	    "order": [[ 1, "asc" ]]//Ordenar (columna,orden)
    }).DataTable();
        $('#divResp').hide();

}

function guardar(e){
    e.preventDefault();
    var DATOS = ($("#formEmpleado").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/empleado.php?opcion=guardar",
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
              mostrarFormulario(false);
  	    }

      });
      limpiar();
}

function mostrar(cedula){
    $.post("../controlador/empleado.php?opcion=mostrar",{cedula : cedula}, function(data, status){
        limpiar();
        mostrarFormulario(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#cedula').val(data.cedula);
        $('#nombre').val(data.nombre);
        $('#apellido1').val(data.apellido1);
        $('#apellido2').val(data.apellido2);
        $('#telefono').val(data.telefono);
        $('#direccion').val(data.direccion);
        $('#sexo option:selected').text(data.sexo);
        $('#idNacionalidad option:selected').text(data.pais);
        $('#idPuesto option:selected').text(data.nombrePuesto);

    })
}

function cargarPais(){
  $.ajax({
         url: "../controlador/empleado.php?opcion=cargarPais",
         method: "POST",
         dataType : "json",
         contentType: "application/json; charset=utf-8",
         success: function(data)
         {
             $('#idNacionalidad').empty();
             $('#idNacionalidad').append("<option>Seleccionar Pais</option>");
             $.each(data,function(i,item){

                 $('#idNacionalidad').append('<option value="'+data[i].idNacionalidad+'">'+data[i].pais+'</option>');

             });
         }

     });

}

function cargarPuesto(){
  $.ajax({
         url: "../controlador/empleado.php?opcion=cargarPuesto",
         method: "POST",
         dataType : "json",
         contentType: "application/json; charset=utf-8",
         success: function(data)
         {
             $('#idPuesto').empty();
             $('#idPuesto').append("<option>Seleccionar Puesto</option>");
             $.each(data,function(i,item){

                 $('#idPuesto').append('<option value="'+data[i].idPuesto+'">'+data[i].nombrePuesto+'</option>');

             });
         }

     });

}
function desactivar(cedula)
{
          $.post("../controlador/empleado.php?opcion=desactivar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}
function activar(cedula)
{
          $.post("../controlador/empleado.php?opcion=activar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}

function editar(){
    var DATOS = ($("#formEmpleado").serialize());
    console.log(DATOS);
    $.ajax({
        url: "../controlador/empleado.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
            if(datos=="Registrado"){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se actualizo exitosamente!</h5>';
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }
            tabla.ajax.reload();
            limpiar();
            mostrarFormulario(false);

        }

    });

}

document.getElementById('btnEditar').onclick = function(){
    editar();
};

$(document).ready(function (){
    if (window.location.hash === '#mostrarFormulario') {mostrarFormulario(true);}
})

function INIT(){
    limpiar();
  	mostrarFormulario(false);
    mostrarBotones(false);
    listar();
    $('#divResp').hide();

     $("#formEmpleado").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();
