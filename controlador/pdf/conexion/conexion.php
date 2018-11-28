<?php
	$mysqli=new mysqli("localhost","u729847063_sedri","Pz8Z8mnPnvRj7FTtNU","u729847063_sedri"); //servidor, usuario de base de datos, contraseña del usuario, nombre de base de datos
	
	if(mysqli_connect_errno()){
		echo 'Conexion Fallida : ', mysqli_connect_error();
		exit();
	}
	$acentos = $mysqli->query("SET NAMES 'utf8'")
?>

