<?php 
require_once "global.php";

$conexion = new mysqli(null,DB_USERNAME,DB_PASSWORD,DB_NAME,null,'/cloudsql/onyx-descent-222103:onyx-descent-222103:us-east1:sedri');

mysqli_query( $conexion, 'SET NAMES "'.DB_ENCODE.'"');


if (mysqli_connect_errno())
{
	printf("Falló conexión a la base de datos: %s\n",mysqli_connect_error());
	exit();
}

if (!function_exists('ejecutarConsulta'))
{
	function consulta($sql)
	{
		global $conexion;
		$query = $conexion->query($sql);
		return $query;
	}

	function consultaSimple($sql)
	{
		global $conexion;
		$query = $conexion->query($sql);		
		$row = $query->fetch_assoc();
		return $row;
	}

	function contarFilas($sql)
	{
		global $conexion;
		$query = $conexion->query($sql);
		$row_cnt = $query->num_rows;
		return $row_cnt;
	}

	function consultaSalida($ced){
		global $conexion;
		$call = mysqli_prepare($conexion, 'CALL sp_Login(@pass, ?, @id, @rol, @nombre,@ocambio,@ogrupo,@idgrado,@oemail,@ogrado,@idtipo,@tipoPro)');
				mysqli_stmt_bind_param($call, 'i', $ced);
				mysqli_stmt_execute($call);
		$select = mysqli_query($conexion, 'select @pass,@id, @rol, @nombre,@ocambio,@ogrupo,@idgrado,@oemail,@ogrado,@idtipo,@tipoPro');
		$result = mysqli_fetch_assoc($select);
		return $result;
	}

	

	
	function limpiarCadena($str)
	{
		global $conexion;
		$str = mysqli_real_escape_string($conexion,trim($str));
		return htmlspecialchars($str);
	}
}


?>
