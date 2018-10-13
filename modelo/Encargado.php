<?php
require "../config/Conexion.php";

Class Encargado
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante

		public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$telefono2,$nacionalidad,$cede,$parentezco)
		{

			$sql="
					CALL `sp_InsertaEncargado`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,'$telefono','$telefono2','$nacionalidad','$cede','$parentezco')";
			return consulta($sql);
		}

	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$telefono2,$nacionalidad)
	{
		$sql="UPDATE `persona` SET 
		`cedula` = '$cedula', 
		`nombre` = '$nombre', 
		`apellido1` = '$apellido1', 
		`apellido2` = '.$apellido2', 
		`sexo` = '$sexo', 
		`direccion` = '$direccion', 
		`telefono` = '$telefono' , 
		`telefono2` = '$telefono2'
		where cedula='$cedula';";

		return consulta($sql);
	}
	//Usando la vista creada
	public function listar()
	{
		$sql="SELECT * FROM vista_encargado";
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
		$sql = "SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2, SEXO,DIRECCION,TELEFONO,EMAIL,PAIS,n.idNacionalidad,DISPONIBLE,g.idGrado,g.nombreGrado,pg.annio 
		FROM PERSONA P, ENCARGADO PE, NACIONALIDAD N,grado g,encargado_grado pg 
		WHERE CEDULA = '".$cedula."' AND P.idPersona = PE.Persona_idPersona AND pe.idencargado = pg.idEncargado AND g.idgrado = pg.idGrado AND P.idNacionalidad = N.idNacionalidad;";
	    return consultaSimple($sql);
	}
}

?>
