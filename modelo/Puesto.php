<?php
require "../config/Conexion.php";

Class Puesto{

    public function _constructor(){

    }

    public function insertar($nombrePuesto,$descripcionPuesto){
        $sql = "insert into puesto(nombrePuesto,descrpcionPuesto) values('$nombrePuesto','$descripcionPuesto')";
        return consulta($sql);
    }

    public function listar(){
        $sql="select * from puesto";
        return consulta($sql);
    }

    public function actualizar($id,$nombre,$descripcion){
            $sql="update puesto set nombrePuesto = '$nombre', descrpcionPuesto ='$descripcion' where idPuesto = ".$id."";
            return consulta($sql);
       
    }

    public function listarEspecifica($idPuesto){
        $sql="select * from puesto where idPuesto =". $idPuesto."";
        return consultaSimple($sql);
    }




}


?>