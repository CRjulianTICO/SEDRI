<?php 
require_once "../modelo/AutenticacionTokens.php";

$inst = new Auth();

$token = $inst ->SignIn(["userID"=>1,"grupo"=>"Primero","nombre"=>"Juan paco","rol"=>"Profesor"]);

$inst->Check($token);

$datatoken=$inst->GetData($token);

foreach ($datatoken as $key => $value) {
    echo $value."<br>";
}

?>