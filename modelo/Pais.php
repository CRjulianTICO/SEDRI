<?php
require_once "../config/Conexion.php";

Class Pais
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	public function cargarPais()
	{
		$sql= "SELECT * FROM `nacionalidad`";
		return consulta($sql);
	}

}

?>
