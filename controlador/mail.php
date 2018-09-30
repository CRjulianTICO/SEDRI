<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

 //Load composer's autoloader



 Class Mailer
 {
     //Implementamos nuestro constructor
     public function __construct()
     {
 
     }

     public function generarPassword(){

        
     }
    // Passing `true` enables exceptions
    public function enviarCorreo($tipoemail,$destinatario,$pass){
    $mail = new PHPMailer(true); 

    try {
    //Server settings
    $mail->SMTPDebug = 2;                                 // Enable verbose debug output
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = 'smtp.gmail.com';  // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    $mail->Username = 'escuelasedri@gmail.com';                 // SMTP username
    $mail->Password = 'sedri123';                           // SMTP password
    $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 587;                                    // TCP port to connect to

    //Recipients
    $mail->setFrom('escuelasedri@gmail.com', 'SEDRI');
    $mail->addAddress($destinatario);     // Add a recipient
    // Name is optional

    //Attachments
        // Optional name

    //Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Bienvenido a SEDRI';
    $mail->Body    = '<h3>Bienvenido a Sedri</h3><hr>
    Se le ha creado una cuenta a la cual puede acceder desde <a href="https://developer.mozilla.org">Aqui</a>
    Su contraseña de inicio temporal es : '.$pass;

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}


    }


 }