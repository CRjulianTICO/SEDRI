<?php 


	require_once('conexion/conexion.php');	

$cedula=$_POST["cedula"];

	$usuario = 'select vn1.cedula,vn1.materia,concat(vn1.nombre," ",vn1.apellido1," ",vn1.apellido2) as nombre,vn1.total as total1,vn2.total as total2,vn3.total as total3 
from vista_notas vn1,vista_notas vn2,vista_notas vn3 
where vn1.trimestre = 1 and vn2.trimestre = 2 and vn3.trimestre = 3 and vn1.cedula = "'.$cedula.'"  and vn1.cedula = vn2.cedula and vn1.cedula = vn3.cedula and vn1.materia = vn2.materia and vn2.materia = vn3.materia';	
$usuarios=$mysqli->query($usuario);

$alumno = $mysqli->query("
select p.cedula,concat(p.nombre,' ',p.apellido1,' ',p.apellido2) as nombre,g.annio,g.nombreGrado 
from persona p,grado g,alumno a,grado_estudiante_nota gen
where p.idPersona = a.Persona_idPersona and a.idalumno = gen.idEstudiante and g.idgrado = gen.idGrado and p.cedula = '".$cedula."'
group by p.cedula;");
$resultado = mysqli_fetch_assoc($alumno);

$nombre= $resultado['nombre'];
$cedula= $resultado['cedula'];
$annio= $resultado['annio'];
$nombreGrado= $resultado['nombreGrado'];
//$cedula= $alumno->fetch_object()->nombre;
// $annio= $alumno->fetch_object()->annio;
// $nombreGrado= $alumno->fetch_object()->nombre;

$totalA = $mysqli->query("select count(*) as ausencias from vista_asistencia where cedula = '".$cedula."' and ESTADO=0;")->fetch_object()->ausencias;
$totalI = $mysqli->query("select count(*) as injustificadas from vista_asistencia where cedula = '".$cedula."' and ESTADO=0 and AUSENCIA = 0;")->fetch_object()->injustificadas;
$totalJ = $mysqli->query("select count(*)  as justificadas from vista_asistencia where cedula = '".$cedula."' and ESTADO=0 and AUSENCIA = 1")->fetch_object()->justificadas;
	require_once('tcpdf/tcpdf.php');
	
	$pdf = new TCPDF('P', 'mm', 'A4', true, 'UTF-8', false);
	
	$pdf->SetCreator(PDF_CREATOR);
	$pdf->SetAuthor('SEDRI');
	$pdf->SetTitle('Nota');
	
	$pdf->setPrintHeader(false); 
	$pdf->setPrintFooter(false);
	$pdf->SetMargins(20, 0, 20, false); 
	$pdf->SetAutoPageBreak(true, 20); 
	$pdf->SetFont('Helvetica', '', 10);
	$pdf->addPage();

	$content = '';
	
	$content .= '
  <div class="row">
  <h1>
  </div>
		<div class="row">
        	<div class="col-md-12">

            <div class="col-md-12">
              <h1 style="text-align:center;">República de Costa Rica</h1>
              <h1 style="text-align:center;">Ministerio de Educación Pública</h1>
              <h3 style="text-align:center;">Dirección regional Desamparados Circuito 03</h3>
              <h3 style="text-align:center;">Escuela de Tranquerillas</h3>
              <h3 style="text-align:center;">Informe de notas al hogar</h3>
               <h3 style="text-align:center;">'.$annio.'</h3>
            </div>
            <br>

        <table border="1" cellpadding="5">
        <thead>
          <tr>
            <th>Estudiante : '.$nombre.'</th>
            <th>Cédula : '.$cedula.'</th>
            <th>Sección : '.$nombreGrado.'</th>
           
          </tr>
        </thead>
        </table>
             

             
       	
      <table border="1" cellpadding="5">
        <thead>
          <tr>
            <th>Materia</th>
            <th>I</th>
            <th>II</th>
            <th>III</th>
            <th>Resultado Final</th>
            <th>Condición</th>
          </tr>
        </thead>
	';
	
	
	while ($user=$usuarios->fetch_assoc()) { 
	
    $total = $user['total1']+$user['total2']+$user['total3'];
    $total = $total/3;
    $var = number_format((float)$total, 2, '.', '');
    $condicion=($var>=65.00)?"Aprobado":"Reprobado";
	$content .= '
		<tr>
            <td>'.$user['materia'].'</td>
            <td>'.$user['total1'].'</td>
            <td>'.$user['total2'].'</td>
            <td>'.$user['total3'].'</td>
            <td>'.$var.'</td>
            <td>'.$condicion.'</td>
        </tr>
	';
	}
	
	$content .= '</table>';
	
	$content .= '
		<div class="row padding">

      <table border="1" cellpadding="5">
        <thead>
          <tr>
            <th>Total de Ausencias</th>
            <th>Justificadas</th>
            <th>Injustificadas </th>
          </tr>
        </thead>
        <tr>
            <td>'.$totalA.'</td>
            <td>'.$totalI.'</td>
            <td>'.$totalJ.'</td>
        </tr>
        </table>
        	
        </div>
    	
	';
	
	$pdf->writeHTML($content, true, 0, true, 0);

	$pdf->lastPage();
	ob_end_clean();
	$pdf->output('Reporte.pdf', 'I');


?>
		 
		 