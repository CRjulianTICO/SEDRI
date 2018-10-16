<?php
require_once "../config/Conexion.php";

Class Encargado
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante

		public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$telefono2,$nacionalidad)
		{
			$sql="CALL `sp_InsertaEncargado`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,'$telefono','$telefono2',$nacionalidad)";

			return consulta($sql);
		}

		public function consultaID($cedula){
				
				$sql='SELECT idencargado 
				from persona p,encargado e
				where p.idPersona = e.Persona_idPersona and p.cedula = '.$cedula.';';
				return consultaSimple($sql);
		}

		public function borrarAlumno($id){
			$sql="DELETE FROM `alumno_encargado` WHERE ID_ENCARGADO = $id;";
		    return consulta($sql);

		}

		public function insertaAlumno($id,$alumno){
			$sql="INSERT INTO `alumno_encargado` (`ID_ALUMNO`, `ID_ENCARGADO`)
    		VALUES ('$alumno',$id);";
		return consulta($sql);
		}

	public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$telefono2,$nacionalidad)
	{
		$sql="UPDATE `persona` SET 
		`nombre` = '$nombre', 
		`apellido1` = '$apellido1', 
		`apellido2` = '.$apellido2', 
		`sexo` = '$sexo', 
		`direccion` = '$direccion', 
		`telefono` = '$telefono' , 
		`telefono_secundario` = '$telefono2'
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
		$sql = "SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2, SEXO,DIRECCION,TELEFONO,TELEFONO_SECUNDARIO,PAIS,n.idNacionalidad,DISPONIBLE
		FROM PERSONA P,NACIONALIDAD N 
		WHERE CEDULA = '".$cedula."' AND P.idNacionalidad = N.idNacionalidad;";
	    return consultaSimple($sql);
	}
}

?>
