var tabla = {};

var date;

function listar(fecha){
    tabla = $('#tblAsistencia').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/asistencia.php?opcion=mostrar&fecha='+fecha,
  					type : "get",
                      dataType : "json",
  					error: function(e){
                          
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
          "order": [[ 1, "asc" ]]
    }).DataTable();
    tabla.columns.adjust().draw();
}

/*

function mostrar(fecha){
  console.log('Variable recibida->'+fecha+'<-');
    $.post("../controlador/asistencia.php?opcion=mostrar",{fecha : fecha}, function(data, status){
       data = JSON.parse(data);
       
        console.log(data.data);
        tabla = $('#tblAsistencia').DataTable();
        //tablae.ajax.reload();
        tabla.clear();
        tabla.rows.add(data).draw(); // Add new data
        tabla.columns.adjust().draw(); // Redraw the DataTable

        
    });
}
*/

document.getElementById('btnBuscar').onclick = function(){
  // mostrar($('.datepicker').val());
    //$(".ced").prop("disabled", true);
    date=$('.datepicker').val();
    listar(date);
};



function justificar(cedula){
    date=$('.datepicker').val();
    nota = $("#nota"+cedula).val();
    console.log(nota);
    console.log(cedula);
    console.log(date);
     $.post("../controlador/asistencia.php?opcion=editar", {cedula:cedula,nota:nota,dia:date,justificacion:1}, function(e){
              tabla.ajax.reload();

          });


}





function INIT(){
     $('#divResp').hide();
    listar($('.datepicker').val());
     $(".dropdown-content>li>a").css("color", "#000000");
}



INIT();
