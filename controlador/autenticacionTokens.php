<?php 
session_start();
require_once "../modelo/AutenticacionTokens.php";

//Se recibe el token por medio de la sesion
$token=$_SESSION["token"];

//Se instancia la clase Auth donde se tienen todos los metodos sobre el token
$inst = new Auth();

//Se verifica el token, si algo esta mal por parte de la clase tira un error
$inst->Check($token);

//Se declara un arreglo para despues usarlo para almacenar en los datos del token
$dataToken=[];

//Recibe los datos del usuario del token pero en un tipo de arreglo asociativo;
$dataTokenEncrip=$inst->GetData($token);


//Se recorre el token enviado para almacenar los datos en otro arreglo
foreach ($dataTokenEncrip as $key => $value) {
        $dataToken += ["".$key."" => $value];
}

//Se verifica si el rol es de Profesor en caso que no pasa al lado de director
if($dataToken["rol"]=="Profesor"){
    header("HTTP/1.1 301 Moved Permanently"); 
    header("Location: http://ssedri.herokuapp.com/vistas/UIMantenimientoAlumno.php"); 
    exit();
}else{
    header("HTTP/1.1 301 Moved Permanently"); 
    header("Location: http://ssedri.herokuapp.com/vistas/UIListaAlumno.php"); 
    exit();
}


?>