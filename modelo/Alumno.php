		<?php
		require_once "../config/Conexion.php";



		Class Alumno
		{
			//Implementamos nuestro constructor
			public function __construct()
			{

			}
			//Guardar  solo parametros necesarios para un estudiante
			public function insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad,$nota,$grado)
			{
				$sql="CALL `sp_InsertaAlumno`('$cedula','$nombre','$apellido1','$apellido2','$sexo','$direccion'
							,$nacionalidad,'$nota',$grado)";
					return consulta($sql);
			}
			public function listarGrados($idP){
            $sql = "SELECT pmg.id_grado,g.nombreGrado from profesor_materia_grado pmg, grado g, persona p, profesor pr WHERE p.idPersona = pr.Persona_idPersona and pr.idprofesor = pmg.profesor_idprofesor and g.idgrado = pmg.id_grado and p.idPersona = ".$idP;
            return consulta($sql);
      }
			public function cargarPais()
			{
				$sql= "SELECT * FROM `nacionalidad`";
				return consulta($sql);
			}
			public function actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$nacionalidad,$nota)
			{
				$sql="UPDATE `persona` SET
				`cedula` = '".$cedula."',
				`nombre` = '".$nombre."',
				`apellido1` = '".$apellido1."',
				`apellido2` = '".$apellido2."',
					`sexo` = '".$sexo."',
					`direccion` = '".$direccion."',
					`nota_medica` = '".$nota."'

					where cedula='".$cedula."';";

				return consulta($sql);
			}

			public function listar($idgrado)
			{
				if($idgrado==0){
					$sql="SELECT * FROM vista_alumno";
				}else{
					$sql="SELECT * FROM vista_alumno where idGrado='$idgrado';";
				}



				return consulta($sql);
			}

			public function desactivar($cedula){
				$sql = "UPDATE persona set disponible = '0' where cedula='".$cedula."';";
				return consulta($sql);
			}

			public function activar($cedula){
				$sql = "UPDATE persona set disponible = '1' where cedula='".$cedula."';";
				return consulta($sql);
			}

			public function cargar($cedula){
				$sql = "SELECT * FROM vista_alumno WHERE cedula='".$cedula."'";
				return consultaSimple($sql);
			}
			
			public function listarTodosAlumnos(){
				$sql = "SELECT * FROM vista_alumno";
				return consulta($sql);
			}

			public function listarAlumnos($grado)
			{

					$sql="SELECT a.idalumno,concat(p.nombre,' ',p.apellido1,' ',p.apellido2) as nombre
					FROM persona p,alumno a,grado_estudiante_nota gen
					where p.idPersona = a.Persona_idPersona and a.idalumno = gen.idEstudiante and gen.idGrado = $grado
					GROUP BY gen.idEstudiante;";


				return consulta($sql);
			}
			public function listarAlumnosEncargado($cedula,$grado){
				$sql="SELECT idalumno,nombre FROM vista_alumno_encargado where cedula='$cedula' GROUP BY idalumno;";
				return consulta($sql);
			}
			public function mostrarEncargado($cedula){
				$sql="SELECT * FROM mostrar_encargado where cedula_e = '$cedula';";
				return consulta($sql);
			}

		}

		?>
