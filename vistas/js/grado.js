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
    $('#idgrado').val('');
    $('#nombreGrado').val('');
}


function listar(){
    tabla = $('#tblGrado').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/grado.php?opcion=listar',
  					type : "get",
  					dataType : "json",
  					error: function(e){
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
  	    "order": [[ 0, "asc" ]]//Ordenar (columna,orden)
    }).DataTable();
}

function guardar(e){
    e.preventDefault();
    var DATOS = ($("#formGrado").serialize());
    console.log(DATOS);
  	$.ajax({
  		url: "../controlador/grado.php?opcion=guardar",
  	    method: "POST",
  	    data: DATOS,

  	    success: function(datos)
  	    {
              if(datos=="Registrado"){
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
              mostrarFormulario(false);
  	    }

      });
      limpiar();
}

function mostrar(id){
  console.log('Variable recibida'+id);
    $.post("../controlador/grado.php?opcion=mostrar",{idgrado : id}, function(data, status){
        limpiar();
        mostrarFormulario(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#idgrado').val(data.idgrado);
        $('#nombreGrado').val(data.nombreGrado);
    })
}

function editar(){
    var DATOS = ($("#formGrado").serialize());
    $.ajax({
        url: "../controlador/grado.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
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

     $("#formGrado").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();
