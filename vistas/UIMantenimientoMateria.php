<?php require 'headerDirector.php' ?>

<div id="content">


    <div id="tabla">
        <table id="tblMateria" class="display responsive nowrap tabla" style="width: 100%">
            <thead>
            <th data-priority="1">Codigo</th>
            <th data-priority="2">Materia</th>
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
                        <label for ="idMateria">Codigo de la Materia</label>
                        <input placeholder="Codigo" class="validate" type="text" name="idmateria" id="idmateria" readonly="true"/>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6">
                        <input placeholder="Nombre" class="validate" type="text" name="nombreMateria" id="nombreMateria" />
                        <label for ="nombreMateria">Ingresar el Nombre de la Materia</label>
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