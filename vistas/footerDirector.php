
<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>


<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, // Default is 300
  edge: 'left', // Choose the horizontal origin
  closeOnClick: false, // Closes side-nav on <a> clicks, useful for Angular/Meteor
  draggable: true // Choose whether you can drag to open on touch screens
});
</script>


<script type = "text/javascript"> 
  function redireccionarGrado(){
    window.location.href = "../vistas/UIMantenimientoGrado.php#mostrarFormulario";
} 
  function redireccionarMateria(){
    window.location.href = "../vistas/UIMantenimientoMateria.php#mostrarFormularioMateria";
} 
  function redireccionarPuesto(){
    window.location.href = "../vistas/UIMantenimientoPuesto.php#mostrarFormulario";
}

 function redireccionarBeca(){
    window.location.href = "../vistas/UIMantenimientoBeca.php#mostrarFormularioBeca";
}

 function redireccionarEmpleado(){
    window.location.href = "../vistas/UIMantenimientoEmpleado.php#mostrarFormulario";
}
 function redireccionarProfesor(){
    window.location.href = "../vistas/UIMantenimientoProfesor.php#mostrarform";
}


</script>

<script type="text/javascript">
 $(document).ready(function() {
    $('#descripcionPuesto').characterCounter();
  });
</script>


