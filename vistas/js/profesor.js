var tabla;

//Función que se ejecuta al inicio

$(document).ready(function() {
  init();
  $("#btnEditar").on("click", editar);
});

function init() {
  limpiar();
  mostrarform(false);
  $('#divResp').hide();
  mostrarbotones(false);
  $("#btnEditar").on("click", editar);
  listar();
  cargarPais();
  cargarGrado();
  listarMaterias();
  $('#divGrado').hide();
  $("#formProfesor").on("submit", function(e) {
    guardar(e);
  })

}
$("#tipo").change(function() {
  var seleccionado = $('#tipo').val();
  if (seleccionado == 1) {
    $('#divMateria').show();
    $('#divGrado').hide();
  } else {
    $('#divMateria').hide();
    $('#divGrado').show();
  }

});

$(document).ready(function() {
  if (window.location.hash === '#mostrarform') {
    mostrarform(true);
  }
})


function mostrarform(bool) {
  if (bool) {
    cargarPais();
    $("#tabla").hide();
    $("#formulario").show();
    $('#divMateria').show();
    $('#divTipo').show();

  } else {
    limpiar();
    mostrarbotones(false);
    $('#divGrado').hide();
    $("#tabla").show();
    $("#formulario").hide();
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
function listar() {
  limpiar();
  tabla = $('#tbProfesor').dataTable({
    "aProcessing": true, //Activamos el procesamiento del datatables
    "aServerSide": true, //Paginación y filtrado realizados por el servidor
    dom: 'Bfrtip', //Definimos los elementos del control de tabla
    "ajax": {
      url: '../controlador/profesor.php?opcion=listar',
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
  $('#divResp').hide();
}
//Función para guardar o editar

function guardar(e) {
  e.preventDefault(); //No se activará la acción predeterminada del evento
  var DATOS = ($("#formProfesor").serialize());
  $.ajax({
    url: "../controlador/profesor.php?opcion=guardar",
    method: "POST",
    data: DATOS,



      success: function(datos)
      {
        if(datos.includes("Registrado")){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se guardo exitosamente!</h5>';
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }
            tabla.ajax.reload();
            limpiar();
            mostrarform(false);
      }

  });
  //limpiar
}

function desactivar(cedula) {
  $.post("../controlador/profesor.php?opcion=desactivar", {
    cedula: cedula
  }, function(e) {
    tabla.ajax.reload();
  });
}

function activar(cedula) {
  $.post("../controlador/profesor.php?opcion=activar", {
    cedula: cedula
  }, function(e) {
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


}

function mostrar(cedula) {
  $.post("../controlador/profesor.php?opcion=mostrar", {
    cedula: cedula
  }, function(data, status) {
    limpiar();
    cargarPais();
    console.log(data);
    mostrarform(true);
    mostrarbotones(true);
    data = JSON.parse(data);
    $("#nombre").val(data.nombre);
    $("#apellido1").val(data.apellido1);
    $("#apellido2").val(data.apellido2);
    $("#cedula").val(data.cedula);
    $("#telefono").val(data.telefono);
    $("#correo").val(data.email);
    $("#direccion").val(data.direccion);
    $("#sexo").val(data.sexo);
    $("#nacionalidad").val(data.pais);
    $('#divGrado').hide();
    $('#divMateria').hide();
    $('#divTipo').hide(); /*SE PUEDE ARREGLAR CON UN APPEND TAL VEZ UNA VISTA NUEVA O CURSOR */
  })
}

function cargarPais() {
  $.ajax({
    url: "../controlador/profesor.php?opcion=cargarPais",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function(data) {
        $("#sexo").empty();
        
        $("#sexo").append("<option value='Masculino' disabled selected hidden>Seleccionar el Género</option><option value='Masculino'>Masculino</option><option value='Femenino'>Femenino</option>");

      $('#nacionalidad').empty();
      $('#nacionalidad').append("<option disabled selected value=" + data[0].idNacionalidad +">Seleccionar Pais</option>");
      $.each(data, function(i, item) {

        $('#nacionalidad').append('<option value="' + data[i].idNacionalidad + '">' + data[i].pais + '</option>');

      });
    }

  });

}

function editar() {
  
  var DATOS = ($("#formProfesor").serialize());
  $.ajax({
    url: "../controlador/profesor.php?opcion=editar",
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
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5><br><h6>No puede crear Profesores que ya se han registrado con el mismo correo electronico o cedula.</h6>';
                
                }
            tabla.ajax.reload();
            limpiar();
            mostrarform(false);


    }


  });
  //limpiar

}

function cargarGrado() {
  $.ajax({
    url: "../controlador/grado.php?opcion=listaSimple",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function(data) {
      $('#idgrado').empty();
      $('#idgrado').append("<option value=" + data[0].ID_GRADO + ">Seleccionar Grado</option>");
      $.each(data, function(i, item) {

        $('#idgrado').append('<option value="' + data[i].ID_GRADO + '">' + data[i].NOMBRE_GRADO + '</option>');

      });
    }

  });

}

function listarMaterias() {
  console.log('Entrando a listar');
  $.ajax({
    url: "../controlador/materia.php?opcion=listarMaterias",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function(data) {
      $('#materia').empty();
      $('#materia').append("<option value="+ data[0].idmateria + ">Seleccionar Materia</option>");
      $.each(data, function(i, item) {

        $('#materia').append('<option value="' + data[i].idmateria + '">' + data[i].nombre + '</option>');

      });
    }

  });

}


init();
