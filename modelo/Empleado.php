<?php
require "../config/Conexion.php";

Class Empleado{

    public function _constructor(){

    }
    public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$idNacionalidad,$idPuesto){
      $sql="
					CALL `sp_InsertarEmpleado`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
					,'$telefono','$idNacionalidad','$idPuesto')";
			return consulta($sql);
    }
    public function listar(){
        $sql="select * from vista_empleado";
        return consulta($sql);
    }

    public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$idNacionalidad,$idPuesto){
      $sql="
          CALL `sp_ActualizarEmpleado`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
          ,'$telefono','$idNacionalidad','$idPuesto')";
      return consulta($sql);

    }

    public function listarEspecifica($cedula){
        $sql="select * from vista_empleado where cedula =". $cedula."";
        return consultaSimple($sql);
    }

    public function activar(){
      $sql="update persona
      disponible = 1
      where cedula = ".$cedula."";
      return consulta($sql);
    }

    public function desactivar(){
      $sql="update persona
      disponible = 0
      where cedula = ".$cedula."";
      return consulta($sql);
    }

    public function cargarPais(){
      $sql="select * from nacionalidad";
      return consulta($sql);

    }

    public function cargarPuesto(){
      $sql="select idPuesto,nombrePuesto from puesto";
      return consulta($sql);

    }



}


?>
