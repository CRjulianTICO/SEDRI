<?php 
require 'headerDirector.php';
 session_start();
  if(isset($_SESSION["token"])){
    header("Location: http://localhost:8888/SEDRI/controlador/autenticacionTokens.php");
  }
?>

<div id="content">

<div id="tabla">
    <table id="tbAlumno" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cedula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="4">Primer Apellido</th>
          <th data-priority="5">Segundo Apellido</th>
          <th data-priority="6">Sexo</th>
          <th data-priority="7">Nacionalidad</th>
          <th data-priority="3">Grado</th>
          <th data-priority="8">Direccion</th>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<?php require 'footerDirector.php' ?>
<script src="js/alumno.js"></script>
</body>

</html>