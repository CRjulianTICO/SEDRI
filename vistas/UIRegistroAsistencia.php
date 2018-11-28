<?php 
require 'header.php';
?>

<div id="content">
<div class="card-panel blue darken-2 white-text lighten-2" data-error="credeciales malas" id="divResp"></div>

<div class="row">
            <div class="input-field col s12">
                <input id="fecha" type="text"  name="idate" class="datepicker" >
                <label for="fecha">Fecha:</label>
            </div>
            <div class="col s6 " id="divGrados" >
                <select id="cbGrados" class="cbGrados browser-default"><option>asdawd</option><option>asdawd232423422</option><option>asdaw234d</option></select>
            </div>
            <div class="input-field col s12">
                <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnBuscar">Buscar
                    <i class="material-icons right">search</i>
                    <br>
                </button>
            </div>
</div>

<div id="tabla">
    <table id="tblAsistencia" class="display responsive nowrap tabla highlight" style="width: 100%">
    
        <thead>
          <th data-priority="1">Cédula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="3">Apellidos</th>
          <th >Grado</th>
          <th data-priority="4">Estado</th>
          <th data-priority="5">Nota</th>
          <th >Fecha</th>
          <th >Justificación</th>
        </thead>
        <tbody>
        </tbody>
       
    
    </table>

</div>



<?php require 'footer.php' ?>
<script src="js/registroAsistencia.js"></script>

<script>
/*
  document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.datepicker');
    var instances = M.Datepicker.init(elems, {
        format:'yyyy/mm/dd'
    });
    instances.open();
  });
*/

 $('.datepicker').pickadate({
  selectMonths: true,// Creates a dropdown to control month
  selectYears: 15, // Creates a dropdown of 15 years to control year,
  format: 'yyyy/mm/dd'
});

 
</script>
</body>

</html>