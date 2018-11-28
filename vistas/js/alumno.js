var tabla;


$(document).ready(function () {
  if (window.location.hash === '#mostrarform') {
    mostrarform(true);
  }
})


function tipoProfesor() {
  if (tipoProfe == 1) {
    $('.cbGrados').hide();
  } else {
    $('.cbGrados').show();
  }

}


function mostrarform(bool) {
  if (bool) {
    cargarPais();
    $("#tabla").hide();
    $("#formulario").show();
    cargarGrados();
    $('#divResp').empty();
  } else {
    limpiar();
    mostrarbotones(false);
    $("#tabla").show();
    $("#formulario").hide();
    $('#divResp').empty();
  }
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
//Función cancelarform
function cancelarform() {
  limpiar();
  mostrarform(false);
}

//Función Listar
function listar(idGrado) {
  tabla = $('#tbAlumno').dataTable({
    "aProcessing": true, //Activamos el procesamiento del datatables
    "aServerSide": true, //Paginación y filtrado realizados por el servidor
    dom: 'Bfrtip', //Definimos los elementos del control de tabla
    "ajax": {
      url: '../controlador/alumno.php?opcion=listar&grado=' + idGrado,
      type: "get",
      dataType: "json",
      error: function (e) {

        console.log(e.responseText);
      }
    },
    "bDestroy": true,
    "iDisplayLength": 10,
    "order": [
      [1, "asc"]
    ], //Ordenar (columna,orden),
    /* "createdRow": function ( row, data, index ) {
        $('td', row).eq(0).attr('id',  index ),
        $('td', row).eq(0).attr('name',  "cedula")
        $('td', row).eq(5).attr('id',  index ),
        $('td', row).eq(5).attr('name',  "estado" ),
        $('td', row).eq(6).attr('id',  index ),
        $('td', row).eq(6).attr('name',  "nota")
          } */
  }).DataTable();

}
//Función para guardar o editar

function guardar(e) {
  e.preventDefault();
  var DATOS = ($("#formAlumno").serialize());
  $.ajax({
    url: "../controlador/alumno.php?opcion=guardar",
    method: "POST",
    data: DATOS,

    success: function (datos) {
      tabla.ajax.reload();
      console.log("Datos"+datos)
      if(datos.includes("Registrado")){
        $('#divResp').show();
        document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2 full-width";
        document.getElementById('divResp').innerHTML='<h6>Se registro un nuevo alumno</h6>';
      }else{
        $('#divResp').show();
        document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
        document.getElementById('divResp').innerHTML='<h6>Ocurrió un error</h6>';
      
      }
      limpiar();
      cargarPais();
    }
    
  });

}

function desactivar(cedula) {
  $.post("../controlador/alumno.php?opcion=desactivar", {
    cedula: cedula
  }, function (e) {
    tabla.ajax.reload();
  });
}

function activar(cedula) {
  $.post("../controlador/alumno.php?opcion=activar", {
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
  $("#nota").val("");



}

function mostrar(cedula) {
  $.post("../controlador/alumno.php?opcion=mostrar", {
    cedula: cedula
  }, function (data, status) {
    limpiar();
    cargarPais();
    console.log("Hola"+data);
    mostrarform(true);
    mostrarbotones(true);
    data = JSON.parse(data);
    $("#nombre").val(data.nombre);
    $("#apellido1").val(data.apellido1);
    $("#apellido2").val(data.apellido2);
    $("#cedula").val(data.cedula);
    $("#direccion").val(data.direccion);
    $("#sexo").val(data.sexo);
    $("#nacionalidad").val(data.pais);
    $("#nota").val(data.nota_medica);

  })
}

function cargarPais() {
  $.ajax({
    url: "../controlador/profesor.php?opcion=cargarPais",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      $('#nacionalidad').empty();
      $('#nacionalidad').append("<option disabled selected>Seleccionar Pais</option>");
      $.each(data, function (i, item) {

        $('#nacionalidad').append('<option value="' + data[i].idNacionalidad + '">' + data[i].pais + '</option>');

      });
    }

  });

}

function editar() {
  //No se activará la acción predeterminada del evento
  var DATOS = ($("#formAlumno").serialize());
  console.log('DATOS ENVIADOS CON JS' + DATOS);
  $.ajax({
    url: "../controlador/alumno.php?opcion=editar",
    method: "POST",
    data: DATOS,


    success: function (datos) {
      if(datos.includes("Registrado")){
        $('#divResp').show();
        document.getElementById("divRespE").className = "card-panel green darken-2 white-text lighten-2 full-width";
        document.getElementById('divRespE').innerHTML='<h6>Se edito un estudiante</h6>';
      }else{
        $('#divResp').show();
        document.getElementById("divRespE").className = "card-panel red darken-2 white-text lighten-2";
        document.getElementById('divRespE').innerHTML='<h6>Ocurrió un error al acutalizar los datos</h6>';
      
      }
      tabla.ajax.reload();
      limpiar();
      mostrarform(false);

    }


  });
  //limpiar

}

function cargarGrupo() {
  $.ajax({
    url: "../controlador/alumno.php?opcion=cargarGrupo",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      $('#idgrado').empty();
      $('#idgrado').append("<optionvalue=" + data[0].ID_GRADO + ">Seleccionar Grado</option>");
      $.each(data, function (i, item) {

        $('#idgrado').append('<option value="' + data[i].ID_GRADO + '">' + data[i].NOMBRE_GRADO + ' ' + data[i].ANNIO + '</option>');

      });
    }

  });

}

function cargarGrados() {
  $.ajax({
    url: "../controlador/alumno.php?opcion=cargar",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      if (data == 0) {
        $(".divGrados").hide();
        listar(-9);
      } else {
        $('.cbGrados').empty();
        $('.cbGrados').append('<option value="' + data[0].id_grado + '" >Seleccionar Grado</option>');
        $.each(data, function (i, item) {
          $('.cbGrados').append('<option value="' + data[i].id_grado + '">' + data[i].nombreGrado + '</option>');
        });
        listar($(".cbGrados").val());
      }
    }

  });

}

function cargarEncargado(cedula) {

  $('#modal').empty();
  console.log("ESTOS SON LOS DATOS CARGADOS");
  console.log(cedula + 'cedula');
  $.ajax({
    type: "POST",
    url: "../controlador/alumno.php?opcion=cargarEncargado&cedula=" + cedula,
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function (data) {
      if (data != "") {
        $.each(data, function (i, item) {

          //$('#modal').append("<hr> <table> <tbody> <tr><td>Cédula :</td><td>"+data[i].cedula+"</td> </tr> <tr><td>Nombre: </td><td>"+data[i].nombre+"</td></tr> <tr><td>Télefono: </td><td>"+data[i].telefono+" , "+data[i].telefono_secundario+"</td><tr><td>Dirección: </td><td>"+data[i].direccion+"</td></tr></tbody></table>");
          $('#modal').append("<hr><b>Cédula</b> " + data[i].cedula + "<br><b>Nombre</b> " + data[i].nombre + "<br><b>Télefonos</b> " + data[i].telefono + " , " + data[i].telefono_secundario + "<br><b>Dirección</b> " + data[i].direccion + "<br>");
        });
      } else {
        $('#modal').append("El estudiante seleccionado no tiene un encargado registrado.");
      }
      $('.modal').modal('open');
    }

  });



}


function init() {
  limpiar();
  mostrarform(false);
  mostrarbotones(false);
  cargarGrados();
  listar();

$( "#btnEditar" ).click(function() {
  editar();
});

  if ($('.cbGrados').is(":hidden")) {
    listar(-9);
  }
  $("#cbGrados").on('change', function () {
    valor = $('#cbGrados').val();
    listar(valor);
  });
  cargarPais();
  $("#formAlumno").on("submit", function (e) {
    guardar(e);
  })

}

init();