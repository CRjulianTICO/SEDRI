<?php require 'headerDirector.php' ?>

<div id="content">

<div id="tabla">
    <table id="tblEmpleado" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cedula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="3">Primer Apellido</th>
          <th data-priority="5">Segundo Apellido</th>
          <th data-priority="6">Sexo</th>
          <th data-priority="7">Direccion</th>
          <th data-priority="8">Telefono</th>
          <th data-priority="9">Nacionalidad</th>
          <th data-priority="4">Puesto</th>
          <th data-priority="11">Disponible</th>
          <th data-priority="10">Opciones</th>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<div class="container">
    <div id="formulario">
        <form method="POST" id="formEmpleado" name="formEmpleado">

            <div class="row">
                <div class="input-field col s6">
                    <label for ="cedula">Cedula del Empleado</label>
                    <input placeholder="Cedula" class="validate" type="text" name="cedula" id="cedula"/>

                </div>
                <div class="input-field col s6">
                    <label for ="nombre">Nombre de Empleado</label>
                    <input placeholder="Nombre" class="validate" type="text" name="nombre" id="nombre"/>

                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <label for ="apellido1">Primer apellido</label>
                    <input placeholder="Primer Apellido" class="validate" type="text" name="apellido1" id="apellido1"/>

                </div>
                <div class="input-field col s6">
                    <label for ="apellido2">Segundo apellido</label>
                    <input placeholder="Segundo Apellido" class="validate" type="text" name="apellido2" id="apellido2"/>

                </div>
            </div>

            <div class="row">
                <div class="input-field col s6">
                    <label for ="telefono">Telefono</label>
                    <input placeholder="Telefono" class="validate" type="text" name="telefono" id="telefono" />

                </div>

                <div class="input-field col s6">
                    <select id="sexo" name="sexo" class="browser-default">
                        <option value="masculino">Masculino</option>
                        <option value="femenino">Femenino</option>
                      </select>

                </div>

            </div>

            <div class="row">
                <div class="input-field col s12">
                    <textarea placeholder="Direccion" id="direccion" name="direccion" class="materialize-textarea" class="validate"></textarea>
                    <label for="direccion">Ingresar la Direccion del Empleado</label>
                </div>
            </div>

            <div class="row">
                <div class="input-field col s6">
                  <select id="idPuesto" name="idPuesto" class="browser-default">
                  </select>
                </div>
                <div class="input-field col s6">
                  <select id="idNacionalidad" name="idNacionalidad" class="browser-default">
                  </select>
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


<script>
  $(document).ready(function(){
    $('estado').formSelect();
  });
  $(document).ready(function() {
    $('select').material_select();
 });
 $(document).ready(function() {
    $('estado').material_select();
 });
 
 
</script>


<?php require 'footerDirector.php' ?>
<script src="js/empleado.js"></script>
</body>

</html>
