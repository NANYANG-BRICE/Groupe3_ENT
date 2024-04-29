// var token = '[[${accessToken}]]'
var fileName = 'load'
var listeObjets = [];


$(document).ready(function () {
    listeIntervention();
    $('#yourFormId').submit(function (event) {
        event.preventDefault();
        var codeEtudiant = 1
        var idCategorie = 2
        poserintervention(codeEtudiant, idCategorie);
    });

});

$('#intervention').change(
    function () {
        var idCategorie = $(this).val();
        listesousIntervention(idCategorie)
    }
);

$('#file').change(function (event) {
    loadFile(event);
});



function chargerOptionsSelectIntervention(liste, id) {
    var select = $(id);
    $.each(liste, function (index, objet) {
        select.append('<option value="' + objet.idCategorie + '">' + objet.intituleCategorie + '</option>');
    });
}

function chargerOptionsSelectSIntervention(liste, id) {
    var select = $(id);
    select.empty();
    $.each(liste, function (index, objet) {
        select.append('<option value="' + objet.idSousIntervention + '">' + objet.intituleSousIntervention + '</option>');
    });
}

function listeIntervention() {
    $.ajax({
        url: 'http://localhost:9090/api/interventions/categorie/Liste',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            listeObjets = data
            chargerOptionsSelectIntervention(listeObjets, '#intervention');
        },
        error: function (xhr, status, error) {
            console.error('Erreur lors de la requête API:', status, error);
        }
    });
}


function listesousIntervention(idCategorie) {
    $.ajax({
        url: 'http://localhost:9090/api/interventions/categorie/sousIntervention/' + idCategorie,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            listeObjets = data
            chargerOptionsSelectSIntervention(listeObjets, '#sous-intervention');
        },
        error: function (xhr, status, error) {
            console.error('Erreur lors de la requête API:', status, error);
        }
    });
}

var selectedFiles
function loadFile(event) {
    selectedFiles = event.target.files;
    console.log(selectedFiles);

    if (selectedFiles.length > 0) {
        fileName = selectedFiles[0].name + " ' et " + (selectedFiles.length - 1) + " autres fichier(s)'";
        console.log(fileName);
        $('#download').text(fileName);
    }
}


function poserintervention(codeEtudiant, idCategorie, dataS) {
    var url = 'http://localhost:9090/api/interventions/soumettre/' + codeEtudiant + '/' + idCategorie;
    Swal.fire({
        title: "Requête en cours",
        html: "Veuillez patienter quelques instants...",
        showConfirmButton: false,
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    $.ajax({
        url: url,
        type: 'POST',
        data: dataS,
        processData: false,
        contentType: false,
        success: function (data) {
            Swal.fire({
                hideOnOverlayClick: false,
                hideOnContentClick: false,
                allowOutsideClick: false,
                title: "Félicitations",
                html: "Nous sommes heureux de vous annoncer que votre demande d'intervention a bien été soumise.",
                showConfirmButton: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.reload();
                }
                Swal.close();
            });
        },
        error: function (xhr, status, error) {
            console.error('Erreur lors de la requête API:', status, error);
            Swal.fire({
                hideOnOverlayClick: false,
                hideOnContentClick: false,
                title: "Opération Impossible",
                html: "Nous sommes désolés de vous l'annoncer, mais votre demande d'intervention n'a pas pu être soumise.",
                showConfirmButton: true,
            }).then(() => {
                Swal.close();
            });
        }
    });
}



$(document).ready(function () {
    $('#envoyer').on('click', function (e) {
        var intervention = document.getElementById('intervention').value;
        var idSousIntervention = document.getElementById('sous-intervention').value;
        var DescriptionIntervention = document.getElementById('exampleInputUsername1').value;

        if (intervention == '' || idSousIntervention == '' || DescriptionIntervention == '') {
            Swal.fire({
                title: "Données Absentes.",
                confirmButtonText: "Continuer",
                html: "Nous sommes désolés de vous l'annoncer, mais vous devez remplir tous les champs, sauf la <b>Pièce Jointe</b> qui est facultative."
            });
        } else {
            var formData = new FormData();
            formData.append('intervention', intervention);
            formData.append('idSousIntervention', idSousIntervention);
            formData.append('DescriptionIntervention', DescriptionIntervention);

            for (var key in selectedFiles) {
                if (selectedFiles.hasOwnProperty(key)) {
                    var file = selectedFiles[key];
                    formData.append('pieceJointe', file);
                    console.log(file)
                }
            }

            Swal.fire({
                hideOnOverlayClick: false,
                hideOnContentClick: false,
                title: "Êtes-vous sûr(e)?",
                html: "Souhaitez-vous réellement soumettre cette demande d'intervention ?",
                showDenyButton: true,
                showCancelButton: false,
                confirmButtonText: "Continuer",
                denyButtonText: "Annuler"
            }).then((result) => {
                if (result.isConfirmed) {
                    poserintervention(matricule, intervention, formData);
                }
            });
        }
    });
});
