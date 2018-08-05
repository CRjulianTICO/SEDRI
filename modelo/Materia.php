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
       
