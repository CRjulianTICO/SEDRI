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
        $cambio = $result["@ocambio"];
        $grupo = $result["@ogrupo"];
        $idgrado = $result["@idgrado"];
        $email = $result["@oemail"];
        $grado = $result["@ogrado"];
        $idtipo = $result["@idtipo"];
        $tipoP = $result["@tipoPro"];

        if(password_verify($pass,$password)){


            $valores = array("id"=>$id,"rol"=>$rol,"nombre"=>$nombre,"cambio"=>$cambio,"grupo"=>$grupo,"email"=>$email,"idgrado"=>$idgrado,"grado"=>$grado,"tipoMateria"=>$idtipo,"tipoProfesor"=>$tipoP);



        }else{
         $valores = null;   
        }

        return $valores;
    }

    public function recuperar($cedula){
		$sql = "SELECT email,idUsuario,password
        from persona p,usuario u
		WHERE p.idPersona = u.idPersona and CEDULA = '".$cedula."'";
	    return consultaSimple($sql);
    }

    public function historico($id,$correo,$pass){
        $fecha =  date("Y/m/d");
		$sql = "INSERT INTO historico_usuarios(idUsuario,email,pass,fecha) values($id,'$correo','$pass','$fecha')";
	    return consulta($sql);
    }
    
    public function actualizar($id,$password,$cambio){
        $sql="UPDATE `usuario` SET `password` = '$password', `cambio` = '$cambio' where idUsuario='$id';";
		return consulta($sql);
    }
    public function mostrarHistorico($id){
        $sql="select * from historico_usuarios where idUsuario = $id;";
		return consulta($sql);
    }

     public function verificar($pass1,$pass2){
        $varP = 'false';
    
            if(password_verify($pass1,$pass2)){
                $varP = '1';
            }else{
            $varP= '0';
            }

            return $varP;

 }
    
 }



//  verificar('12345678');

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