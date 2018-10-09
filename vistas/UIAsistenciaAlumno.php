<?php 
require 'header.php';
?>

<div id="content">

<div id="tabla">
    <table id="tbAlumno" class="display responsive nowrap tabla responsive-table highlight" style="width: 100%">
        <thead>
          <th data-priority="1">Cedula</th>
          <th data-priority="2">Nombre</th>
          <th data-priority="4">Primer Apellido</th>
          <th data-priority="5">Segundo Apellido</th>
          <th data-priority="3">Grado</th>
          <th>Presente/Ausente</th>
          <th>Nota</th>
        </thead>
        <tbody>
            <tr>
                <td>305080238</td>
                <td>Julian</td>
                <td>Perez</td>
                <td>Fernandez</td>
                <td>Quinto</td>
                <td>
                    <div>
                        <input type="checkbox" id="check">
                        <label for="check" id="ckPre">ausente</label>
                    </div>
                </td>
                <td>
                    <div class="input-field inline">
                        <input id="email_inline" type="email" class="validate">
                         <label for="email_inline">Nota</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>305080238</td>
                <td>Julian</td>
                <td>Perez</td>
                <td>Fernandez</td>
                <td>Quinto</td>
                <td>
                    <div>
                        <input type="checkbox" id="check2">
                        <label for="check2" id="ckPre">ausente</label>
                    </div>
                </td>
                <td>
                    <div class="input-field inline">
                        <input id="email_inline" type="email" class="validate">
                         <label for="email_inline">Nota</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>305080238</td>
                <td>Julian</td>
                <td>Perez</td>
                <td>Fernandez</td>
                <td>Quinto</td>
                <td>
                    <div>
                        <input type="checkbox" id="check1">
                        <label for="check1" id="ckPre"></label>
                    </div>
                </td>
                <td>
                    <div class="input-field inline">
                        <input id="email_inline" type="email" class="validate">
                         <label for="email_inline">Nota</label>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>




<?php require 'footer.php' ?>
<script src="js/alumno.js"></script>
</body>

</html>