var tabla;
var count ;
var idgrado;
var trimestre;


document.getElementById('btnGuardar').onclick = function(){
    guardar();
    $(".ced").prop("disabled", true);
};

function listar(idGrado,trimestre){
    $(".ced").prop("disabled", true);
    tabla = $('#tblNotas').dataTable({
        "aProcessing": true,//Activamos el procesamiento del datatables
  	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
  	    dom: 'Bfrtip',//Definimos los elementos del control de tabla
  		"ajax":
  				{
  					url: '../controlador/notas.php?opcion=listar&grados='+idGrado+'&trimestres='+trimestre,
  					type : "get",
  					dataType : "json",
  					error: function(e){
                          
  						console.log(e.responseText);
  					}
  				},
  		"bDestroy": true,
  		"iDisplayLength": 10,
          "order": [[ 1, "asc" ]],//Ordenar (columna,orden),
        
    }).DataTable();

}

function cargarGrados(){
  $.ajax({
         url: "../controlador/notas.php?opcion=cargar",
         method: "POST",
         dataType : "json",
         contentType: "application/json; charset=utf-8",
         success: function(data)
         {
            $('.cbGrados').empty();
            $('.cbGrados').append('<option value="'+data[0].id_grado+'" >Seleccionar Grado/Materia</option>');
            $.each(data,function(i,item){
                $('.cbGrados').append('<option value="'+data[i].id_grado+'">'+data[i].nombreGrado+'</option>');
            });
            
            listar($(".cbGrados").val(),$("#cbTrimestre").val());
         }
         
         

     });

}




function guardar(){
    //e.preventDefault();
    count = $('#tblNotas tbody tr').length; 
    
     $(".ced").prop("disabled", false);
     
for (index = 1; index <= count; index++) {
 var DATOS = ($("#frm"+index).serialize());
 //DATOS+$(".cbGrados").val();

 
    console.log("->"+DATOS+"<-");
  	$.ajax({
  		url: "../controlador/notas.php?opcion=guardar&grados="+idgrado+"&trimestres="+trimestre,
        type: "POST",
          data: DATOS,

  	    success: function(datos)
  	    {
                tabla.ajax.reload();
              //  limpiar();
        //      mostrarFormulario(false);
              if(datos == 'Registrado'){
                  $('#divResp').show();
                  document.getElementById("divResp").className = "card-panel green darken-2 white-text lighten-2";
                  document.getElementById('divResp').innerHTML='<h5>Se registro exitosamente!</h5><br><h6>Si desea modificar alguna asistencia debe ir al Registro dentro de Asistencia.</h6>';
               
              }else if (datos == 'Error'){
                  $('#divResp').show();
                  
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2 flow-text";
                  document.getElementById('divResp').innerHTML='<h5>Se produjo un error. Vuelva a Intentarlo.</h5>';
              }else{
                  $('#divResp').show();
                  
                  document.getElementById("divResp").className = "card-panel red darken-2 white-text lighten-2 flow-text";
                  document.getElementById('divResp').innerHTML='<h5>Llene los campos solicitados.</h5>';
              }
  	    }

      });    
    
}

         
}



function INIT(){
       cargarGrados();
       trimestre = $("#cbTrimestre").val();
       listar($("#cbGrados").val(),$("#cbTrimestre").val());
       
     idgrado = $('#cbGrados').val();
     $('#divResp').hide();
     $('#divGrados').show();

     if($('.cbGrados').is(":hidden") ){
    listar(-9);
  }
    $("#cbGrados").on('change', function() {
        $('#divResp').hide();
        valor = $('#cbGrados').val();
        listar(valor,trimestre);
        idgrado = valor;
        });

        $("#cbTrimestre").on('change', function() {
        $('#divResp').hide();
        trimestre = $("#cbTrimestre").val();
        valor = $('#cbGrados').val();
        listar(valor,trimestre);
        idgrado = valor;
        });

     
  
    
     $(".dropdown-content>li>a").css("color", "#000000");

}



INIT();