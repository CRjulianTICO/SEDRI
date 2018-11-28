<?php require 'headerDirector.php' ?>

<div id="content">

<div id="divResp" class="card-panel green darken-2 white-text lighten-2"></div>
    <div id="tabla">
        <table id="tblMateria" class="display responsive nowrap tabla" style="width: 100%">
            <thead>
            <th data-priority="1">Código</th>
            <th data-priority="2">Materia</th>
            <th data-priority="2">Tipo de Materia</th>
            <th data-priority="3">Estado</th>
            <th data-priority="4">Editar</th>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>



    <div class="container">
        <div id="formulario">
            <form method="POST" id="formMateria" name="formMateria">
            
                <div class="row">
                    <div class="input-field col s6">
                        <label for ="idMateria">Código de la Materia</label>
                        <input placeholder="Codigo" class="validate" type="text" name="idmateria" id="idmateria" readonly="true"/>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6">
                        <input placeholder="Nombre" class="validate" type="text" name="nombreMateria" id="nombreMateria" required pattern="[A-Za-z0-9 ]{1,25}" title="No se pueden introducir caracteres especiales" />
                        <label for ="nombreMateria">Ingresar el Nombre de la Materia</label>
                    </div>
                    <div class="input-field col s6">
                    
                        <select id="tipoMateria" name="tipoMateria" class="browser-default"> </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col s4">
                        <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnGuardar">Guardar
                            <i class="material-icons right">done</i>
                            <br>
                        </button>
                    </div>

                    <div class="col s4">
                        <button name="editar" type="button" id="btnEditar" class="btn waves-effect waves-light blue editaEst">Editar
                            <i class="material-icons right">edit</i>
                        </button>
                    </div>
                    <div class="col s4">
                        <button class="btn waves-effect waves-light red cancelEst" name="eliminar" id="btnCancelar" type="button" onclick="cancelarFormulario();">Cancelar
                            <i class="material-icons right">clear</i>
                        </button>
                    </div>
                    
                </div>
                <br>

            </form>
        </div>
    </div>











</div>



<?php require 'footerDirector.php' ?>
<script src="js/materia.js"></script>
</body>

</html>