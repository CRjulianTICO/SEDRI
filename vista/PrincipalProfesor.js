
function mostrarTablaEstudiantes(){
	var division = document.getElementById("divTablaEstudiante");
    division.innerHTML='';

    //Se usa Ajax para enviar los valores
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("divEncuestadivTablaEstudiante").innerHTML = xhr.responseText;
       }
    };
    xhr.open("GET", "PrincipalProfesorTabla.php", true);
    xhr.send();

}