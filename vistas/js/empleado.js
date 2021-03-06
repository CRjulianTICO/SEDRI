var tabla;

function validar(){
  
  var expRegCedula = new RegExp("^[^0\-][0-9+]{8,9}");
  var expRegNombre = new RegExp("[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+");
  var expRegTelefono = new RegExp("^[^01359][0-9]{7,8}");

  var nombre = document.getElementById("nombre").value;
  var cedula  = document.getElementById("cedula").value;
  var telefono = document.getElementById("telefono").value;
  var apellido1 = document.getElementById("apellido1").value;
  var apellido2 = document.getElementById("apellido2").value;

  
    if (expRegNombre.test(nombre)) {
      console.log("Nombre validacion");
      if (expRegNombre.test(apellido1)==true && expRegNombre.test(apellido2)==true) {
        console.log("Apellidos validacion");
        if (expRegCedula.test(cedula) && expRegTelefono.test(telefono)) {
          console.log("Apellidos validacion");
          estado = true;
        }else{
          estado = false;
        }
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
    var resp = true;
    if (validar()) {
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
    }else{
         $('#divResp').show();
         document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
         document.getElementById('divResp').innerHTML='<h5>Debe llenar los campos en el formato solicitado!</h5>';
         resp = false;
    }
    return resp;
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
            $("#sexo").empty();
        
            $("#sexo").append("<option value='Masculino' disabled selected hidden>Seleccionar el Género</option><option value='Masculino'>Masculino</option><option value='Femenino'>Femenino</option>");

             $('#idNacionalidad').empty();
             $('#idNacionalidad').append("<option value="+data[0].idNacionalidad+">Seleccionar Pais</option>");
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
             $('#idPuesto').append("<option value="+data[0].idPuesto+" >Seleccionar Puesto</option>");
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
    var resp = true;
    if (validar()) {
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
    }else{
        $('#divResp').show();
        document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
        document.getElementById('divResp').innerHTML='<h5>Debe llenar los campos en el formato solicitado!</h5>';
        resp = false;
                
    }
    return resp;
    

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
