<?php require 'header.php'?>

<div class="">
  <form method="POST" id="formAlumno" name="formAlumno">
    <input type="text" name="cedula" id="cedula"  placeholder="cedula" style="display:block;">
    <input type="text" name="nombre" id="nombre" placeholder="nombre" style="display:block;">
    <input type="text" name="apellido1" id="apellido1" placeholder="apellido" style="display:block;">
    <input type="text" name="apellido2" id="apellido2" placeholder="apellido2" style="display:block;">
    <select name="sexo" id="sexo">
      <option value="Masculino">Masculino</option>
      <option value="Femenino">Femenino</option>

    </select>
    <textarea name="direccion" id="direccion" rows="8" cols="80" placeholder="direccion" style="display:block;"></textarea>
    
    <select name="nacionalidad" id="nacionalidad">
    </select>
    <button type="submit" name="Guardar" class="btn-guarda">Guardar</button>


  </form>
 <button name="#editar"  onclick="editar();" class="btn-edita">Modificar</button>

</div>

<table id="tbAlumno" class="display responsive nowrap" style="width: 100%">
  <thead>
    <th>Opciones</th>
    <th>Cedula</th>
    <th data-priority="1">Nombre</th>
    <th data-priority="2">Primer Apellido</th>
    <th>Segundo Apellido</th>
    <th>Sexo</th>
    <th>Direccion</th>
    <th>Nacionalidad</th>
    <th>Estado</th>
  </thead>
  <tbody>
  </tbody>
</table>
<?php require 'footer.php' ?>
