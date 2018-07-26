<?php
require "../config/Conexion.php";

Class Profesor
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante

		public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$email,$nacionalidad)
		{
			$sql="
					CALL `sp_InsertaProfesor`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,'$telefono','$email','$nacionalidad')";
			return consulta($sql);
		}

	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$email,$nacionalidad)
	{
		$sql="UPDATE `persona` SET `cedula` = '$cedula', `nombre` = '$nombre', `apellido1` = '$apellido1', `apellido2` = '.$apellido2', `sexo` = '$sexo', `direccion` = '$direccion', `telefono` = '$telefono' , `email` = '$email'where cedula='$cedula';";

		return consulta($sql);
	}
	//Usando la vista creada
	public function listar()
	{
		$sql="SELECT * FROM vista_profesor";
		return consulta($sql);
	}

	public function desactivar($cedula){
		$sql = "UPDATE persona set disponible = '0' where cedula='".$cedula."';";
		return consulta($sql);
	}

	public function activar($cedula){
		$sql = "UPDATE persona set disponible = '1' where cedula='".$cedula."';";
		return consulta($sql);
	}

	public function cargar($cedula){
		$sql = "SELECT * FROM vista_Profesor WHERE cedula='".$cedula."'";
	    return consultaSimple($sql);
	}
}

?>
