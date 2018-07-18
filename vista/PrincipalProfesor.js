
function cargarTabla(){
	var division = document.getElementById("divTablaAsistencia");
    division.innerHTML='';

    //Se usa Ajax para enviar los valores
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            document.getElementById("divTablaEstudiante").innerHTML = xhr.responseText;
       }else{
           division.innerHTML+=xhr.status;
           division.innerHTML+=xhr.readyState;
       }
    };
    xhr.open("GET", "../modelo/PrincipalProfesorTabla.php", true);
    xhr.send(null);

}