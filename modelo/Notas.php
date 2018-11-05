<?php 
require_once "../config/Conexion.php";

Class Notas{

    public function __construct()
	{
        
    }
    
    public function insertaNotas($cedula,$idMateria,$idGrado,$trabajo_cotidiano,$pruebas,$tareas,$asistencia,$trimestre){
        $sql = "call `sp_InsertaNotas`($cedula,$idMateria,$idGrado,$trabajo_cotidiano,$pruebas,$tareas,$asistencia,$trimestre)";
        return consulta($sql);
    }

    public function listarPorGrado($nombreGrado,$trimestre,$nombreMateria){
        $sql = "select * from vista_notas where nombreGrado='".$nombreGrado."' and trimestre=".$trimestre." and materia='".$nombreMateria."'";
        return consulta($sql);
    }

    public function listarPorMateria($nombreMateria,$trimestre,$nombreGrado){
        $sql = "select * from vista_notas where materia='".$nombreMateria."' and trimestre=".$trimestre." and nombreGrado='".$nombreGrado."'";
        return consulta($sql);
    }


    public function contarMaterias($idTipoMateria){
        $sql = "SELECT count(m.idmateria) as cantidad FROM materia m WHERE m.estado !=0 and m.idTipoMateria = ".$idTipoMateria;
        return consulta($sql);
    }

    public function listarMaterias($idTipoMateria,$idPersona){
        $sql="SELECT m.idmateria as id , m.nombre as nombre FROM materia m, profesor pr, profesor_materia_grado pmg WHERE m.idTipoMateria=".$idTipoMateria." and m.estado != 0 and m.idmateria = pmg.materia_idmateria AND pr.Persona_idPersona =".$idPersona." AND pr.idprofesor = pmg.profesor_idprofesor";
        return consulta($sql);
    }

    public function listarMateriasEspecial($idTipoMateria,$idPersona){
        $sql="SELECT m.idmateria as id , m.nombre as nombre FROM materia m, profesor pr, profesor_materia_grado pmg WHERE m.idTipoMateria=".$idTipoMateria." and m.estado != 0 and m.idmateria = pmg.materia_idmateria AND pr.Persona_idPersona =".$idPersona." AND pr.idprofesor = pmg.profesor_idprofesor";
        return consultaSimple($sql);
    }

    public function listarGrados($idP){
            $sql = "SELECT pmg.id_grado,g.nombreGrado from profesor_materia_grado pmg, grado g, persona p, profesor pr WHERE p.idPersona = pr.Persona_idPersona and pr.idprofesor = pmg.profesor_idprofesor and g.idgrado = pmg.id_grado and p.idPersona = ".$idP;
            return consulta($sql);
        }

    public function nombreMaterias($idMateria){
        $sql="SELECT m.nombre as nombre FROM materia m WHERE  m.estado != 0 and m.idmateria =".$idMateria;
        return consultaSimple($sql);
    }


}


?>