<!DOCTYPE html>
<html>
<head>
	<title></title>
	<!-- JQuery / Materialize CSS + JavaScript imports -->

<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/js/materialize.min.js"></script>


<style type="text/css">
	#container {
  padding-left: 300px;
}

#content {
  padding: 20px;
 margin-left: 22%;
}

@media only screen and (max-width : 992px) {
  #container {
    padding-left: 0px;
  }
  #content{
  	margin-left: 0;
  }
}
</style>


</head>




<body>

<!--PRINCIPIO DEL MENU-->
<nav>
<div class="nav-wrapper">

<!--ESTE CONTAINER TIENE LA PARTE DEL MENU LATERAL Y EL FRONTAL-->
<div id="container">


<!--EL MENU LATERAL ES TODO ESTO-->
  <div id="menu">

    <ul id="slide-out" class="side-nav fixed show-on-large-only">
      <li><a href="#">Nombre Profesor <i class="material-icons">account_circle</i>  </a></li>
      <li> <div class="divider"></div></li>
      <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header">Estudiantes<i class="material-icons right">arrow_drop_down</i><i class="material-icons left">face</i></a>
            <div class="collapsible-body">
              <ul>
                <li><a href="#!">Agregar<i class="material-icons left">add_circle</i></a></li>
                <li><a href="#!">Modificar<i class="material-icons left">border_color</i></a></li>
              </ul>
            </div>
          </li>
        </ul>
      </li>
      <li><a href="#!" class="waves-effect">Notas<i class="material-icons left">description</i></a></li>
      <li><a href="#!" class="waves-effect">Cuotas <i class="material-icons left">attach_money</i></a></li>
 
    </ul>
    <!--menu frontal-->
      <ul id="nav-mobile" class="right ">
        <li><a href="#">Perfil</a></li>
        <li><a href="#">Cerrar Sesion</a></li>
      </ul>
<!--fin del menu frontal-->
  </div>
<!--FIN DEL MENU LATERAL-->


    
</div>
<!--AQUI TERMINA EL CONTAINER -->

<a href="#" data-activates="slide-out" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>

</div>

</nav>
<!--FINAL DEL MENU-->

<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">    
    <div class="container">
       <table>
        <thead>
          <tr>
              <th>Name</th>
              <th>Item Name</th>
              <th>Item Price</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>Alvin</td>
            <td>Eclair</td>
            <td>$0.87</td>
          </tr>
          <tr>
            <td>Alan</td>
            <td>Jellybean</td>
            <td>$3.76</td>
          </tr>
          <tr>
            <td>Jonathan</td>
            <td>Lollipop</td>
            <td>$7.00</td>
          </tr>
        </tbody>
      </table>
    </div>
 </div>
<!-- FINALIZA EL CONTENIDO-->



<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, // Default is 300
  edge: 'left', // Choose the horizontal origin
  closeOnClick: false, // Closes side-nav on <a> clicks, useful for Angular/Meteor
  draggable: true // Choose whether you can drag to open on touch screens
});
</script>


</body>
</html>

