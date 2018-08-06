<?php

require('../config/Conexion.php');

$query="Select CONCAT(apellido1, ' ',apellido2) as Apellidos, nombre from vista_alumno;";

$resultado=consulta($query);

if ($resultado->num_rows > 0) {
    echo"<table>
         <thead>
         <tr>
            <th>Apellidos</th>
            <th>Nombre</th>
        </tr>
        </thead>
        <tbody>";
    while($row = $resultado->fetch_assoc()) {
        echo"<tr>
                <td>".$row[Apellidos]."</td>
                <td>".$row[nombre]."</td>
            </tr>";
          
    }
    echo "</tbody>
          </table>";
}else{
    echo"<h1>Error al cargar la tabla. No se encontraron datos</h1>
        <br>
        <table>
        <thead>
        <tr>
            <th>Apellidos</th>
            <th>Nombre</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>Alvin</td>
            <td>Eclair</td>
        </tr>
        <tr>
            <td>Alan</td>
            <td>Jellybean</td>
        </tr>
        <tr>
            <td>Jonathan</td>
            <td>Lollipop</td>
        </tr>
        </tbody>
    </table>";
}
?>