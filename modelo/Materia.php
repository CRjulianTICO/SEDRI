<?php
require "../config/Conexion.php";
Class Materia{
  public function _constructor(){
 }
 public function insertar($nombre){
 $sql = "insert into materia(nombre)values('$nombre')";
   return consulta($sql);
    }     
