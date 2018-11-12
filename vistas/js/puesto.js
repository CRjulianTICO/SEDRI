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
    $('#idPuesto').val('');
    $('#nombrePuesto').val('');
    $('#descripcionPuesto').val('');
}


function listar(){
    tabla = $('#tblPuesto').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/puesto.php?opcion=listar',
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
    $('#divResp').hide();
}

function guardar(e){
    e.preventDefault(); 
    var DATOS = ($("#formPuesto").serialize());
  	$.ajax({
  		url: "../controlador/puesto.php?opcion=guardar",
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
}

function mostrar(id){
    $.post("../controlador/puesto.php?opcion=mostrar",{idPuesto : id}, function(data, status){
        limpiar();
        mostrarFormulario(true);
        mostrarBotones(true);
        data = JSON.parse(data);
        console.log(data);
        $('#idPuesto').val(data.idPuesto);
        $('#nombrePuesto').val(data.nombrePuesto);
        $('#descripcionPuesto').val(data.descrpcionPuesto);
    })
}

function editar(){
    var DATOS = ($("#formPuesto").serialize());
    $.ajax({
        url: "../controlador/puesto.php?opcion=editar",
        method: "POST",
        data: DATOS,

        success: function(datos)
        {
              tabla.ajax.reload();
              if(datos=="Registrado"){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se actualizo exitosamente!</h5>';
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }
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
    $('#divResp').hide();
    listar();

     $("#formPuesto").on("submit",function(e){
  		guardar(e);
  	 })
}

INIT();