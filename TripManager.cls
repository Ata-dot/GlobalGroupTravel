/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class TripManager {

    // Créer un voyage
    public static void CreateTrip(String accountId, String name, String stage, Date closeDate, String description) {
        System.debug('TripManager.CreateTrip');

        // Vérifier que AccountId n'est pas null    
        if (accountId == null) {
            System.debug('AccountId is null');
            throw new AuraHandledException('Account ID is required');
        }

        // Vérifier que le nom du trip n'est pas null
        if (String.isBlank(name)) {
            System.debug('Name is null');
            throw new AuraHandledException('Trip Name is required');
        }

        // Vérifier que la phase du voyage n'est pas null
        if (String.isBlank(stage)) {
            System.debug('Stage is null');
            throw new AuraHandledException('Stage Name is required');
        }

        // Vérifier que la date de fin n'est pas null
        if (closeDate == null) {
            System.debug('CloseDate is null');
            throw new AuraHandledException('Close Date is required');
        }

        // Créer le voyage
        Opportunity opp = new Opportunity();
        opp.AccountId = accountId;
        opp.Name = name;
        opp.StageName = stage;
        opp.CloseDate = closeDate;
        opp.Description = description;
        insert opp;
        System.debug('TripManager.CreateTrip');
    }

    // Mettre à jour un voyage
    public static void UpdateTrip(Id tripId, String name, String stage, Date closeDate, String description) {
        System.debug('TripManager.UpdateTrip');

        // Vérifier que l'ID de l'opportunité n'est pas null
        if (tripId == null) {
            System.debug('TripId is null');
            throw new AuraHandledException('Trip ID is required');
        }

        // Vérifier que le nom de l'opportunité n'est pas null
        if (String.isBlank(name)) {
            System.debug('Name is null');
            throw new AuraHandledException('Opportunity Name is required');
        }

        // Vérifier que le nom de la vente n'est pas null
        if (String.isBlank(stage)) {
            System.debug('Stage is null');
            throw new AuraHandledException('Stage Name is required');
        }

        // Vérifier que la date de fin n'est pas null   
        if (closeDate == null) {
            System.debug('CloseDate is null');
            throw new AuraHandledException('Close Date is required');
        }

        // Mettre à jour la vente   
        Opportunity opp = getTripById(tripId);
        opp.Name = name;
        opp.StageName = stage;
        opp.CloseDate = closeDate;
        opp.Description = description;
        update opp;
        System.debug('TripManager.UpdateTrip');
    }

    // Supprimer un voyage
    public static void DeleteTrip(Id tripId) {
        System.debug('TripManager.DeleteTrip');

    // Verifier que l'opportunité existe
        Opportunity opp = getTripById(tripId);

        delete opp;
        System.debug('TripManager.DeleteTrip');
    }

    // Récupérer un voyage par son ID
    public static Opportunity getTripById(Id tripId) {
        System.debug('TripManager.getTripById');

        // Verifier que l'ID de l'opportunité n'est pas null
        if (tripId == null) {
            System.debug('TripId is null');
            throw new AuraHandledException('Trip ID is required');
        }
        // Récupérer de l'opp/voyage via SOQL
        Opportunity opp = [SELECT Id, Name, StageName, CloseDate, Description FROM Opportunity WHERE Id = :tripId LIMIT 1];
       
        // Verifier si l'opportunité existe 
        if (opp == null) {
            System.debug('Trip not found');
            throw new AuraHandledException('Trip not found');
        }
        return opp;
        System.debug('TripManager.getTripById');
    }

    // Récupérer les voyages par leurs ID   
    public static List<Opportunity> getTripsById(List<Id> tripIds) {
        System.debug('TripManager.getTripsById');

        // Verifier que la liste des ID n'est pas null
        if (tripIds == null) {
            System.debug('TripIds is null');
            throw new AuraHandledException('Trip IDs are required');
        }

        // Récupérer les opportunités via SOQL
        List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate, Description FROM Opportunity WHERE Id IN :tripIds];
        return opps;
    }
   
}