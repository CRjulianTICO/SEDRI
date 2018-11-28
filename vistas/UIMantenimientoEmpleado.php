<?php require 'headerDirector.php' ?>

<div id="content">
<div id="divResp"></div>
<div id="tabla">
    <table id="tblEmpleado" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cédula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="3">Primer Apellido</th>
          <th data-priority="5">Segundo Apellido</th>
          <th data-priority="6">Sexo</th>
          <th data-priority="7">Dirección</th>
          <th data-priority="8">Teléfono</th>
          <th data-priority="9">Nacionalidad</th>
          <th data-priority="4">Puesto</th>
          <th data-priority="11">Estado</th>
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
                    <label for ="cedula">Ingresar Cédula del Empleado</label>
                    <input placeholder="Cedula" class="validate" type="text" name="cedula" id="cedula" required/>

                </div>
                <div class="input-field col s6">
                    <label for ="nombre">Nombre del Empleado</label>
                    <input placeholder="Nombre" class="validate" type="text" name="nombre" id="nombre" required />

                </div>
            </div>
            <div class="row">
                <div class="input-field col s6">
                    <label for ="apellido1">Primer apellido</label>
                    <input placeholder="Primer Apellido" class="validate" type="text" name="apellido1" id="apellido1" required />

                </div>
                <div class="input-field col s6">
                    <label for ="apellido2">Segundo apellido</label>
                    <input placeholder="Segundo Apellido" class="validate" type="text" name="apellido2" id="apellido2" required />

                </div>
            </div>

            <div class="row">
                <div class="input-field col s6">
                    <label for ="telefono">Teléfono</label>
                    <input placeholder="Telefono" class="validate" type="text" name="telefono" id="telefono"  required/>

                </div>

                <div class="input-field col s6">
                    <select id="sexo" name="sexo" class="browser-default" value="Masculino">
                        <option value="Masculino">Masculino</option>
                        <option value="Femenino">Femenino</option>
                      </select>

                </div>

            </div>

            <div class="row">
                <div class="input-field col s12">
                    <textarea placeholder="Direccion" id="direccion" name="direccion" class="materialize-textarea" class="validate" required ></textarea>
                    <label for="direccion">Ingresar la Dirección del Empleado</label>
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
                <div class="col s12">
                    <button class="btn waves-effect waves-light green guardaEst full-width" type="submit" name="Guardar" id="btnGuardar" onclick="return guardar(this);">Guardar
                        <i class="material-icons right">done</i>
                        <br>
                    </button>
                </div>

                <div class="col s6">
                    <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst full-width" onclick="return editar(this);">Editar<i class="material-icons right">edit</i></button>
                </div>
                <div class="col s6">
                    <button class="btn waves-effect waves-light red cancelEst full-width" name="eliminar" id="btnCancelar" type="button" onclick="cancelarForm();">Cancelar
                        <i class="material-icons right">clear</i>
                    </button>
                </div>
            <br>
        </form>
    </div>
</div>

</div>


<script>


 
</script>


<?php require 'footerDirector.php' ?>
<script src="js/empleado.js"></script>
</body>

</html>
