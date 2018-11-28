<?php 
    session_start();
    session_destroy();

    header("Location: http://sedricr.com/vistas/Login.php");
?>