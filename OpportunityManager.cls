/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OpportunityManager {

    // Créer une vente  
    @AuraEnabled
    public static Opportunity createOpportunity(Id accounId, String opportunityName, String stageName, String closeDate) {
        System.debug('OpportunityManager.createOpportunity');

        // Verifier AccountId n'est pas null
        if (accounId == null) {
            throw new AuraHandledException('Account ID is required');
        }

        // Verifier que le nom de l'opportunité n'est pas null
        if (String.isBlank(opportunityName)) {
            throw new AuraHandledException('Opportunity Name is required');
        }

        // Verifier que le nom de la vente n'est pas null
        if (String.isBlank(stageName)) {
            throw new AuraHandledException('Stage Name is required');
        }

        // Verifier que la date de fin n'est pas null
        if (String.isBlank(closeDate)) {
            throw new AuraHandledException('Close Date is required');
        }

        // Créer la vente
        System.debug('AccountId = ' + accounId);
        System.debug('Opportunity Name = ' + opportunityName);
        Opportunity opp = new Opportunity();
        opp.Name = opportunityName;
        opp.StageName = stageName;
        opp.CloseDate = Date.valueOf(closeDate);
        insert opp;
        return opp;
    }
    
    // Mettre à jour une vente
    @AuraEnabled
    public static Opportunity updateOpportunity(Id opportunityId, String opportunityName, String stageName, String closeDate) {
        System.debug('OpportunityManager.updateOpportunity');

        // Verifier que l'ID de l'opportunité n'est pas null
        if (opportunityId == null) {
            throw new AuraHandledException('Opportunity ID is required');
        }

        // Verifier que le nom de l'opportunité n'est pas null
        if (String.isBlank(opportunityName)) {
            throw new AuraHandledException('Opportunity Name is required');
        }

        // Verifier que le nom de la vente n'est pas null   
        if (String.isBlank(stageName)) {
            throw new AuraHandledException('Stage Name is required');
        }

        // Verifier que la date de fin n'est pas null
        if (String.isBlank(closeDate)) {
            throw new AuraHandledException('Close Date is required');
        }

        // Mettre à jour la vente
        Opportunity opp = getOpportunityById(opportunityId);
        opp.Name = opportunityName;
        opp.StageName = stageName;
        opp.CloseDate = Date.valueOf(closeDate);
        update opp;
        return opp;
    }

    // Supprimer une vente
    @AuraEnabled
    public static void deleteOpportunity(Id opportunityId) {
        System.debug('OpportunityManager.deleteOpportunity');

        // Supprimer la vente
        Opportunity opp = getOpportunityById(opportunityId);
        delete opp;
    }

    // Récupérer une vente par son ID
    @AuraEnabled
    public static Opportunity getOpportunityById(Id opportunityId) {
        System.debug('OpportunityManager.getOpportunityById');

        // Verifier que l'ID de l'opportunité n'est pas null
        if (opportunityId == null) {
            throw new AuraHandledException('Opportunity ID is required');
        }

        // Récupérer la vente via SOQL
        return [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Id = :opportunityId];

        // Verifier que le nom de la vente n'est pas null
        if (opp.Name == null) {
            throw new AuraHandledException('Opportunity Name is required');
        }
        return opp;
        System.debug('OpportunityManager.getOpportunityById');
    }
     // Récupérer plusieurs opportunités par leurs ID
    @AuraEnabled
    public static List<Opportunity> getOpportunitiesById(Set<Id> opportunityIds) {
        System.debug('OpportunityManager.getOpportunitiesById');

        // Verifier que la liste des ID n'est pas null
        if (opportunityIds == null) {
            throw new AuraHandledException('Opportunity IDs are required');
        }

        // Récupérer les opportunités via SOQL
        return [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Id IN :opportunityIds];
    }
    
}