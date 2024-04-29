package org.institutsaintjean.intervention.gestionDesInterventions.Controllers;

import javax.persistence.EntityNotFoundException;

import org.institutsaintjean.intervention.gestionDesInterventions.Entities.*;
import org.institutsaintjean.intervention.gestionDesInterventions.Enumerations.Statut;
import org.institutsaintjean.intervention.gestionDesInterventions.Repositories.*;
import org.institutsaintjean.intervention.gestionDesInterventions.Services.InterventionService;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import java.io.ByteArrayInputStream;

import java.io.IOException;

import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin("*")
@RestController
public class InterventionControler {

    @Autowired
    private InterventionService interventionService;

    @Autowired
    private InterventionRepository interventionRepository;

    @Autowired
    private DepartementRepository departementRepository;

    @Autowired
    private EtudiantRepository etudiantRepository;

    @Autowired
    private PersonnelRepository personnelRepository;

    @Autowired
    private PieceJointeRepository pieceJointeRepository;





    @PostMapping(value = "/soumettre/{codeEtudiant}/{idCategorie}")
    public Intervention creerIntervention(@PathVariable("codeEtudiant") Long codeEtudiant,
                                          @PathVariable("idCategorie") Long idCategorie,
                                          @RequestParam(value = "pieceJointe",required = false)   List<MultipartFile> fichiers,
                                          @RequestParam(value = "file",required = false)  String file,
                                          @RequestParam(value = "DescriptionIntervention",required = false)  String DescriptionIntervention,
                                          @RequestParam(value = "idSousIntervention",required = false)  Long idSousIntervention
    )  {
        // Vérification du type de fichier
        if (fichiers != null && !fichiers.isEmpty()) {
            List<MultipartFile> invalidFiles = fichiers.stream()
                    .filter(fichier -> !fichier.getContentType().equals("image/png") && !fichier.getContentType().equals("image/jpeg") && !fichier.getContentType().equals("image/jpg"))
                    .collect(Collectors.toList());

            if (!invalidFiles.isEmpty()) {
                throw new IllegalArgumentException("Only image files in PNG, JPG, and JPEG formats are allowed.");
            }
        }

        return interventionService.creerIntervention(codeEtudiant, idCategorie, fichiers,file,DescriptionIntervention, idSousIntervention);
    }


    @GetMapping("/Liste/Departement/{idPersonnel}/{statut}")
    public List<Intervention> ListeInterventionParDepartement(@PathVariable Long idPersonnel,
                                                              @PathVariable Statut statut) {
        Personnel personnel = personnelRepository.findByIdPersonnel(idPersonnel);
        Departement departement = departementRepository
                .findDepartementByIdDepartement(personnel.getDepartement().getIdDepartement());
        return interventionRepository.findByDepartementAndStatut(departement, statut);

    }

    @GetMapping("/Liste/etudiant/{codeEtudiant}")
    public List<Intervention> ListeInterventionParEtudiant(@PathVariable long codeEtudiant) {
        Etudiant etudiant = etudiantRepository.findByCode(codeEtudiant);
        return interventionRepository.findByEtudiant(etudiant);
    }

    @GetMapping("/one/etudiant/{interventionId}")
    public Intervention InfosDuneIntervention(@PathVariable long interventionId) {
        Intervention intervention = interventionService.singleIntervention(interventionId);
        return intervention;
    }

    @GetMapping("/Liste/Departement/{idPersonnel}")
    public List<Intervention> ListeInterventionParDepartement(@PathVariable long idPersonnel) {
        Personnel personnel = personnelRepository.findByIdPersonnel(idPersonnel);
        Departement departement = departementRepository
                .findDepartementByIdDepartement(personnel.getDepartement().getIdDepartement());
        return interventionRepository.findByDepartement(departement);
    }

    @PutMapping("/prendre-en-charge/{interventionId}/{personnelId}")
    public Intervention prendreEnChargeIntervention(
            @PathVariable("interventionId") Long interventionId,
            @PathVariable("personnelId") Long personnelId) {
        return interventionService.prendreEnChargeIntervention(interventionId, personnelId);
    }

    @PutMapping("/Termine/{interventionId}")
    public Intervention finDeTraitementDuneIntervention(@PathVariable("interventionId") Long interventionId,
                                                        @RequestParam(value = "emailContetnt", required = false) String emailContent,
                                                        @RequestParam(value = "piecesJointes", required = false) List<MultipartFile> piecesJointes) {
        return interventionService.terminerUneIntervention(interventionId, emailContent, piecesJointes);
    }

    @GetMapping("/personnel/{personnelId}/statut/{statut}")
    public List<Intervention> ListeInterventionDuPersonneParStatut(
            @PathVariable Long personnelId,
            @PathVariable Statut statut) {
        Personnel personnel = personnelRepository.findById(personnelId)
                .orElseThrow(() -> new EntityNotFoundException("Personnel introuvable."));
        return interventionRepository.findByPersonnelAndStatut(personnel, statut);
    }

    @GetMapping("/Etudiant/{codeEtudiant}/statut/{statut}")
    public List<Intervention> ListeInterventionDeLetudiantParStatut(
            @PathVariable Long codeEtudiant,
            @PathVariable Statut statut) {
        Etudiant etudiant = etudiantRepository.findById(codeEtudiant)
                .orElseThrow(() -> new EntityNotFoundException("Etudiant introuvable"));
        return interventionRepository.findByEtudiantAndStatut(etudiant, statut);
    }

    @PostMapping("/cancel/{interventionId}")
    public ResponseEntity<String> cancelIntervention(@PathVariable Long interventionId) {
        try {
            interventionService.cancelIntervention(interventionId);
            return ResponseEntity.ok("Intervention annulée avec succès.");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/pieceJointe/{idPieceJointe}")
    public PieceJointe pieceJointeByIdPiecejointe(@PathVariable long idPieceJointe) {
        return pieceJointeRepository.findByIdPieceJointe(idPieceJointe);
    }

}