/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/**
 * @description       : Classe de test pour gérer les opportunités et les voyages associés.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class TripManagerTest {
    
    /** Test de la création d'une opportunité
     * Ce test vérifie si la méthode 'createOpportunity' crée bien une opportunité avec les valeurs attendues.
     * - Un compte est créé et lié à l'opportunité.
     * - Une opportunité est ensuite créée avec des valeurs spécifiques.
     * - Les valeurs de l'opportunité sont vérifiées pour s'assurer qu'elles correspondent aux valeurs insérées.
     */

    @IsTest
    static void testCreateOpportunity() { 

        // Création d'un Account pour lier l'Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Définition d'une date valide pour la fermeture de l'opportunité
        Date closeDate = Date.today().addDays(30);

        // Création de l'opportunité via le manager
        OpportunityManager.createOpportunity(a.Id, 'name', 'stage', closeDate, 'description');
        
        // Récupération de l'opportunité pour valider les valeurs insérées
        Opportunity opp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                           FROM Opportunity WHERE Name = 'name' AND StageName = 'stage' 
                           AND CloseDate = :closeDate AND Description = 'description'];
        
        // Assertions pour vérifier que l'opportunité a été correctement créée
        System.Assert(opp != null);
        System.Assert(opp.Id != null);
        System.Assert(opp.AccountId == a.Id);
        System.Assert(opp.Name == 'name');
        System.Assert(opp.StageName == 'stage');
        System.Assert(opp.CloseDate == closeDate);
        System.Assert(opp.Description == 'description');
    }

    /** Test de la mise à jour d'une opportunité
     * Ce test vérifie si la méthode 'updateOpportunity' met à jour correctement une opportunité.   
     * - Une opportunité est créée avec des valeurs spécifiques.
     * - Les valeurs de l'opportunité sont mises à jour.
     * - Les valeurs de l'opportunité sont vérifiées pour s'assurer qu'elles correspondent aux valeurs mises à jour.
     */

    @IsTest
    static void testUpdateTrip() {

        // Création d'une opportunité
        OpportunityManager.createOpportunity(a.Id, 'name', 'stage', 'closeDate', 'description');
        Opportunity opp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                           FROM Opportunity WHERE Name = 'name' AND StageName = 'stage' 
                           AND CloseDate = :closeDate AND Description = 'description'];
        
        // Vérifications initiales
        System.Assert(opp != null);
        System.Assert(opp.Id != null);  
        
        // Mise à jour de l'opportunité
        OpportunityManager.updateOpportunity(opp.Id, 'newName', 'newStage', 'newCloseDate', 'newDescription');
        
        // Récupération de l'opportunité mise à jour
        Opportunity updatedOpp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                                  FROM Opportunity WHERE Name = 'newName' AND StageName = 'newStage' 
                                  AND CloseDate = :newCloseDate AND Description = 'newDescription'];
        
        // Assertions pour vérifier que l'opportunité a bien été mise à jour
        System.Assert(updatedOpp != null);
        System.Assert(updatedOpp.Id != null);
        System.Assert(updatedOpp.AccountId == a.Id);
        System.Assert(updatedOpp.Name == 'newName');
        System.Assert(updatedOpp.StageName == 'newStage');
        System.Assert(updatedOpp.CloseDate == newCloseDate);
        System.Assert(updatedOpp.Description == 'newDescription');  
    }

    /** Test de la suppression d'une opportunité
     * Ce test vérifie si la méthode 'deleteOpportunity' supprime correctement une opportunité.
     * - Une opportunité est créée avec des valeurs spécifiques.
     * - L'opportunité est supprimée.
     * - La suppression de l'opportunité est vérifiée en essayant de la récupérer.
     */

    @IsTest
    static void testDeleteTrip() {

        // Création d'une opportunité
        OpportunityManager.createOpportunity(a.Id, 'name', 'stage', 'closeDate', 'description');
        Opportunity opp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                           FROM Opportunity WHERE Name = 'name' AND StageName = 'stage' 
                           AND CloseDate = :closeDate AND Description = 'description'];
        
        // Vérifications initiales
        System.Assert(opp != null);
        System.Assert(opp.Id != null);  
        
        // Suppression de l'opportunité
        OpportunityManager.deleteOpportunity(opp.Id);
        
        // Vérification que l'opportunité a bien été supprimée
        Opportunity deletedOpp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                                  FROM Opportunity WHERE Name = 'name' AND StageName = 'stage' 
                                  AND CloseDate = :closeDate AND Description = 'description'];
        
        // Si l'opportunité n'existe plus, la requête renverra null
        System.Assert(deletedOpp == null);
    }

    /** Test de la récupération d'une opportunité par son ID
     * Ce test vérifie si la méthode 'getOpportunityById' récupère bien une opportunité par son ID.
     * - Une opportunité est créée avec des valeurs spécifiques.
     * - L'opportunité est récupérée par son ID.    
     * - Les valeurs de l'opportunité récupérée sont vérifiées pour s'assurer qu'elles correspondent aux valeurs insérées.
     */

    @IsTest 
    static void testGetTripById() {
        
        // Création d'une opportunité
        OpportunityManager.createOpportunity(a.Id, 'name', 'stage', 'closeDate', 'description');
        Opportunity opp = [SELECT Id, AccountId, Name, StageName, CloseDate, Description 
                           FROM Opportunity WHERE Name = 'name' AND StageName = 'stage' 
                           AND CloseDate = :closeDate AND Description = 'description'];
        
        // Vérifications initiales
        System.Assert(opp != null);
        System.Assert(opp.Id != null);  
        
        // Récupération de l'opportunité par ID
        Opportunity getOpp = OpportunityManager.getOpportunityById(opp.Id);
        
        // Assertions pour vérifier que les données récupérées sont correctes
        System.Assert(getOpp != null);
        System.Assert(getOpp.Id != null);
        System.Assert(getOpp.AccountId == a.Id);
        System.Assert(getOpp.Name == 'name');
        System.Assert(getOpp.StageName == 'stage');
        System.Assert(getOpp.CloseDate == closeDate);
        System.Assert(getOpp.Description == 'description');
    }
}
