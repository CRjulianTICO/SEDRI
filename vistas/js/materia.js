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
    $('#divResp').hide();
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
                if(datos=="Registrado"){
                    $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se registro exitosamente!</h5>';
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }
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

            if(datos=="Registrado"){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se actualizo exitosamente!</h5>';
                }else{
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Ocurrio un Error!</h5>';
                
                }
              tabla.ajax.reload();
              
              limpiar();
              mostrarFormularioMateria(false);
              

        }

    });
    
}

function cargarTipos(){
  $.ajax({
      url: "../controlador/materia.php?opcion=tipoMaterias",
      method: "POST",
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      success: function(data)
      {
          $('#tipoMateria').empty();
          $('#tipoMateria').append("<option disabled selected value='"+data[0].idTipo+"'>Seleccionar Tipo de Materia</option>");
          $.each(data,function(i,item){

              $('#tipoMateria').append('<option value="'+data[i].idTipo+'">'+data[i].tipo+'</option>');

          });
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
    $('#divResp').hide();

     $("#formMateria").on("submit",function(e){
  		guardar(e);
       })
       
    cargarTipos();
}

INIT();