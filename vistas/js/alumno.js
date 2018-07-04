  var tabla;

  //Función que se ejecuta al inicio
  function init(){
  	mostrarform(false);
  	listar();
     $("#editar").click,function(e)
      {
      editar(e);
      }
      cargarPais();

     $("#formAlumno").on("submit",function(e)
  	 {
  		guardar(e);
  	 })

    }

function mostrarform(bool)
{
  if (bool)
  {
    $("#tabla").hide();
    $("#formulario").show();
  }
  else
  {
    $("#tabla").show();
    $("#formulario").hide();
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
  	tabla=$('#tbAlumno').dataTable(
  	{
  		"aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  	    buttons: [
  		            'excelHtml5',
  		            'pdf'
  		        ],
  		"ajax":
  				{
  					url: '../controlador/alumno.php?opcion=listar',
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
  	e.preventDefault(); //No se activará la acción predeterminada del evento
    var DATOS = ($("#formAlumno").serialize());
  	$.ajax({
  		url: "../controlador/alumno.php?opcion=guardar",
  	    method: "POST",
  	    data: DATOS,


  	    success: function(datos)
  	    {
  	          tabla.ajax.reload();
  	    }

  	});
  	//limpiar
  }

 function desactivar(cedula)
{
          $.post("../controlador/alumno.php?opcion=desactivar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}
function activar(cedula)
{
          $.post("../controlador/alumno.php?opcion=activar", {cedula : cedula}, function(e){
              tabla.ajax.reload();
          });
}
function mostrar(cedula)
{
  $.post("../controlador/alumno.php?opcion=mostrar",{cedula : cedula}, function(data, status)
  {
    data = JSON.parse(data);
    $("#nombre").val(data.nombre);
    $("#apellido1").val(data.apellido1);
    $("#apellido2").val(data.apellido2);
    $("#cedula").val(data.cedula);
    $("#direccion").val(data.direccion);
    $("#sexo").val(data.sexo);
    $("#nacionalidad").text(data.pais);


  })
}
function cargarPais(){
    $.ajax({
        url: "../controlador/alumno.php?opcion=cargarPais",
        method: "POST",
        dataType : "json",
        contentType: "application/json; charset=utf-8",
        success: function(data)
        {
            $('#nacionalidad').empty();
            $('#nacionalidad').append("<option>Seleccionar Pais</option>");
            $.each(data,function(i,item){

                $('#nacionalidad').append('<option value="'+data[i].idNacionalidad+'">'+data[i].pais+'</option>');

            });
        }

    });

}

function editar()
  {
     //No se activará la acción predeterminada del evento
    var DATOS = ($("#formAlumno").serialize());
    $.ajax({
        url: "../controlador/alumno.php?opcion=editar",
        method: "POST",
        data: DATOS,


        success: function(datos)
        {
              tabla.ajax.reload();
        }

    });
    //limpiar
  }

  init();
