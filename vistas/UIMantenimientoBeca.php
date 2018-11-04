<?php require 'headerDirector.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">
 <div id="divResp"></div>
   <div class="tabla" id="tabla">
        <table id="tblBeca" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="0">Cedula</th>
          <th data-priority="1">Nombre</th>
          <th data-priority="4">Apellidos</th>
          <th data-priority="2">Descripcion</th>
          <th data-priority="3">Monto</th>
          <th data-priority="5">Estado</th>
          <th data-priority="6">Editar</th>
        </thead>
        <tbody>
        </tbody>
      </table>
      </div>


<div class="container">
 <div id="formulario">
   <form method="POST" id="formBeca" name="formBeca">

<div class='row'>
    <div class='input-field col s6'>
        <input placeholder="Cedula" class='validate' type='text' name='cedula' id='cedula' min="1000000" max="9999999"  />
            <label for='cedula'>Ingrese la Cedula del estudiante</label>
    </div>
</div>

<div class="row">
    <div class="input-field col s12">
        <textarea placeholder="Descripcion..." id="descripcionBeca" name="descripcionBeca" class="materialize-textarea" class="validate"></textarea>
            <label for="descripcionBeca">Ingresar la Descripcion de la Beca</label>
    </div>
</div>


<div class='row'>
    <div class='input-field col s6'>
        <input placeholder="Monto" class='validate' type='text' name='monto' id='monto' min="1000000" max="9999999" />
            <label for='monto'>Ingrese el Monto de la Beca</label>
    </div>
</div>


<br>

<br>

<div class="row">
  <div class="col s4">
    <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnGuardar">Guardar
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
    <button class="btn waves-effect waves-light red cancelEst" name="eliminar" id="btnCancelar" type="button" onclick="cancelarForm();">Cancelar
            <i class="material-icons right">clear</i><br></button>
  </div>
</div>
</div>
</div>

<!-- FINALIZA EL CONTENIDO-->
<?php require 'footerDirector.php' ?>
<script src="js/beca.js"></script>
</body>

</html>
