<?php 
require "../config/Conexion.php";

    class Asistencia 
    {
        
        public function __constructor(){

        }
        
        public function insertaAsistencia($estado,$nota,$cedula,$fecha,$idGrado,$idP){
                $sql="CALL `sp_InsertaAsistencia`($estado,'$nota','$cedula','$fecha',$idGrado,$idP)";
                return consulta($sql);
        }

        public function listarGrados($idP){
            $sql = "SELECT pmg.id_grado,g.nombreGrado from profesor_materia_grado pmg, grado g, persona p, profesor pr WHERE p.idPersona = pr.Persona_idPersona and pr.idprofesor = pmg.profesor_idprofesor and g.idgrado = pmg.id_grado and p.idPersona = ".$idP;
            return consulta($sql);
        }

        public function listarAsistenciasActual($idgrado){
           
			$sql="SELECT cedula,nombre,apellido1,apellido2,nombreGrado FROM vista_alumno where idGrado=".$idgrado."";
            
		    return consulta($sql);
        }

        public function verificarAsistenciasActual($grado,$fecha){
           
			$sql="SELECT * FROM vista_asistencia where nombreGrado='$grado' and FECHA = '$fecha'";
            
		    return contarFilas($sql);
        }

        public function contarEstudiantesGrado($idGrado){
            $sql = "select COUNT(DISTINCT(gen.idEstudiante)) FROM grado_estudiante_nota gen, alumno a, persona p where  gen.idEstudiante = a.idalumno and a.Persona_idPersona = p.idPersona and gen.idGrado =".$idGrado;
            return consulta($sql);
        }

        public function listarAsistencia($grado,$fecha){
           
            $sql="SELECT * FROM vista_asistencia where nombreGrado='$grado' and FECHA = '$fecha'";
            
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