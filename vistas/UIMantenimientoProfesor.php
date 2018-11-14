<?php require 'headerDirector.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->

<div id="content">
<div id="divResp"></div>
  <div class="tabla" id="tabla">
    <table id="tbProfesor" class="display responsive nowrap tabla" style="width: 100%">
      <thead>
        <th data-priority="1">Cedula</th>
        <th data-priority="2">Nombre</th>
        <th data-priority="3">Primer Apellido</th>
        <th data-priority="4">Segundo Apellido</th>
        <th>Sexo</th>
        <th>Direccion</th>
        <th>Telefono</th>
        <th>Correo</th>
        <th>Nacionalidad</th>
        <th>Estado</th>
        <th>Opciones</th>
        <th>Grado</th>
        <th>Tipo de Profesor</th>
      </thead>
      <tbody>
      </tbody>
    </table>
  </div>


  <div class="container">

    <div id="formulario">
      <form method="POST" id="formProfesor" name="formProfesor">

        <div class='row'>
          <div class='input-field col s6'>
            <input placeholder="Cédula" class='validate' type='text' name='cedula' id='cedula' pattern="^[^0][0-9]{9,10}"  title="Solo puede insertar numeros con un minimo de 9 digitos" required />
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
              <input placeholder="Primer Apellido" class='validate' type='text' name='apellido1' id='apellido1' maxlength="25" required pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres" />
              <label for='apellido1'>Ingresar el Primer Apellido</label>
            </div>

            <div class='row'>
              <div class='input-field col s6'>
                <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2' maxlength="25" required pattern="[A-Za-z]{1,25}" title="No se pueden introducir caracteres especiales. O un largo maximo de 25 caracteres"  />
                <label for='apellido2'>Ingresar Segundo Apellido</label>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s6'>
                <input placeholder="Numero de Telefono" class='validate' type='text' name='telefono' id='telefono' pattern="^[^0][0-9]{8,12}" title="Solo puede insertar numeros con un minimo de 9 digitos" maxlength="12" required />
                <label for='telefono'>Ingresar Número de Teléfono</label>

              </div>

              <div class='row'>
                <div class='input-field col s6'>
                  <input placeholder="Email" class='validate' type='email' name='email' id='correo' maxlength="30" required pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" title="El correo debe tener un formato valido"/>
                  <label for='email'>Ingresar Correo Electrónico</label>

                </div>
              </div>
              <div class="row">
                <div class="col s6">
                  <select name="sexo" id="sexo" class="browser-default " required>
                    <option value="" disabled selected hidden>Seleccionar el Género</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Femenino">Femenino</option>
                  </select>
                </div>
                <div class="col s6">
                  <select class="browser-default" name="nacionalidad" id="nacionalidad" required>
                  </select>
                </div>

              </div>
              <br>

              <div class="row">
                <div class="col s6" id="divTipo">
                  <select name="tipo" id="tipo" class="browser-default" required>
                    <option value="1">Profesor Especial</option>
                    <option value="0">Profesor de Materias</option>
                  </select>
                </div>
                <div class="col s6" id="divGrado">
                  <select name="idgrado" id="idgrado" class="browser-default" required>
                  </select>
                </div>
                
                <div class="col s6" id="divMateria">
                  <select name="materia" id="materia" class="browser-default" required>
                  </select>
                </div>

              </div>
              <br>
              <div class="row">

                <div class="input-field col s12">
                  <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required pattern="[A-Za-z0-9]{1,100}" title="No se pueden introducir caracteres especiales"></textarea>
                  <label for="direccion">Ingresar la Dirección</label>
/div>
              </div>
              <br>

              <br><br>
              <div class="row">
                <div class="col s12">
                  <button class="btn waves-effect waves-light green guardaEst full-width" type="submit" name="Guardar" id="btnguardar">Guardar
                    <i class="material-icons right">done</i><br></button></div>
              </div>
            </div>
            <br>
      </form>

      <div class="row" id="botones">
        <div class="col s6">
          <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst full-width">Editar<i class="material-icons right">edit</i></button>
        </div>
        <div class="col s6">
          <button class="btn waves-effect waves-light red cancelEst full-width" name="eliminar" type="button" onclick="cancelarform();">Cancelar
            <i class="material-icons right">clear</i><br></button>
        </div>
      </div>
    </div>

  </div>
</div>
<!-- FINALIZA EL CONTENIDO-->
<?php require 'footerDirector.php' ?>
<script src="js/profesor.js?new"></script>
</body>

</html>
