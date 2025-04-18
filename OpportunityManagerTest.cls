/**
 * @description       : Classe de test pour les opérations de gestion des opportunités dans OpportunityManager
 * 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/**
 * @description       : Test class for OpportunityManager operations
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OpportunityManagerTest {

    /** Test de la création d'une opportunité.
     * Ce test vérifie si la méthode 'createOpportunity' crée bien une opportunité avec les valeurs attendues.
     * - Un compte est créé et lié à l'opportunité.
     * - Une opporunité est ensuite créée avec des valeurs spécifiques.
     * - Les valeurs de l'opportunité sont vérifiées pour s'assurer qu'elles correspondent aux valeurs insérées.
     */

    @IsTest
    static void TestCreateOpportunity() {

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
        System.Assert(opp != null);
        System.Assert(opp.Id != null);
        System.Assert(opp.AccountId == a.Id);
        System.Assert(opp.Name == 'name');
        System.Assert(opp.StageName == 'stage');
        System.Assert(opp.CloseDate == closeDate);
        System.Assert(opp.Description == 'description');
    }

    /** Test de la récupération d'une opportunité par ID.
     * Ce test vérifie si la méthode 'getOpportunityById' récupère bien une opportunité par son ID.
     * - Un compte est créé et lié à l'opportunité.
     * - Une opportunité est créée avec des valeurs spécifiques.
     * - L'opportunité est récupérée par son ID.
     * - Les valeurs de l'opportunité récupérée sont vérifiées pour s'assurer qu'elles correspondent aux valeurs insérées.
     */

    @IsTest
    static void TestgetOpportunityById() {

        // Création d'un Account et d'une Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Date closeDate = Date.today().addDays(30);
        Id oppId = OpportunityManager.createOpportunity(a.Id, 'name', 'stage', closeDate, 'description');
        
        // Récupération de l'opportunité par ID
        Opportunity opp = OpportunityManager.getOpportunityById(oppId);
        
        // Assertions pour vérifier que l'opportunité récupérée correspond aux attentes
        System.Assert(oppId == opp.Id);
        System.Assert('name' == opp.Name);
        System.Assert('stage' == opp.StageName);
        System.Assert(closeDate == opp.CloseDate);
        System.Assert('description' == opp.Description);
    }

    /** Test de la mise à jour d'une opportunité.
     * Ce test vérifie si la méthode 'updateOpportunity' met à jour correctement une opportunité.   
     * - Un compte est créé et lié à l'opportunité.
     * - La méthode 'createOpportunity' est utilisée pour créer une opportunité.
     * - La méthode 'updateOpportunity' est utilisée pour mettre à jour l'opportunité.  
     * - Le test vérifie que les nouvelles valeurs sont correctement enregistrées.
     */

    @IsTest
    static void TestupdateOpportunity() {

        // Création d'un Account et d'une Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Date closeDate = Date.today().addDays(30);
        Id oppId = OpportunityManager.createOpportunity(a.Id, 'name', 'stage', closeDate, 'description');
        
        // Mise à jour de l'opportunité
        OpportunityManager.updateOpportunity(oppId, 'newName', 'newStage', Date.today().addDays(60), 'newDescription');
        
        // Récupération de l'opportunité mise à jour et vérification des valeurs
        Opportunity updatedOpp = OpportunityManager.getOpportunityById(oppId);
        System.Assert('newName' == updatedOpp.Name);
        System.Assert('newStage' == updatedOpp.StageName);
        System.Assert(Date.today().addDays(60) == updatedOpp.CloseDate);
        System.Assert('newDescription' == updatedOpp.Description);
    }

    /** Test de la suppression d'une opportunité.
     * Ce test vérifie si la méthode 'deleteOpportunity' supprime correctement une opportunité. 
     * - Un compte est créé et lié à l'opportunité.
     * - La méthode 'createOpportunity' est utilisée pour créer une opportunité.
     * - La méthode 'deleteOpportunity' est utilisée pour supprimer l'opportunité.      
     * - Un compte est créé et lié à l'opportunité. 
     * - Le test vérifie que l'opportunité a bien été supprimée.
     */

    @IsTest
    static void TestdeleteOpportunity() {
        
        // Création d'un Account et d'une Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Date closeDate = Date.today().addDays(30);
        Id oppId = OpportunityManager.createOpportunity(a.Id, 'name', 'stage', closeDate, 'description');
        
        // Suppression de l'opportunité
        OpportunityManager.deleteOpportunity(oppId);
        
        // Vérification que l'opportunité a bien été supprimée
        try {
            Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :oppId];
            System.Assert(false, 'The opportunity should have been deleted');
        } catch (QueryException e) {
            System.Assert(true, 'The opportunity has been deleted');
        }
    }
}
