<?php 
require 'header.php';
?>

<div id="content">
<div class="container">
<div class='row'>
    <div class="col s6 offset-s7" id="divGrados" >
        <select id="cbGrados" class="cbGrados browser-default"><option>asdawd</option><option>asdawd232423422</option><option>asdaw234d</option></select>
    </div>
</div>
</div>

<div class="card-panel blue darken-2 white-text lighten-2" data-error="credeciales malas" id="divResp"></div>
<div id="tabla">
    <table id="tblAsistenciaActual" class="display responsive nowrap tabla highlight" style="width: 100%">
    
        <thead>
          <th >Cédula</th>
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


 
</script>
</body>

</html>