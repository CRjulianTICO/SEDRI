<?php
require "../config/Conexion.php";



Class Alumno
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante
	public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad,$nota,$grado)
	{
		$sql="CALL `sp_InsertaAlumno`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,$nacionalidad,'$nota',$grado)";
			return consulta($sql);
	}
	public function cargarPais()
	{
		$sql= "SELECT * FROM `nacionalidad`";
		return consulta($sql);
	}
	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad,$nota)
	{
		$sql="UPDATE `persona` SET 
		`cedula` = '".$cedula."',
		 `nombre` = '".$nombre."',
		  `apellido1` = '".$apellido1."',
		   `apellido2` = '".$apellido2."',
			`sexo` = '".$sexo."', 
			`direccion` = '".$direccion."',
			`nota_medica` = '".$nota."'
			
			where cedula='".$cedula."';";

		return consulta($sql);
	}
 
	public function listar($idgrado)
	{
		if($idgrado==0){
			$sql="SELECT * FROM vista_alumno";
		}else{
			$sql="SELECT * FROM vista_alumno where idGrado='$idgrado'";
		}
			
		

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
