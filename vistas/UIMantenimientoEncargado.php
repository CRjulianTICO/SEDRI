<?php require 'header.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">
 <h5 class="center-align"><?php echo( $grupo);?></h5>
 <hr>

   <div class="tabla" id="tabla">
        <table id="tbEncargado" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cedula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="3">Primer Apellido</th>
          <th data-priority="4">Segundo Apellido</th>
          <th data-priority="5">Telefono</th>
          <th data-priority="6">Telefono Secundario</th>
          <th>Direccion</th>
          <th>Sexo</th>
          <th>Nacionalidad</th>
          <th>Estudiante</th>
          <th data-priority="7">Estudiante</th>
          <th>Parentezco</th>
          <th>Opciones</th>
        </thead>
        <tbody>
        </tbody>
      </table>
      </div>

    <h6>Datos del alumno</h6>
    <hr>
    <br>
    <form method="POST" id="formEncargado" name="formEncargado">
<div class="row">

<div class='input-field col s6'>
  <input placeholder="Cédula" class='validate' type='text' name='cedulaE' id='cedulaE' min="1000000" max="9999999" disabled />
          <label for='cedulaE'>Cédula estudiante</label>
        </div>


        <div class='row'><div class='input-field col s6'>
  <input placeholder="Nombre" class='validate' type='text' name='nombreE' id='nombreE' maxlength="30" disabled />
          <label for='nombreE'>Nombre</label>
        </div>
<br> 


<h6>Agregar un encargado</h6>
    <hr>
    <br>

</div>
<div class='row'>
<div class='input-field col s6'>
  <input placeholder="Cédula" class='validate' type='text' name='cedula' id='cedula' min="1000000" max="9999999" required />
          <label for='cedula'>Ingresa la Cédula</label>
        </div>


        <div class='row'><div class='input-field col s6'>
  <input placeholder="Nombre" class='validate' type='text' name='nombre' id='nombre' maxlength="30" required />
          <label for='nombre'>Ingresa el Nombre</label>
        </div>
        </div>

        <div class='row'>
        <div class='input-field col s6'>
  <input placeholder="Primer Apellido" class='validate' type='text' name='apellido1' id='apellido1' maxlength="30" required />
          <label for='apellido1'>Ingresar el Primer Apellido</label>
        </div>

 <div class='row'><div class='input-field col s6'>
  <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2' maxlength="30" required />
          <label for='apellido2'>Ingresar Segundo Apellido</label>
        </div>
        </div>

         <div class='row'>
        <div class='input-field col s6'>
  <input placeholder="Numero de Telefono" class='validate' type='text' name='telefono' id='telefono' maxlength="30" required />
          <label for='telefono'>Ingresar Numero de Telefono</label>
        </div>

 <div class='row'><div class='input-field col s6'>
  <input placeholder="Numero de telefono secundario" class='validate' type='text' name='tel_secundario' id='tel_secundario' maxlength="30" required />
          <label for='tel_secundario'>Secundario</label>
        </div>
        </div>
<div class="row">
  <div class="col s6">
    <select  name="sexo" id="sexo" class="browser-default " required>
    <option value="" disabled selected hidden>Seleccionar el Género</option>
    <option value="Masculino">Masculino</option>
    <option value="Femenino">Femenino</option>
    </select>
  </div>
  <div class="col s6">
    <select  name="nacionalidad" id="nacionalidad"   class="browser-default "  required>
    </select>
  </div>

</div>
<br>
<div class="row">

    <div class="input-field col s12">
      <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required></textarea>
      <label for="direccion">Ingresa la Dirección</label>
    </div>
  </div>
  <br>
</div>
<div class="row">
<div class="col s6">
<button class="btn waves-effect waves-light green full-with" type="submit" name="Guardar" id="btnguardar">Guardar
<i class="material-icons right">done</i><br></button>
</div>
<div class="col s6">
<a class="btn waves-effect waves-light red full-with modal-close"  name="cancelar" href="#!" id="btncancelar">Cancelar
<i class="material-icons right" >cancel</i><br></a>
</div>
</div>
<br>
</form>


<?php require 'footer.php' ?>

<script src="js/encargado.js"></script>

</body>

</html>