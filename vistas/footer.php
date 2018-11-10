
<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>
<script src="js/menu.js"></script>
<?php
if ($tipoProfe == 1) {
	echo '<script type="text/javascript">',
 'cargarMenu();',
 '</script>';
}
?>
<script src="js/menu.js"></script>

<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, // Default is 300
  edge: 'left', // Choose the horizontal origin
  closeOnClick: false, // Closes side-nav on <a> clicks, useful for Angular/Meteor
  draggable: true // Choose whether you can drag to open on touch screens
});
</script>

<script>
 function redireccionarAlumno(){
    window.location.href = "../vistas/UIMantenimientoAlumno.php#mostrarform";
}
function redireccionarEncargado(){
    window.location.href = "../vistas/UIMantenimientoEncargado.php#mostrarform";
}
function redireccionarAsistencia(){
    window.location.href = "../vistas/UIAsistenciaAlumno.php#mostrarform";
}
</script>
<script type="text/javascript">
 $(document).ready(function() {
    $('#descripcionPuesto').characterCounter();
  });
</script>
