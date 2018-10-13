var tabla;
$(document).ready(function() {
  init();
  $( "#btnEditar" ).on( "click", editar );
});


function init(){
    
  limpiar();
  mostrarform(false);
  mostrarbotones(false);

  $( "#btnEditar" ).on( "click", editar );
  listar();
    cargarPais();
    cargarGrado();
   $("#formEncargado").on("submit",function(e)
   {
    guardarEncarda(e);
   })

   $("#formEncargado").on("submit",function(e)
   {
    guardar(e);
   })

 
      

  }

  $(document).ready(function (){
    if (window.location.hash === '#mostrarform') {mostrarform(true);}
})




function mostrarform(bool)
{
if (bool)
{
  cargarPais();
  $("#tabla").hide();
  $("#formulario").show();
}
else
{
  limpiar();
  mostrarbotones(false);
  $("#tabla").show();
  $("#formulario").hide();
}
}

function mostrarbotones(bool)
{
if (bool)
{
  $('#botones').show();
  $('#btnguardar').hide();
}
else
{
  $('#btnguardar').show();
  $('#botones').hide();
}
}
//Función cancelarform
function cancelarform()
{
  limpiar();
  mostrarform(false);
}

//Función Listar
function listar()
{
  limpiar();
  tabla=$('#tbEncargado').dataTable(
  {
    "aProcessing": true,//Activamos el procesamiento del datatables
      "aServerSide": true,//Paginación y filtrado realizados por el servidor
      dom: 'Bfrtip',//Definimos los elementos del control de tabla
       "ajax":
        {
          url: '../controlador/encargado.php?opcion=listar',
          type : "get",
          dataType : "json",
          error: function(e){
            console.log(e.responseText);
          }
        },
    "bDestroy": true,
    "iDisplayLength": 10,
      "order": [[ 0, "desc" ]]//Ordenar (columna,orden)
  }).DataTable();
}
//Función para guardar o editar

function guardar(e)
{
  console.log('ENTRANDO 2...');
  e.preventDefault(); //No se activará la acción predeterminada del evento
  var DATOS = ($("#formEncargado").serialize());
  console.log('Datos de formulario'+DATOS);
  $.ajax({
    url: "../controlador/encargado.php?opcion=guardar",
      method: "POST",
      data: DATOS,


      success: function(datos)
      {
            tabla.ajax.reload();
            limpiar();
            mostrarform(false);
      }

  });
  //limpiar
}

function desactivar(cedula)
{
        $.post("../controlador/profesor.php?opcion=desactivar", {cedula : cedula}, function(e){
            tabla.ajax.reload();
        });
}
function activar(cedula)
{
        $.post("../controlador/profesor.php?opcion=activar", {cedula : cedula}, function(e){
            tabla.ajax.reload();
        });
}

function limpiar(){

  $("#nombre").val("");
  $("#apellido1").val("");
  $("#apellido2").val("");
  $("#cedula").val("");
  $("#direccion").val("");
  $("#telefono").val("");
  $("#correo").val("");
  $("#sexo").val("");
  $("#nacionalidad").text("");
  $("#nota").text("");



}
function mostrar(cedula)
{
$.post("../controlador/encargado.php?opcion=mostrar",{cedula : cedula}, function(data, status)
{
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
  $("#direccion").val(data.direccion);
  $("#sexo").val(data.sexo);
  $("#nacionalidad").val(data.pais);
  $("#nota").val(data.nota_medica);

})
}
function cargarPais(){
  $.ajax({
      url: "../controlador/profesor.php?opcion=cargarPais",
      method: "POST",
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      success: function(data)
      {
          $('#nacionalidad').empty();
          $('#nacionalidad').append("<option disabled selected>Seleccionar Pais</option>");
          $.each(data,function(i,item){

              $('#nacionalidad').append('<option value="'+data[i].idNacionalidad+'">'+data[i].pais+'</option>');

          });
      }

  });

}

function editar()
{
   //No se activará la acción predeterminada del evento
  var DATOS = ($("#formEncargado").serialize());
  console.log('DATOS ENVIADOS CON JS'+DATOS);
  $.ajax({
      url: "../controlador/encargado.php?opcion=editar",
      method: "POST",
      data: DATOS,


      success: function(datos)
      {
            tabla.ajax.reload();
            limpiar();
            mostrarform(false);

      }


  });
  //limpiar

}

function cargarGrupo(){
  $.ajax({
      url: "../controlador/encargado.php?opcion=cargarGrupo",
      method: "POST",
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      success: function(data)
      {
          $('#idgrado').empty();
          $('#idgrado').append("<option>Seleccionar Grado</option>");
          $.each(data,function(i,item){

              $('#idgrado').append('<option value="'+data[i].ID_GRADO+'">'+data[i].NOMBRE_GRADO+' '+data[i].ANNIO+'</option>');

          });
      }

  });

}

function cargarGrado(){
  $.ajax({
      url: "../controlador/grado.php?opcion=listaSimple",
      method: "POST",
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      success: function(data)
      {
          $('#idgrado').empty();
          $('#idgrado').append("<option>Seleccionar Grado</option>");
          $.each(data,function(i,item){

              $('#idgrado').append('<option value="'+data[i].ID_GRADO+'">'+data[i].NOMBRE_GRADO+' '+data[i].ANNIO+'</option>');

          });
      }

  });

}



init();
