<?php require 'headerDirector.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">
   <div class="tabla" id="tabla">
        <table id="tblGrado" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Codigo</th>
          <th data-priority="2">Grado</th>
          <th data-priority="3">Opciones</th>
        </thead>
        <tbody>
        </tbody>
      </table>
      </div>


<div class="container">
 <div id="formulario">
   <form method="POST" id="formGrado" name="formGrado">

 <div class='row'>
 <div class='input-field col s6'>
   <input placeholder="Codigo" class='validate' type='text' name='idgrado' id='idgrado' min="1000000" max="9999999"  readonly="true"/>
           <label for='idgrado'>Codigo del Grado</label>
         </div>

<div class='row'>
  <div class='input-field col s6'>
    <input placeholder="Nombre" class='validate' type='text' name='nombreGrado' id='nombreGrado' maxlength="30" required/>
    <label for='nombreGrado'>Ingresa el Nombre</label>
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
</div>
<!-- FINALIZA EL CONTENIDO-->
<?php require 'footerDirector.php' ?>
<script src="js/grado.js?nW"></script>
</body>

</html>
