function showAlert(element) {
    var interventionId = element.getAttribute('data-id');
    console.log(element);
    console.log("ID de l'intervention : " + interventionId);

    $('#float-input').val(`Cher(e) étudiant(e),

    Nous sommes heureux de vous informer que le traitement de votre demande d'intervention a été terminé avec succès.

    Nous espérons que le problème pour lequel vous avez demandé de l'aide a été résolu de manière satisfaisante. 
    Si vous avez d'autres questions ou préoccupations, n'hésitez pas à nous contacter à tout moment.
    
    Merci pour votre collaboration.
    
    Cordialement,
    Le département
    INSTITUT UNIVERSITAIRE SAINT JEAN`);
}

function repondreIntervention(idIntervention, dataS) {
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
        url: 'http://localhost:9090/api/interventions/Termine/' + idIntervention,
        type: 'PUT',
        data: dataS,
        processData: false,
        contentType: false,
        success: function (data) {
            Swal.fire({
                title: "Félicitations",
                html: "Nous sommes heureux de vous annoncer que vous avez bien finalisé cette demande d'intervention.",
                showConfirmButton: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.reload();
                }
            });
        },
        error: function (xhr, status, error) {
            console.error('Erreur lors de la requête API:', status, error);
            Swal.fire({
                title: "Opération Impossible",
                html: "Nous sommes désolés de vous l'annoncer, mais votre requête de finalisation de cette intervention n'a pas pu aboutir.",
                showConfirmButton: true,
            });
        }
    });
}

$('#finaliser-demande').on('click', function (e) {
    var emailContent = $('#intervention').val();
    var idInt = $("#intervention-end-id").val();

    if (emailContent === '' || idInt === ''){
        Swal.fire({
            title: "Données Absentes.",
            confirmButtonText: "Continuer",
            html: "Nous sommes désolés de vous l'annoncer, mais vous devez renseigner une description avant de continuer."
        });
    } else {
        var formData = new FormData();
        formData.append('emailContent', emailContent);
        for (var key in selectedFiles) {
            if (selectedFiles.hasOwnProperty(key)) {
                var file = selectedFiles[key];
                formData.append('pieceJointes', file);
                console.log(file)
            }
        }

        Swal.fire({
            title: "Êtes-vous sûr(e)?",
            html: "Souhaitez-vous réellement finaliser cette demande d'intervention ?",
            showDenyButton: true,
            showCancelButton: false,
            confirmButtonText: "Continuer",
            denyButtonText: "Annuler"
        }).then((result) => {
            if (result.isConfirmed) {
                repondreIntervention(parseInt(idInt), formData);
            }
        });
    }
});

// Associer l'événement de changement de fichier à la fonction loadFileS
$('#files').change(function (event) {
    loadFileS(event);
});

function loadFileS(event) {
    if (event && event.target && event.target.files) {
        selectedFiles = event.target.files;
        console.log(selectedFiles);

        if (selectedFiles.length > 0) {
            var fileName = selectedFiles[0].name + " et " + (selectedFiles.length - 1) + " autres fichier(s)";
            console.log(fileName);
            $('#downloads').text(fileName);
        } else {
            console.log("Aucun fichier sélectionné.");
            $('#downloads').text("Aucun fichier sélectionné.");
        }
    } else {
        console.log("L'événement est invalide ou ne contient pas de fichier.");
        $('#downloads').text("L'événement est invalide.");
    }
}
