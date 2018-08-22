var tabla;


function mostrarFormularioMateria(estado){
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

function cancelarFormulario(){
    mostrarFormularioMateria(false);
    mostrarBotones(false);
}


function limpiar(){
    $('#idmateria').val('');
    $('#nombreMateria').val('');
}


function listar(){
    tabla = $('#tblMateria').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/materia.php?opcion=listar',
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
    var DATOS = ($("#formMateria").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/materia.php?opcion=guardar",
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
    $.post("../controlador/materia.php?opcion=mostrar",{idmateria : id}, function(data, status){
        limpiar();
        mostrarFormularioMateria(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#idmateria').val(data.idmateria);
        $('#nombreMateria').val(data.nombre);
    })
}

function editar(){
    var DATOS = ($("#formMateria").serialize());
    $.ajax({
        url: "../controlador/materia.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
              tabla.ajax.reload();
              limpiar();
              mostrarFormularioMateria(false);
              alert("SE ACTUALIZO SATISFACTORIAMENTE");

        }

    });
    
}

 function desactivar(id){
          $.post("../controlador/materia.php?opcion=desactivar", {idmateria : id}, function(e){
              tabla.ajax.reload();
          });
}

document.getElementById('btnEditar').onclick = function(){
    editar();
};

$(document).ready(function (){
    if (window.location.hash === '#mostrarFormularioMateria') {mostrarFormularioMateria(true);}
})

function INIT(){
    limpiar();
  	mostrarFormularioMateria(false);
    mostrarBotones(false);
    listar();

     $("#formMateria").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();