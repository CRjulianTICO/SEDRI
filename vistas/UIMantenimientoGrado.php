<?php require 'headerDirector.php';
date_default_timezone_set('America/Costa_Rica');
$fecha =  date("Y"); ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">
 <div id="divResp"></div>
   <div class="tabla" id="tabla">
        <table id="tblGrado" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th data-priority="1">Código</th>
          <th data-priority="2">Grado</th>
          <th data-priority="3">Año</th>
          <th data-priority="4">Opciones</th>
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
           <label for='idgrado'>Código del Grado</label>
         </div>
</div> 

<div class='row'>
  <div class='input-field col s6'>
    <input placeholder="Nombre" class='validate' type='text' name='nombreGrado' id='nombreGrado' maxlength="30" required/>
    <label for='nombreGrado'>Ingresar el Nombre</label>
    </div>
    <div class="input-field col s6">
     <select  name="annio" id="annio" class="browser-default " required>
          <option value="<?php $fecha ?>" disabled selected hidden>Seleccionar el Año del grado</option>
          <option value="2018">2018</option>
          <option value="2019">2019</option>
          </select>
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
