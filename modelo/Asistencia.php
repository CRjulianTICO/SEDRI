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
           
			$sql="SELECT cedula,nombre,apellido1,apellido2,nombreGrado FROM vista_alumno where idGrado=".$idgrado."";
            
		    return consulta($sql);
        }

        public function listarAsistencia($idgrado,$fecha){
           
            $sql="SELECT * FROM vista_asistencia where idGrado='$idgrado' and FECHA = '$fecha'";
            
		    return consulta($sql);
        }

           public function actualizarAsistencia($ced,$just,$nota,$fecha){
           
			$sql="CALL `sp_ActualizaAsistencia`($just,'$nota','$ced','$fecha')";
		
		    return consulta($sql);
        }




    }
    /*
   function listarAsistenciasActual(){
           
			$sql="SELECT cedula,nombre,apellido1,apellido2,nombreGrado FROM vista_alumno where idGrado=1";
            //print_r(consulta($sql));
            $rspt = consulta($sql);
            while ($reg=$rspt->fetch_object()){
                echo"<br>";
 				print_r($reg->cedula);echo"<br>";
 				print_r($reg->nombre);echo"<br>";
                print_r($reg->apellido1);echo"<br>";
				print_r($reg->apellido2);echo"<br>";
				print_r($reg->nombreGrado);echo"<br>";
 		}
        }
        listarAsistenciasActual();*/


?>