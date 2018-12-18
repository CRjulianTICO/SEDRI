<?php require 'header.php' ?>

<div id="content">

<div class="container">
<div id="divResp"></div>
<div class='row'>
    <div class="col s6" id="divGrados" >
        <select id="cbGrados" class="cbGrados browser-default"><option>asdawd</option><option>asdawd232423422</option><option>asdaw234d</option></select>
    </div>
    <div class="col s6" id="divGrados" >
        <select id="cbTrimestre" class="cbTrimestre browser-default">
        <option value="1">Seleccione el Trimestre</option>
        <option value="1">Primer Trimestre</option>
        <option value="2">Segundo Trimestre</option>
        <option value="3">Tercer Trimestre</option>
        </select>
    </div>
</div>
</div>


   <div class="tabla" id="tabla">
        <table id="tblNotas" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Cédula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="3">Primer Apellido</th>
          <th data-priority="3">Segundo Apellido</th>
          <th >Grado</th>
          <th >Materia</th>
          <th data-priority="4">Trabajo Cotidiano</th>
          <th data-priority="5">Pruebas</th>
          <th data-priority="6">Tareas</th>
          <th data-priority="7">Asistencia</th>
          <th>Total</th>
        </thead>
        <tbody>
        </tbody>
      </table>
      </div>
<!--
<div id="formulario">

<h6>Agregar un encargado</h6>

<div class="divider"></div>
<br>
<form method="post" id="formEncargado">
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
  <input placeholder="Numero de telefono secundario" class='validate' type='text' name='telefono_secundario' id='tel_secundario' maxlength="30" required />
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

   <div class="col s12">
   <br>
   <label for="estudiante"> Por favor seleccione los estudiantes a cargo</label> 
    <select  name="estudiante[]" id="estudiante" class="js-example-responsive" multiple="multiple" style="width: 100%"></select>
    </select>
  </div>
  
<div class="row">
<div class="col s12">
<button class="btn btn_success botones" type="button" onclick="activarSelect();">Modificar</button>
</div>
</div>

<div class="row">
<br>
</div>
    <div class="input-field col s12">
    
      <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required></textarea>
      <label for="direccion">Ingresa la Dirección</label>
    </div>
  </div>
  <br>
</div>
<div class="row">
<div class="col s12">
<button class="btn waves-effect waves-light green full-with" type="submit" name="Guardar" id="btnguardar">Guardar
<i class="material-icons right">done</i><br></button>
</div>

 <div class="col s6">
                        <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue full-with botones">Editar
                            <i class="material-icons right">edit</i>
                        </button>
                    </div>
                    <div class="col s6">
                        <button class="btn waves-effect waves-light red full-with botones" name="eliminar" id="btnCancelar" type="button" onclick="mostrarform(false);">Cancelar
                            <i class="material-icons right">clear</i>
                        </button>
                    </div>

</div>
<br>
</form>


</div>
  -->

  <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnGuardar">Guardar
                        <i class="material-icons right">done</i>
                        <br>
                    </button>
</div>



<?php require 'footer.php' ?>

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="js/notas.js"></script>

</body>

</html>