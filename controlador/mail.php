<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';
require_once "../modelo/Autenticacion.php";




 //Load composer's autoloader



 Class Mailer
 {
     //Implementamos nuestro constructor
     public function __construct()
     {
 
     }

     public function generarPassword(){
        $auth = new Autenticacion();
        $str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        $password = "";
        for($i=0;$i<8;$i++) {
            $password .= substr($str,rand(0,62),1);
            }
            return $password;   
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
                $mail->Body    = '
                <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <style type="text/css" rel="stylesheet" media="all">
    /* Base ------------------------------ */
    
    *:not(br):not(tr):not(html) {
      font-family: Arial,Helvetica Neue, Helvetica, sans-serif;
      box-sizing: border-box;
    }
    
    body {
      width: 100% !important;
      height: 100%;
      margin: 0;
      line-height: 1.4;
      background-color: #F2F4F6;
      color: #74787E;
      -webkit-text-size-adjust: none;
    }
    
    p,
    ul,
    ol,
    blockquote {
      line-height: 1.4;
      text-align: left;
    }
    
    a {
      color: white;
    }
    
    a img {
      border: none;
    }
    
    td {
      word-break: break-word;
    }
    /* Layout ------------------------------ */
    
    .email-wrapper {
      width: 100%;
      margin: 0;
      padding: 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      background-color: #F2F4F6;
    }
    
    .email-content {
      width: 100%;
      margin: 0;
      padding: 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
    }
    /* Masthead ----------------------- */
    
    .email-masthead {
      padding: 25px 0;
      text-align: center;
    }
    
    .email-masthead_logo {
      width: 94px;
    }
    
    .email-masthead_name {
      font-size: 16px;
      font-weight: bold;
      color: #bbbfc3;
      text-decoration: none;
      text-shadow: 0 1px 0 white;
    }
    /* Body ------------------------------ */
    
    .email-body {
      width: 100%;
      margin: 0;
      padding: 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      border-top: 1px solid #EDEFF2;
      border-bottom: 1px solid #EDEFF2;
      background-color: #FFFFFF;
    }
    
    .email-body_inner {
      width: 570px;
      margin: 0 auto;
      padding: 0;
      -premailer-width: 570px;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      background-color: #FFFFFF;
    }
    
    .email-footer {
      width: 570px;
      margin: 0 auto;
      padding: 0;
      -premailer-width: 570px;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      text-align: center;
    }
    
    .email-footer p {
      color: #AEAEAE;
    }
    
    .body-action {
      width: 100%;
      margin: 30px auto;
      padding: 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      text-align: center;
    }
    
    .body-sub {
      margin-top: 25px;
      padding-top: 25px;
      border-top: 1px solid #EDEFF2;
    }
    
    .content-cell {
      padding: 35px;
    }
    
    .preheader {
      display: none !important;
      visibility: hidden;
      mso-hide: all;
      font-size: 1px;
      line-height: 1px;
      max-height: 0;
      max-width: 0;
      opacity: 0;
      overflow: hidden;
    }
    /* Attribute list ------------------------------ */
    
    .attributes {
      margin: 0 0 21px;
    }
    
    .attributes_content {
      background-color: #EDEFF2;
      padding: 16px;
    }
    
    .attributes_item {
      padding: 0;
    }
    /* Related Items ------------------------------ */
    
    .related {
      width: 100%;
      margin: 0;
      padding: 25px 0 0 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
    }
    
    .related_item {
      padding: 10px 0;
      color: #74787E;
      font-size: 15px;
      line-height: 18px;
    }
    
    .related_item-title {
      display: block;
      margin: .5em 0 0;
    }
    
    .related_item-thumb {
      display: block;
      padding-bottom: 10px;
    }
    
    .related_heading {
      border-top: 1px solid #EDEFF2;
      text-align: center;
      padding: 25px 0 10px;
    }
    /* Discount Code ------------------------------ */
    
    .discount {
      width: 100%;
      margin: 0;
      padding: 24px;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
      background-color: #EDEFF2;
      border: 2px dashed #9BA2AB;
    }
    
    .discount_heading {
      text-align: center;
    }
    
    .discount_body {
      text-align: center;
      font-size: 15px;
    }
    /* Social Icons ------------------------------ */
    
    .social {
      width: auto;
    }
    
    .social td {
      padding: 0;
      width: auto;
    }
    
    .social_icon {
      height: 20px;
      margin: 0 8px 10px 8px;
      padding: 0;
    }
    /* Data table ------------------------------ */
    
    .purchase {
      width: 100%;
      margin: 0;
      padding: 35px 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
    }
    
    .purchase_content {
      width: 100%;
      margin: 0;
      padding: 25px 0 0 0;
      -premailer-width: 100%;
      -premailer-cellpadding: 0;
      -premailer-cellspacing: 0;
    }
    
    .purchase_item {
      padding: 10px 0;
      color: #74787E;
      font-size: 15px;
      line-height: 18px;
    }
    
    .purchase_heading {
      padding-bottom: 8px;
      border-bottom: 1px solid #EDEFF2;
    }
    
    .purchase_heading p {
      margin: 0;
      color: #9BA2AB;
      font-size: 12px;
    }
    
    .purchase_footer {
      padding-top: 15px;
      border-top: 1px solid #EDEFF2;
    }
    
    .purchase_total {
      margin: 0;
      text-align: right;
      font-weight: bold;
      color: #2F3133;
    }
    
    .purchase_total--label {
      padding: 0 15px 0 0;
    }
    /* Utilities ------------------------------ */
    
    .align-right {
      text-align: right;
    }
    
    .align-left {
      text-align: left;
    }
    
    .align-center {
      text-align: center;
    }
    /*Media Queries ------------------------------ */
    
    @media only screen and (max-width: 600px) {
      .email-body_inner,
      .email-footer {
        width: 100% !important;
      }
    }
    
    @media only screen and (max-width: 500px) {
      .button {
        width: 100% !important;
      }
    }
    /* Buttons ------------------------------ */
    
    .button {
      background-color: #3869D4;
      border-top: 10px solid #3869D4;
      border-right: 18px solid #3869D4;
      border-bottom: 10px solid #3869D4;
      border-left: 18px solid #3869D4;
      display: inline-block;
      color: #FFF;
      text-decoration: none;
      border-radius: 3px;
      box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);
      -webkit-text-size-adjust: none;
    }
    
    .button--green {
      background-color: #22BC66;
      border-top: 10px solid #22BC66;
      border-right: 18px solid #22BC66;
      border-bottom: 10px solid #22BC66;
      border-left: 18px solid #22BC66;
    }
    
    .button--red {
      background-color: #FF6136;
      border-top: 10px solid #FF6136;
      border-right: 18px solid #FF6136;
      border-bottom: 10px solid #FF6136;
      border-left: 18px solid #FF6136;
    }
    /* Type ------------------------------ */
    
    h1 {
      margin-top: 0;
      color: #2F3133;
      font-size: 19px;
      font-weight: bold;
      text-align: left;
    }
    
    h2 {
      margin-top: 0;
      color: #2F3133;
      font-size: 16px;
      font-weight: bold;
      text-align: left;
    }
    
    h3 {
      margin-top: 0;
      color: #2F3133;
      font-size: 14px;
      font-weight: bold;
      text-align: left;
    }
    
    p {
      margin-top: 0;
      color: #74787E;
      font-size: 16px;
      line-height: 1.5em;
      text-align: left;
    }
    
    p.sub {
      font-size: 12px;
    }
    
    p.center {
      text-align: center;
    }
    </style>
  </head>
  <body>
    <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0">
            <!-- Email Body -->
            <tr>
              <td class="email-body" width="100%" cellpadding="0" cellspacing="0">
                <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0">
                  <!-- Body content -->
                  <tr>
                    <td class="content-cell">
                      <h1>Bienvenido a SEDRI</h1>
                      <p>Estimado usuario se le ha registrado una cuenta para acceder al sistema.</p>
                      <br> 
                      <p>Le damos una cordial bienvenida y esperamos ser de gran ayuda en sus labores como educador.</p><br>
                      <hr>
                      <strong> Use este código como contraseña de inicio temporal : '.$pass.'</strong></p>
                      <hr>
                     
                      <!-- Action -->
                      <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                         
                          <td align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td align="center">
                                  <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                    <td>
                                    <a href="#" class="button button--green" target="_blank">Ingresar</a>
                                  </td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>  
                                     
  </body>
</html>
                
                ';

                $mail->send();
          
            } catch (Exception $e) {
               echo ("Error");


            }


    }






    public function recuperarPassword($tipoemail,$destinatario,$pass){
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
      $mail->Subject = 'Recuperar contraseña en SEDRI';
      $mail->Body    = '
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style type="text/css" rel="stylesheet" media="all">
/* Base ------------------------------ */

*:not(br):not(tr):not(html) {
font-family: Arial,Helvetica Neue, Helvetica, sans-serif;
box-sizing: border-box;
}

body {
width: 100% !important;
height: 100%;
margin: 0;
line-height: 1.4;
background-color: #F2F4F6;
color: #74787E;
-webkit-text-size-adjust: none;
}

p,
ul,
ol,
blockquote {
line-height: 1.4;
text-align: left;
}

a {
color: white;
}

a img {
border: none;
}

td {
word-break: break-word;
}
/* Layout ------------------------------ */

.email-wrapper {
width: 100%;
margin: 0;
padding: 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
background-color: #F2F4F6;
}

.email-content {
width: 100%;
margin: 0;
padding: 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
}
/* Masthead ----------------------- */

.email-masthead {
padding: 25px 0;
text-align: center;
}

.email-masthead_logo {
width: 94px;
}

.email-masthead_name {
font-size: 16px;
font-weight: bold;
color: #bbbfc3;
text-decoration: none;
text-shadow: 0 1px 0 white;
}
/* Body ------------------------------ */

.email-body {
width: 100%;
margin: 0;
padding: 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
border-top: 1px solid #EDEFF2;
border-bottom: 1px solid #EDEFF2;
background-color: #FFFFFF;
}

.email-body_inner {
width: 570px;
margin: 0 auto;
padding: 0;
-premailer-width: 570px;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
background-color: #FFFFFF;
}

.email-footer {
width: 570px;
margin: 0 auto;
padding: 0;
-premailer-width: 570px;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
text-align: center;
}

.email-footer p {
color: #AEAEAE;
}

.body-action {
width: 100%;
margin: 30px auto;
padding: 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
text-align: center;
}

.body-sub {
margin-top: 25px;
padding-top: 25px;
border-top: 1px solid #EDEFF2;
}

.content-cell {
padding: 35px;
}

.preheader {
display: none !important;
visibility: hidden;
mso-hide: all;
font-size: 1px;
line-height: 1px;
max-height: 0;
max-width: 0;
opacity: 0;
overflow: hidden;
}
/* Attribute list ------------------------------ */

.attributes {
margin: 0 0 21px;
}

.attributes_content {
background-color: #EDEFF2;
padding: 16px;
}

.attributes_item {
padding: 0;
}
/* Related Items ------------------------------ */

.related {
width: 100%;
margin: 0;
padding: 25px 0 0 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
}

.related_item {
padding: 10px 0;
color: #74787E;
font-size: 15px;
line-height: 18px;
}

.related_item-title {
display: block;
margin: .5em 0 0;
}

.related_item-thumb {
display: block;
padding-bottom: 10px;
}

.related_heading {
border-top: 1px solid #EDEFF2;
text-align: center;
padding: 25px 0 10px;
}
/* Discount Code ------------------------------ */

.discount {
width: 100%;
margin: 0;
padding: 24px;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
background-color: #EDEFF2;
border: 2px dashed #9BA2AB;
}

.discount_heading {
text-align: center;
}

.discount_body {
text-align: center;
font-size: 15px;
}
/* Social Icons ------------------------------ */

.social {
width: auto;
}

.social td {
padding: 0;
width: auto;
}

.social_icon {
height: 20px;
margin: 0 8px 10px 8px;
padding: 0;
}
/* Data table ------------------------------ */

.purchase {
width: 100%;
margin: 0;
padding: 35px 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
}

.purchase_content {
width: 100%;
margin: 0;
padding: 25px 0 0 0;
-premailer-width: 100%;
-premailer-cellpadding: 0;
-premailer-cellspacing: 0;
}

.purchase_item {
padding: 10px 0;
color: #74787E;
font-size: 15px;
line-height: 18px;
}

.purchase_heading {
padding-bottom: 8px;
border-bottom: 1px solid #EDEFF2;
}

.purchase_heading p {
margin: 0;
color: #9BA2AB;
font-size: 12px;
}

.purchase_footer {
padding-top: 15px;
border-top: 1px solid #EDEFF2;
}

.purchase_total {
margin: 0;
text-align: right;
font-weight: bold;
color: #2F3133;
}

.purchase_total--label {
padding: 0 15px 0 0;
}
/* Utilities ------------------------------ */

.align-right {
text-align: right;
}

.align-left {
text-align: left;
}

.align-center {
text-align: center;
}
/*Media Queries ------------------------------ */

@media only screen and (max-width: 600px) {
.email-body_inner,
.email-footer {
width: 100% !important;
}
}

@media only screen and (max-width: 500px) {
.button {
width: 100% !important;
}
}
/* Buttons ------------------------------ */

.button {
background-color: #3869D4;
border-top: 10px solid #3869D4;
border-right: 18px solid #3869D4;
border-bottom: 10px solid #3869D4;
border-left: 18px solid #3869D4;
display: inline-block;
color: #FFF;
text-decoration: none;
border-radius: 3px;
box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);
-webkit-text-size-adjust: none;
}

.button--green {
background-color: #22BC66;
border-top: 10px solid #22BC66;
border-right: 18px solid #22BC66;
border-bottom: 10px solid #22BC66;
border-left: 18px solid #22BC66;
}

.button--red {
background-color: #FF6136;
border-top: 10px solid #FF6136;
border-right: 18px solid #FF6136;
border-bottom: 10px solid #FF6136;
border-left: 18px solid #FF6136;
}
/* Type ------------------------------ */

h1 {
margin-top: 0;
color: #2F3133;
font-size: 19px;
font-weight: bold;
text-align: left;
}

h2 {
margin-top: 0;
color: #2F3133;
font-size: 16px;
font-weight: bold;
text-align: left;
}

h3 {
margin-top: 0;
color: #2F3133;
font-size: 14px;
font-weight: bold;
text-align: left;
}

p {
margin-top: 0;
color: #74787E;
font-size: 16px;
line-height: 1.5em;
text-align: left;
}

p.sub {
font-size: 12px;
}

p.center {
text-align: center;
}
</style>
</head>
<body>
<table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0">
  <!-- Email Body -->
  <tr>
    <td class="email-body" width="100%" cellpadding="0" cellspacing="0">
      <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0">
        <!-- Body content -->
        <tr>
          <td class="content-cell">
            <h1>Recuperar contraseña</h1>
            <p>Se ha solicitado un cambio de contraseña, en el siguiente inicio deberá seleccionar una nueva contraseña</p>
            <br> 
            
            <hr>
            <strong> Use este código como contraseña de inicio temporal : '.$pass.'</strong></p>
            <hr>
            
            <!-- Action -->
            <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">
              <tr>
               
                <td align="center">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="center">
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                          <td>
                          <a href="{{route}}" class="button button--green" target="_blank">Ingresar</a>
                        </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>  
                             
</body>
</html>
      
      ';

      $mail->send();

  } catch (Exception $e) {
     echo ("Error");


  }


}


    


 }