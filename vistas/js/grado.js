var tabla;

//Función que se ejecuta al inicio

$(document).ready(function() {
  init();
  $( "#btnEditar" ).on( "click", editar );
});


function init() {
  limpiar();
  mostrarformGrado(false);
  mostrarbotones(false);
  listar();
  $("#formGrado").on("submit", function(e) {
    guardar(e);
  })
}

function mostrarbotones(bool) {
  if (bool) {
    $('#botones').show();
    $('#btnguardar').hide();
  } else {
    $('#btnguardar').show();
    $('#botones').hide();
  }
}

function listar() {
  limpiar();
  tabla = $('#tbGrado').dataTable({
    "aProcessing": true, //Activamos el procesamiento del datatables
    "aServerSide": true, //Paginación y filtrado realizados por el servidor
    dom: 'Bfrtip', //Definimos los elementos del control de tabla
    "ajax": {
      url: '../controlador/grado.php?opcion=listar',
      type: "get",
      dataType: "json",
      error: function(e) {
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

function guardar(e) {
  e.preventDefault(); //No se activará la acción predeterminada del evento
  var DATOS = ($("#formGrado").serialize());
  $.ajax({
    url: "../controlador/grado.php?opcion=guardar",
    method: "POST",
    data: DATOS,
    success: function(datos) {
      tabla.ajax.reload();
    }
  });
  //limpiar
}

function mostrarformGrado(bool) {
  if (bool) {
    $("#tabla").hide();
    $("#formulario").show();
  } else {
    limpiar();
    mostrarbotones(false);
    $("#tabla").show();
    $("#formulario").hide();
  }
}

function cancelarform() {
  limpiar();
  mostrarformGrado(false);
}

function limpiar() {
  $("#nombreGrado").val("");
  $("#idgrado").val("");
}

function mostrar(idgrado) {
  mostrarformGrado(true);
  $.post("../controlador/grado.php?opcion=mostrar", {
    idgrado: idgrado
  }, function(data, status) {
    limpiar();
    mostrarbotones(true);
    data = JSON.parse(data);
    $("#nombreGrado").val(data.nombreGrado);
    $("#idgrado").val(data.idgrado);
  })
}

function editar() {
  //No se activará la acción predeterminada del evento
  var DATOS = ($("#formGrado").serialize());
  $.ajax({
    url: "../controlador/grado.php?opcion=editar",
    method: "POST",
    data: DATOS,
    success: function(datos) {
      tabla.ajax.reload();
      limpiar();
      mostrarformGrado(false);
    }
  });
  //limpiar

}

init();
