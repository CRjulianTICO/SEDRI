<?php 
require 'header.php';
?>

<div id="content">
<div id="divResp">

</div>
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

 
</script>
</body>

</html>