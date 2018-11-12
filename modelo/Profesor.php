<?php
require "../config/Conexion.php";

Class Profesor
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante

		public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$email,$nacionalidad,$idgrado,$pass, $materia,$tipo)
		{

			$sql="
					CALL `sp_InsertaProfesor`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,'$telefono','$email',$nacionalidad,$idgrado,'$pass',$materia,$tipo)";
			return consulta($sql);
		}

	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$email,$nacionalidad)
	{
		$sql="UPDATE `persona` SET `cedula` = '$cedula', `nombre` = '$nombre', `apellido1` = '$apellido1', `apellido2` = '.$apellido2', `sexo` = '$sexo', `direccion` = '$direccion', `telefono` = '$telefono' , `email` = '$email'where cedula='$cedula'";

		return consulta($sql);
	}
	//Usando la vista creada
	public function listar()
	{
		$sql="SELECT * FROM vista_profesor where disponible = 1 GROUP BY CEDULA";
		return consulta($sql);
	}

	public function desactivar($cedula){
		$sql="CALL `sp_desactivarUsuario`('$cedula')";
			return consulta($sql);
	}

	public function activar($cedula){
		$sql = "UPDATE persona set disponible = '1' where cedula='".$cedula."'";
		return consulta($sql);
	}

	public function cargar($cedula){
		$sql = "SELECT p.CEDULA, p.NOMBRE, p.APELLIDO1, p.APELLIDO2, p.SEXO, p. DIRECCION, p.TELEFONO, p.EMAIL, p.PAIS,n.idNacionalidad,p.DISPONIBLE,g.idGrado,g.nombreGrado,g.annio
		FROM persona p, profesor pe, nacionalidad n,grado g,profesor_materia_grado pg
		WHERE p.CEDULA = '".$cedula."' AND p.idPersona = pe.Persona_idPersona AND pe.idprofesor = pg.profesor_idprofesor AND g.idgrado = pg.id_grado AND p.idNacionalidad = n.idNacionalidad";
	    return consultaSimple($sql);
	}
}

?>
