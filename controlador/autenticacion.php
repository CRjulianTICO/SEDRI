<?php 
require_once "../modelo/Autenticacion.php";

$inst = new Autenticacion();
    $value = $inst->verifyPassword('307680159','caca');

    if($value == null){
        echo "<br>mamo<br>";
    }else{
        echo "<br>opale<br>";

        foreach ($value as $key => $values) {
            echo $values."<br>";
        }
    }
?>