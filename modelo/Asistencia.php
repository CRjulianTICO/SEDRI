<?php 
require "../config/Conexion.php";
    class Asistencia 
    {
        public function __constructor(){

        }
        
        public function insertaAsistencia($estado,$nota,$cedula,$fecha,$idGrado){
                $sql="CALL `sp_InsertaAsistencia`($estado,'$nota','$cedula','$fecha',$idGrado)";
                return consulta($sql);
        }

        public function listarAsistenciasActual($idgrado){
           
			$sql="SELECT cedula,nombre,apellido1,apellido2,nombreGrado FROM vista_alumno where idGrado='$idgrado'";
		
		    return consulta($sql);
        }

        public function listarAsistencia($idgrado,$fecha){
           
			$sql="SELECT * FROM vista_asistencia where idGrado='$idgrado' and FECHA = '$fecha'";
		
		    return consulta($sql);
        }



    }
    

?>