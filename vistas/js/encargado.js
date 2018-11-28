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


$( "#btnEditar" ).click(function() {
  editar();
});

function mostrarform(bool) {
  if (bool) {

    cargarPais();
    $("#tabla").hide();
    $("#formulario").show();
  } else {
    limpiar();
    mostrarbotones(false);
    $(".btn-floating").hide();
    $("#tabla").show();
    $("#formulario").hide();
  }
}

function mostrarbotones(bool) {
  if (bool) {
      $(".btn-floating").show();
    $('.botones').show();
    $('#btnguardar').hide();
  } else {
    $('#btnguardar').show();
    $('.botones').hide();
  }
}
//Función cancelarform
function cancelarform() {
  limpiar();
  mostrarform(false);
}

//Función Listar
function listar() {
  limpiar();
  tabla = $('#tbEncargado').dataTable({
    "aProcessing": true, //Activamos el procesamiento del datatables
    "aServerSide": true, //Paginación y filtrado realizados por el servidor
    dom: 'Bfrtip', //Definimos los elementos del control de tabla
    "ajax": {
      url: '../controlador/encargado.php?opcion=listar',
      type: "get",
      dataType: "json",
      error: function (e) {
        console.log(e.responseText);
      }
    },
    "bDestroy": true,
    "iDisplayLength": 10,
    "order": [
      [0, "desc"]
    ] //Ordenar (columna,orden)
  }).DataTable();
}
//Función para guardar o editar

function guardarEncargado(e) {
  var resp = true;
  if (validar()) {
    console.log('ENTRANDO 2...');
  e.preventDefault(); //No se activará la acción predeterminada del evento
  var DATOS = ($("#formEncargado").serialize());
  console.log('Datos de formulario' + DATOS);
  $.ajax({
    url: "../controlador/encargado.php?opcion=guardar",
    method: "POST",
    data: DATOS,


    success: function (datos) {
      tabla.ajax.reload();
      limpiar();
      mostrarform(false);
    }

  });
  //limpiar
  }else{
     $('#divResp').show();
    document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2 full-width";
    document.getElementById('divResp').innerHTML='<h6>No se llenaron los datos correspondientes o no tienen el formato adecuado</h6>';
    resp = false;
  }
  return resp;
}

function desactivar(cedula) {
  $.post("../controlador/encargado.php?opcion=desactivar", {
    cedula: cedula
  }, function (e) {
    tabla.ajax.reload();
  });
}

function activar(cedula) {
  $.post("../controlador/encargado.php?opcion=activar", {
    cedula: cedula
  }, function (e) {
    tabla.ajax.reload();
  });
}

function limpiar() {

  $("#nombre").val("");
  $("#apellido1").val("");
  $("#apellido2").val("");
  $("#cedula").val("");
  $("#direccion").val("");
  $("#telefono").val("");
  $("#correo").val("");
  $("#sexo").val("");
  $("#nacionalidad").text("");
  $("#telefono_secundario").text("");
  $("#estudiante").text("");


}

function mostrar(cedula) {
    $(".btn-floating").show();
  $.post("../controlador/encargado.php?opcion=mostrar", {
    cedula: cedula
  }, function (data, status) {

    limpiar();
    cargarPais();
    console.log(data);
    mostrarform(true);
    mostrarbotones(true);
    data = JSON.parse(data);
    $("#nombre").val(data.NOMBRE);
    $("#apellido1").val(data.APELLIDO1);
    $("#apellido2").val(data.APELLIDO2);
    $("#cedula").val(data.CEDULA);
    $("#telefono").val(data.TELEFONO);
    $("#telefono_secundario").val(data.TELEFONO_SECUNDARIO);
    $("#direccion").val(data.DIRECCION);
    $("#sexo").val(data.SEXO);
    $("#nacionalidad").val(data.PAIS);

  })

  cargarAlumnos(true, cedula);
  $(".js-example-responsive").prop("disabled", true);

}

function activarSelect() {

  $("#estudiante").prop("disabled", false);
  console.log('Aprobado1');
  cargarAlumnos(false, 0);
  console.log('Aprobado');


}

function buscar() {
  cedula = $('#cedulaE').val();
  console.log('cedula' + cedula);
  $.post("../controlador/encargado.php?opcion=mostrar", {
    cedulaE: cedulaE
  }, function (data, status) {
    data = JSON.parse(data);
    $("#nombreE").val(data.nombre_estudiante);
  })
}

function mostrarEstudiante(cedula, nombre, ap1, ap2) {
  mostrarform(true);
  var nombreCompleto = nombre + ' ' + ap1 + ' ' + ap2;
  $("#nombreE").val(nombre);
  $('#cedulaE').val(cedula);
}

function cargarPais() {
  $.ajax({
    url: "../controlador/profesor.php?opcion=cargarPais",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
    
        $("#sexo").empty();
        $("#sexo").append("<option value='Masculino' disabled selected hidden>Seleccionar el Género</option><option value='Masculino'>Masculino</option><option value='Femenino'>Femenino</option>");
        
      $('#nacionalidad').empty();
      $('#nacionalidad').append("<option disabled selected value=" + data[0].idNacionalidad +">Seleccionar Pais</option>");
      $.each(data, function (i, item) {

        $('#nacionalidad').append('<option value="' + data[i].idNacionalidad + '">' + data[i].pais + '</option>');

      });
    }

  });

}

function editar() {
  //No se activará la acción predeterminada del evento
  var DATOS = ($("#formEncargado").serialize());
  console.log('DATOS ENVIADOS CON JS' + DATOS);
  $.ajax({
    url: "../controlador/encargado.php?opcion=editar",
    method: "POST",
    data: DATOS,


    success: function (datos) {
      tabla.ajax.reload();
      limpiar();
      mostrarform(false);

    }


  });
  //limpiar

}

function cargarGrupo() {
  $.ajax({
    url: "../controlador/encargado.php?opcion=cargarGrupo",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      $('#idgrado').empty();
      $('#idgrado').append("<option value=" + data[0].ID_GRADO + ">Seleccionar Grado</option>");
      $.each(data, function (i, item) {

        $('#idgrado').append('<option value="' + data[i].ID_GRADO + '">' + data[i].NOMBRE_GRADO + ' ' + data[i].ANNIO + '</option>');

      });
    }

  });

}

function cargarGrado() {
  $.ajax({
    url: "../controlador/grado.php?opcion=listaSimple",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      $('#idgrado').empty();
      $('#idgrado').append("<option value="+ data[0].ID_GRADO + ">Seleccionar Grado</option>");
      $.each(data, function (i, item) {

        $('#idgrado').append('<option value="' + data[i].ID_GRADO + '">' + data[i].NOMBRE_GRADO + ' ' + data[i].ANNIO + '</option>');

      });
    }

  });

}

function cargarAlumnos(bool, ced) {
  console.log(ced + 'cedula');
  $('.js-example-responsive').select2();
  $.ajax({
    type: "GET",
    url: bool ? "../controlador/encargado.php?opcion=cargarEstudianteEncargado" : "../controlador/encargado.php?opcion=cargarEstudiante",
    data: {
      post: ced
    },
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      $('#estudiante').empty();
      $('#estudiante').append("<option value=" + data[0].idalumno + ">Seleccione un estudiante</option>");
      $.each(data, function (i, item) {
        if (bool) {
          $('#estudiante').append('<option value="' + data[i].idalumno + '" selected="selected">' + data[i].nombre + '</option>');
        } else {
          $('#estudiante').append('<option value="' + data[i].idalumno + '">' + data[i].nombre + '</option>');
        }


      });
    }

  });

}

$(document).ready(function () {
  if (window.location.hash === '#mostrarform') {
    mostrarform(true);
  }
})

function init() {
  cargarAlumnos(false, 0);
  limpiar();
  mostrarform(false);
  mostrarbotones(false);
  cargarGrado();
  listar();
  cargarPais();
  $('#divResp').hide();
  $("#formEncargado").on("submit", function (e) {
    guardarEncargado(e);
  })
}

init();