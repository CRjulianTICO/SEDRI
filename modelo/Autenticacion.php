<?php 
    require_once "../config/Conexion.php";
 Class Autenticacion{

    public function __constructor(){

    }

    public function hashPassword($pass){
        $opciones = [   'cost' => 9,
                        'salt' => random_bytes(22)
                    ];
        $value = password_hash($pass, PASSWORD_BCRYPT, $opciones);
        return $value;
    }

    public function verifyPassword($ced,$pass){
        $result = consultaSalida($ced);
        $valores;
        $password = $result["@pass"];
        $id = $result["@id"];
        $rol = $result["@rol"];
        $nombre = $result["@nombre"];


        if(password_verify($pass,$password)){
            $valores = array("id"=>$id,"rol"=>$rol,"nombre"=>$nombre);
          

        }else{
         $valores = null;   
        }

        return $valores;
    }

    
 }
/*
 function hashPassword($pass){
        $opciones = [   'cost' => 9,
                        'salt' => random_bytes(22)
                    ];
        $value = password_hash($pass, PASSWORD_BCRYPT, $opciones);
        return $value;
    }
    /*
    function verif(){
        $hash = '$2y$09$gRCjdn8/pKx6hMM4JqfHcur3JOh18PxYj5Bzp5o5tf0NYeEphYJMW';
        $pas = "caca";

        if(password_verify($pas,$hash)){
            echo "<br>si";
        }else{
            echo "<br>nop";
        }
    }
*//*
   echo hashPassword("caca");
/*
    verif();

*/

   
?>