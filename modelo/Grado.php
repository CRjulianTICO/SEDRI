<?php
require "../config/Conexion.php";

Class Grado
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante
	public function insertar($nombreGrado)
	{
		$sql="INSERT INTO `grado` (`idgrado`, `nombreGrado`)
    		VALUES (NULL, '$nombreGrado');";
		return consulta($sql);
	}

	public function actualizar($idgrado,$nombreGrado)
	{
		$sql="UPDATE `grado` SET `nombreGrado` = '".$nombreGrado."'where idgrado='".$idgrado."';";

		return consulta($sql);
	}
	//Usando la vista creada
	public function listar()
	{
		$sql="SELECT * FROM grado";
		return consulta($sql);
	}

	public function listarNombre($id){
		$sql = "SELECT nombreGrado FROM grado WHERE idgrado='".$id."'";
	    return consultaSimple($sql);
	}


	public function cargar($id){
		$sql = "SELECT * FROM grado WHERE idgrado='".$id."'";
	    return consultaSimple($sql);
	}
}

?>
