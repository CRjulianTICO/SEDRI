
function init() {
 cargarMenu();
 $('#divMenu').hide();

}
function cargarMenu() {
  $.ajax({
    url: "../controlador/grado.php?opcion=listaSimple",
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function(data) {
      $('#menuGrupos').empty();
      $.each(data, function(i, item) {
        $('#menuGrupos').append('<a class="waves-effect" onclick="cambiarGrupo('+data[i].ID_GRADO+')">'+data[i].NOMBRE_GRADO + ' ' + data[i].ANNIO+'<i class="material-icons right grey-text">check</i></a>');
      });
    }

  });
$('#divMenu').show();
}
function cambiarGrupo(num){
  $.ajax({
    type: 'POST',
    url: '../controlador/grado.php?opcion=cambiarGrupo',
    data: {
        'idgrado': num
    },
    success: function(msg){
    }
});
}

init();
