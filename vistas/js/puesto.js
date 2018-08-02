var tabla;


function mostrarFormulario(estado){
    if(estado){
        $('#tabla').hide();
        $('#formulario').show();
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
}


function limpiar(){
    $('#idEmpleado').val('');
    $('#nombreEmpleado').val('');
    $('#descripcionEmpleado').val('');
}


function listar(){
    tabla = $('#tblEmpleado').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/Empleado.php?opcion=listar',
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

function guardar(e){
    e.preventDefault();
    var DATOS = ($("#formEmpleado").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/Empleado.php?opcion=guardar",
  	    method: "POST",
  	    data: DATOS,

  	    success: function(datos)
  	    {
                tabla.ajax.reload();
                alert("SE GUARDO SATISFACTORIAMENTE");
  	    }

      });
      limpiar();
}

function mostrar(id){
    $.post("../controlador/Empleado.php?opcion=mostrar",{idEmpleado : id}, function(data, status){
        limpiar();
        mostrarFormulario(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#idEmpleado').val(data.idEmpleado);
        $('#nombreEmpleado').val(data.nombreEmpleado);
        $('#descripcionEmpleado').val(data.descrpcionEmpleado);
    })
}

function editar(){
    var DATOS = ($("#formEmpleado").serialize());
    $.ajax({
        url: "../controlador/Empleado.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
              tabla.ajax.reload();
              limpiar();
              mostrarFormulario(true);

        }

    });

}

document.getElementById('btnEditar').onclick = function(){
    editar();
};

function INIT(){
    limpiar();
  	mostrarFormulario(false);
    mostrarBotones(false);
    listar();

     $("#formEmpleado").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();
