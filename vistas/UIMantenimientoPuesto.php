<?php require 'headerDirector.php' ?>

<div id="content">


  <div id="tabla">

    <table id="tblPuesto" class="display responsive nowrap tabla" style="width: 100%">
      <thead>
        <th data-priority="1">Código</th>
        <th data-priority="2">Puesto</th>
        <th data-priority="3">Descripcion</th>
        <th data-priority="4">Editar</th>
      </thead>
      <tbody>
      </tbody>
    </table>
  </div>

  <div class="container">
    <div id="formulario">
      <form method="POST" id="formPuesto" name="formPuesto">

        <div class="row">
          <div class="input-field col s6">
            <label for="idPuesto">Código del Puesto</label>
            <input placeholder="Codigo" class="validate" type="text" name="idPuesto" id="idPuesto" readonly="true" />

          </div>
        </div>

        <div class="row">
          <div class="input-field col s6">

            <input placeholder="Nombre" class="validate" type="text" name="nombrePuesto" id="nombrePuesto" required maxlength="25" pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres"/>
            <label for="nombrePuesto">Ingresar el Nombre del Puesto</label>

          </div>
        </div>

        <div class="row">
          <div class="input-field col s12">

            <textarea placeholder="Descripcion..." id="descripcionPuesto" name="descripcionPuesto" class="materialize-textarea" class="validate" data-length="100" required pattern="[A-Za-z0-9]{1,100}" title="No se pueden introducir caracteres especiales"></textarea>
            <label for="descripcionPuesto">Ingresar la Descripción del Puesto</label>
          </div>
        </div>
        <div class="row">
          <div class="col s4">
            <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnGuardar">Guardar
              <i class="material-icons right">done</i>
              <br>
            </button>
          </div>

          <div class="col s4">
            <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst">Editar<i class="material-icons right">edit</i></button>
          </div>
          <div class="col s4">
            <button class="btn waves-effect waves-light red cancelEst" name="eliminar" id="btnCancelar" type="button" onclick="cancelarForm();">Cancelar
              <i class="material-icons right">clear</i>
            </button>
          </div>
          <br>
      </form>
    </div>
  </div>

</div>



<?php require 'footerDirector.php' ?>
<script src="js/puesto.js"></script>
</body>

</html>
