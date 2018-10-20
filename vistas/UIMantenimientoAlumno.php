<?php require 'header.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">
 <h5 class="center-align"><?php echo( $grupo);?></h5>
 <hr>
   <div class="tabla" id="tabla">
        <table id="tbAlumno" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cedula</th>
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

              
        <div class="col s6">
          <select  name="sexo" id="sexo" class="browser-default " required>
          <option value="" disabled selected hidden>Seleccionar el Género</option>
          <option value="Masculino">Masculino</option>
          <option value="Femenino">Femenino</option>
          </select>
        </div>
        <div class="col s6">
          <select  name="nacionalidad" id="nacionalidad" class="browser-default" required>
          </select>
        </div>

  </div>
    <br>

    <div class="row">
   

    </div>
    <br>
    <div class="row">

          <div class="input-field col s12">
            <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required></textarea>
            <label for="direccion">Ingresa la Dirección</label>
          </div>
        </div>


         <div class="row">

<div class="input-field col s12">
  <textarea placeholder="Ingresa datos medicos que pueden ser relevantes" id="nota" class="materialize-textarea validate" name="nota" data-length="100" required></textarea>
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
  </form>

	<div class="row" id="botones">
		<div class="col s6">
		<button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst">Editar<i class="material-icons right">edit</i></button>
		</div>
		<div class="col s6">
		<button class="btn waves-effect waves-light red cancelEst"  name="eliminar" type="button" onclick="cancelarform();">Cancelar
		<i class="material-icons right">clear</i><br></button>
		</div>
	</div>
      </div>

    </div>
 </div>
<!-- FINALIZA EL CONTENIDO-->


<?php require 'footer.php' ?>

<script src="js/alumno.js"></script>

</body>

</html>