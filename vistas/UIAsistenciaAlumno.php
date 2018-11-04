<?php 
require 'header.php';
?>

<div id="content">
<div class="container">
<div class='row'>
    <div class="col s6 offset-s9" id="divGrados">
        <span class="flow-text">6-columns (offset-by-6)</span><select id="cbGrados"><option>asdawd</option><option>asdawd232423422</option><option>asdaw234d</option></select>
    </div>
</div>
</div>

<div class="card-panel blue darken-2 white-text lighten-2" data-error="credeciales malas" id="divResp"></div>
<div id="tabla">
    <table id="tblAsistenciaActual" class="display responsive nowrap tabla highlight" style="width: 100%">
    
        <thead>
          <th >Cedula</th>
          <th >Nombre</th>
          <th >Primer Apellido</th>
          <th >Segundo Apellido</th>
          <th >Grado</th>
          <th >Presente/Ausente</th>
          <th >Nota</th>
        </thead>
        <tbody>
        </tbody>
       
    
    </table>
     
<button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnGuardar">Guardar
                        <i class="material-icons right">done</i>
                        <br>
                    </button>
</div>



<?php require 'footer.php' ?>
<script src="js/asistencia.js"></script>

<script>

  $(document).ready(function() {
    $('select').material_select();
 });
 $(document).ready(function() {
    $('#estado').material_select();
 });
 $(document).ready(function() {
    $('#cbGrados').material_select();
 });

 
</script>
</body>

</html>