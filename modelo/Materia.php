<?php
require "../config/Conexion.php";
Class Materia{
  public function _constructor(){
 }
 public function insertar($nombre){
 $sql = "insert into materia(nombre)values('$nombre')";
   return consulta($sql);
    }     
 public function listar(){
    $sql = "select * from materia where estado = 1";
           return consulta($sql);
    }
 public function actualizar($id,$nombre){
 $sql = "update materia set nombre = '$nombre' where idmateria =".$id."";
         return consulta($sql);
    }  
