var tabla = {};
var idgrado;
var date;

function listar(fecha,idGrado){
    tabla = $('#tblAsistencia').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/asistencia.php?opcion=mostrar&fecha='+fecha+'&grados='+idGrado,
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
function cargarGrados(){
  $.ajax({
         url: "../controlador/asistencia.php?opcion=cargar",
         method: "POST",
         dataType : "json",
         contentType: "application/json; charset=utf-8",
         success: function(data)
         {
           if(data==0){
            $("#divGrados").hide();
             listar(-9);
            }else{
            $('.cbGrados').empty();
             $('.cbGrados').append('<option value="'+data[0].id_grado+'" >Seleccionar Grado</option>');
             $.each(data,function(i,item){
                 $('.cbGrados').append('<option value="'+data[i].id_grado+'">'+data[i].nombreGrado+'</option>');
             });
             listar($(".cbGrados").val());
            }
         }
         

     });

}

document.getElementById('btnBuscar').onclick = function(){
  // mostrar($('.datepicker').val());
    //$(".ced").prop("disabled", true);
    date=$('.datepicker').val();
    idGrado = $('#cbGrados').val();
    listar(date,idGrado);
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
    cargarGrados();
       idgrado = $('#cbGrados').val();
     $('#divResp').hide();
    listar($('.datepicker').val());
     $(".dropdown-content>li>a").css("color", "#000000");

     if($('.cbGrados').is(":hidden") ){
    listar(-9);
  }
    $("#cbGrados").on('change', function() {
        $('#divResp').hide();
        valor = $('#cbGrados').val();
        //listar(valor);
        idgrado = valor;
        });

}



INIT();
