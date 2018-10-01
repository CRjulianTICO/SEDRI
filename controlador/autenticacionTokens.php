<?php 
require_once "../modelo/AutenticacionTokens.php";

$inst = new Auth();
session_start();
$token=$_SESSION["token"];
print_r($token);

$inst->Check($token);

$datatoken=$inst->GetData($token);

if($datatoken["rol"]=="Profesor"){
    header("HTTP/1.1 301 Moved Permanently"); 
    header("Location: http://localhost:8888/SEDRI/vistas/UIMantenimientoAlumno.php"); 
    exit();
}else{
    header("HTTP/1.1 301 Moved Permanently"); 
    header("Location: http://localhost:8888/SEDRI/vistas/UIListaAlumno.php"); 
}


?>