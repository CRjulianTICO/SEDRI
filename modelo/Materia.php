<?php
require_once "../config/Conexion.php";
class Materia
{
    public function _constructor()
    {
    }
    public function insertar($nombre, $tipo)
    {
        $sql = "insert into materia(nombre,idTipoMateria)values('$nombre',$tipo)";
        return consulta($sql);
    }
    public function listar()
    {
        $sql = "select * from vista_materia where estado = 1";
        return consulta($sql);
    }
    public function actualizar($id, $nombre)
    {
        $sql = "update materia set nombre = '$nombre' where idmateria =".$id."";
        return consulta($sql);
    }
    public function desactivar($id)
    {
        $sql = "update materia set estado = 0 where idmateria = ".$id."";

        return consulta($sql);
    }

    public function tiposMaterias()
    {
        $sql = "select * from tipo_materia";
        return consulta($sql);
    }
    public function listarMaterias()
    {
        $sql = "select idmateria,nombre from vista_materia where tipo not LIKE '%Basica%'";
        return consulta($sql);
    }

    public function activar()
    {
        $sql = "update materia set estado = 1 where idmateria = ".$id."";
        return consulta($sql);
    }
    public function consultaEspecifica($id)
    {
        $sql ="select idmateria,nombre from materia where idmateria =".$id."";

        return consultaSimple($sql);
    }
}
