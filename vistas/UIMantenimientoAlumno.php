<?php require 'header.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
<div id="content">
<div id="divResp"></div>
<!-- Modal Structure -->
<div id="modal1" class="modal">
  <div class="modal-content">
    <h4>Encargado</h4>
    <br>
    <div class="container" id="modal">


    </div>
  </div>
  <div class="modal-footer">
    <a href="#!" class="btn red modal-close text-white">Cerrar</a>
  </div>
</div>
<!-- Finaliza Modal -->

  <div class="tabla" id="tabla">
    <div class="container">
      <div class='row'>
        <div class=" divGrados" id="divGrados">
          <select id="cbGrados" class="browser-default cbGrados">
            <option>asdawd</option>
            <option>asdawd232423422</option>
            <option>asdaw234d</option>
          </select>
        </div>
      </div>
    </div>
    <table id="tbAlumno" class="display responsive nowrap tabla" style="width: 100%">
      <thead>
        <th data-priority="1">Cédula</th>
        <th data-priority="2">Nombre</th>
        <th data-priority="3">Primer Apellido</th>
        <th data-priority="4">Segundo Apellido</th>
        <th>Nacionalidad</th>
        <th>Sexo</th>
        <th>Grado</th>
        <th>Año</th>
        <th>Dirección</th>
        <th>Nota Medica</th>
        <th>Opciones</th>
      </thead>
      <tbody>
      </tbody>
    </table>
  </div>

  <div class="container">

    <div id="formulario">
      <form method="POST" id="formAlumno" name="formAlumno">

        <div class='row'>
          <div class='input-field col s6'>
            <input placeholder="Cédula" class='validate' type='text' name='cedula' id='cedula' pattern="^[^0][0-9]{9,10}" title="Solo puede insertar numeros con un minimo de 9 digitos" required />
            <label for='cedula'>Ingresar la Cédula</label>
          </div>


          <div class='row'>
            <div class='input-field col s6'>
              <input placeholder="Nombre" class='validate' type='text' name='nombre' id='nombre' maxlength="25" required pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres" />
              <label for='nombre'>Ingresar el Nombre</label>
            </div>
          </div>

          <div class='row'>
            <div class='input-field col s6'>
              <input placeholder="Primer Apellido" class='validate' type='text' name='apellido1' id='apellido1' maxlength="25" required pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres"  />
              <label for='apellido1'>Ingresar el Primer Apellido</label>
            </div>

            <div class='row'>
              <div class='input-field col s6'>
                <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2' maxlength="25" required pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres"  />
                <label for='apellido2'>Ingresar Segundo Apellido</label>
              </div>
            </div>


            <div class="col s6">
              <select name="sexo" id="sexo" class="browser-default " required>
                <option value="Masculino" disabled selected hidden>Seleccionar el Género</option>
                <option value="Masculino">Masculino</option>
                <option value="Femenino">Femenino</option>
              </select>
            </div>
            <div class="col s6">
              <select name="nacionalidad" id="nacionalidad" class="browser-default" required>
              </select>
            </div>
            <br>



          </div>
          <br>

          <div class="row">
            <div class="col s12 divGrados" id="divGrados">
              <select id="cbGrados" class="browser-default cbGrados" name="grado">
                <option>asdawd</option>
                <option>asdawd232423422</option>
                <option>asdaw234d</option>
              </select>
            </div>

          </div>
          <br>
          <div class="row">

            <div class="input-field col s12">
              <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required pattern="[A-Za-z0-9]{1,100}" title="No se pueden introducir caracteres especiales"></textarea>
              <label for="direccion">Ingresar la Dirección</label>
            </div>
          </div>


          <div class="row">

            <div class="input-field col s12">
              <textarea placeholder="Ingresa datos medicos que pueden ser relevantes" id="nota" class="materialize-textarea validate" name="nota" data-length="100" pattern="[A-Za-z0-9]{0,100}" title="No se pueden introducir caracteres especiales"></textarea>
              <label for="direccion">Nota médica</label>
            </div>
          </div>
          <br>

          <br><br>
          <div class="row">
            <div class="col s4">
              <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnguardar">Guardar
                <i class="material-icons right">done</i><br></button></div>
          </div>
        </div>
        <br>
        <div class="row" id="botones">
        <div class="col s6">
          <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst full-with">Editar<i class="material-icons right">edit</i></button>
        </div>
        <div class="col s6">
          <button class="btn waves-effect waves-light red cancelEst full-with" name="eliminar" type="button" onclick="cancelarform();">Cancelar
            <i class="material-icons right">clear</i><br></button>
        </div>
      </div>
      </form>

      
    </div>

  </div>
</div>
<!-- FINALIZA EL CONTENIDO-->


<?php require 'footer.php' ?>

<script src="js/alumno.js"></script>
<script>$(document).ready(function(){
    $('.modal').modal();
  });</script>

</body>

</html>
