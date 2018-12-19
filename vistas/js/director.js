var tabla;


function listar(){
    tabla = $('#tbAlumno').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/alumno.php?opcion=todo',
  					type : "post",
  					dataType : "json",
  					error: function(e){
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
  	    "order": [[ 1, "asc" ]]//Ordenar (columna,orden)
    }).DataTable();
        $('#divResp').hide();

}

function INIT(){

    listar();

}

INIT();