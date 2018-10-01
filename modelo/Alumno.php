<?php
require "../config/Conexion.php";

Class Alumno
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante
	public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad)
	{
		$sql="INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`)
    		VALUES (NULL, '$cedula', '$nombre', '$apellido1', '$apellido2', '$sexo', '$direccion', NULL, NULL, NULL, '$nacionalidad', '1');";
		return consulta($sql);
	}
	public function cargarPais()
	{
		$sql= "SELECT * FROM `nacionalidad`";
		return consulta($sql);
	}
	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad)
	{
		$sql="UPDATE `persona` SET `cedula` = '".$cedula."', `nombre` = '".$nombre."', `apellido1` = '".$apellido1."', `apellido2` = '".$apellido2."', `sexo` = '".$sexo."', `direccion` = '".$direccion."'where cedula='".$cedula."';";

		return consulta($sql);
	}

	public function getIdPersona($cedula){
			echo "cedula".$cedula;
	    $sql = "SELECT idPersona FROM persona WHERE cedula='".$cedula."'";
	    $id=consultaSimple($sql);
	    $id = $id['idPersona'];
	    echo "id".$id;
	    $sql2 = "INSERT INTO `alumno` (`idalumno`, `Persona_idPersona`) VALUES (NULL, '".$id."');";
	    return consulta($sql2);
	  }
 
	public function listar()
	{
		$sql="SELECT * FROM vista_alumno";
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
		$sql = "SELECT * FROM vista_alumno WHERE cedula='".$cedula."'";
	    return consultaSimple($sql);
	}
}

?>
