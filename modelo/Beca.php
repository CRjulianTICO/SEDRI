<?php 
    require "../config/Conexion.php";
Class Beca
{
    
    public function _constructor(){

    }

    public function insertar ($descripcion,$monto,$cedula){
        $sql="CALL `sp_InsertaBeca`('$cedula','$descripcion','$monto')";
        return consulta($sql);
    }

    public function listar(){
        $sql ="select * from vbeca";
        return consulta($sql);
    }

    public function actualizar($descripcion,$monto,$cedula){
        $sql=" call sp_ActualizaBeca('$descripcion','$monto','$cedula')";
        return consulta($sql);
  
      }
  
      public function listarEspecifica($cedula){
          $sql="select * from vbeca where cedula =". $cedula."";
          return consultaSimple($sql);
      }
  
      public function activar($cedula){
        $sql="call sp_ActivaBeca('$cedula')";
        return consulta($sql);
      }
  
      public function desactivar($cedula){
        $sql="call sp_DesactivaBeca('$cedula')";
        return consulta($sql);
      }
  




}



?>