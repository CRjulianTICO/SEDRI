<?php require 'header.php' ?>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
<div id="content">
  <div id="divResp"></div>
  <h5 class="center-align">
    <?php echo( $grupo);?>
  </h5>


  <div class="tabla" id="tabla">
    <table id="tbEncargado" class="display responsive nowrap tabla" style="width: 100%">
      <thead>
        <th data-priority="1">Cédula</th>
        <th data-priority="2">Nombre</th>
        <th data-priority="3">Primer Apellido</th>
        <th data-priority="4">Segundo Apellido</th>
        <th data-priority="5">Telefono</th>
        <th data-priority="6">Telefono Secundario</th>
        <th>Dirección</th>
        <th>Sexo</th>
        <th>Nacionalidad</th>
        <th>Opciones</th>
      </thead>
      <tbody>
      </tbody>
    </table>
  </div>

  <div id="formulario">

    <h6>Agregar un encargado</h6>

    <div class="divider"></div>
    <br>
    <form method="post" id="formEncargado">
      <div class='row'>
        <div class='input-field col s6'>
          <input placeholder="Cédula" class='validate' type='text' name='cedula' id='cedula' maxlength="10" required pattern="^[^0\-][0-9+]{8,9}" title="Solo puede insertar numeros y una longitud minima de 9 digitos" />
          <label for='cedula'>Ingresar la Cédula</label>
        </div>


        <div class='row'>
          <div class='input-field col s6'>
            <input placeholder="Nombre" class='validate' type='text' name='nombre' id='nombre' minlength="3" maxlength="20" pattern="[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s1-9]+" title="Solo puede insertar un maximo de 20 caracteres y un minimo de 3 letras" required  />
            <label for='nombre'>Ingresar el Nombre</label>
          </div>
        </div>

        <div class='row'>
          <div class='input-field col s6'>
            <input placeholder="Primer Apellido" class='validate' type='text' name='apellido1' id='apellido1' 
              minlength="3" maxlength="20" pattern="[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s1-9]+" title="Solo puede insertar un maximo de 20 caracteres y un minimo de 3 letras" required />
            <label for='apellido1'>Ingresar el Primer Apellido</label>
          </div>

          <div class='row'>
            <div class='input-field col s6'>
              <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2'
               minlength="3" maxlength="20" pattern="[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s1-9]+" title="Solo puede insertar un maximo de 20 caracteres y un minimo de 3 letras" required />
              <label for='apellido2'>Ingresar Segundo Apellido</label>
            </div>
          </div>

          <div class='row'>
            <div class='input-field col s6'>
              <input placeholder="Numero de Telefono" class='validate' type='text' name='telefono' id='telefono'
                 required minlength="8" maxlength="8" required pattern="^[^0\-][0-9+]+" title="Debe tener el formato de un telefono" />
              <label for='telefono'>Ingresar Número de Teléfono</label>
            </div>

            <div class='row'>
              <div class='input-field col s6'>
                <input placeholder="Numero de telefono secundario" class='validate' type='text' name='telefono_secundario'
                  id='telefono_secundario' minlength="8" maxlength="8"  pattern="^[^0\-][0-9+]+" title="Debe tener el formato de un telefono"  />
                <label for='telefono_secundario'>Telefono Secundario</label>
              </div>
            </div>
            <div class="row">
              <div class="col s6">
                <select name="sexo" id="sexo" class="browser-default " required>
                    <option value="Masculino" disabled selected hidden>Seleccionar el Género</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Femenino">Femenino</option>
                  </select>
                  </div>
              <div class="col s6">
                <select name="nacionalidad" id="nacionalidad" class="browser-default " required>
                </select>
              </div>

              <div class="col s12">
                <br>
                <label for="estudiante"> Por favor seleccione los estudiantes a cargo</label>
                <select name="estudiante[]" id="estudiante" class="js-example-responsive" multiple="multiple" style="width: 100%"></select>
                </select>
              </div>
              <div class="row">
              </div>
              <div class="row">
                <br>
                <div class="center-align">
                  <button class="btn-floating btn-large waves-effect waves-light green" type="button" onclick="activarSelect();"><i
                      class="material-icons center white-text">edit</i></button>
                </div>

              </div>

              <div class="row">
                <br>
              </div>
              <div class="input-field col s12">
                <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion"
                  data-length="100" required maxlength="150" minlength="3" pattern="[ a-zA-ZñÑáéíóúÁÉÍÓÚ\s1-9]+" title="Solo puede insertar un maximo de 100 caracteres."></textarea>
                <label for="direccion">Ingresar la Dirección</label>
              </div>
            </div>
            <br>
          </div>
          <div class="row">
            <div class="col s12">
              <button class="btn waves-effect waves-light green full-width" type="submit" name="Guardar" id="btnguardar" onclick="return guardarEncargado(this);">Guardar
                <i class="material-icons right">done</i><br></button>
            </div>

            <div class="col s6">
              <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue full-width botones">Editar
                <i class="material-icons right">edit</i>
              </button>
            </div>
            <div class="col s6">
              <button class="btn waves-effect waves-light red full-width botones" name="eliminar" id="btnCancelar" type="button"
                onclick="mostrarform(false);">Cancelar
                <i class="material-icons right">clear</i>
              </button>
            </div>

          </div>
          <br>
    </form>


  </div>

</div>

<?php require 'footer.php' ?>

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="js/encargado.js"></script>

</body>

</html>