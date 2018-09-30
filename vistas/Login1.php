<?php require 'headerDirector.php' ?>
<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
<div class="container">
 <div id="formulario">
   <form method="POST" id="formLogin" name="formLogin">

 <div class='row'>
 <div class='input-field col s6'>
   <input placeholder="Codigo" class='validate' type='text' name='user' id='user' min="1000000" max="9999999"  readonly="true"/>
           <label for='idgrado'>Cedula</label>
         </div>

<div class='row'>
  <div class='input-field col s6'>
    <input placeholder="Nombre" class='validate' type='text' name='pass' id='pass' maxlength="30" required/>
    <label for='nombreGrado'>usuario</label>
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

<!-- FINALIZA EL CONTENIDO-->
<?php require 'footerDirector.php' ?>
<script src="js/login.js?nW"></script>
</body>

</html>
