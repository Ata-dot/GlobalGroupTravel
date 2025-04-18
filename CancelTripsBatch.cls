/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-28-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class CancelTripsBatch implements Database.Batchable<SObject> {
    
    // Définir la méthode start() pour déterminer les données à traiter
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        // Sélectionner les voyages dont la date de début est dans 7 jours
        return Database.getQueryLocator([
            SELECT Id, StartDate__c, NumberOfParticipants__c, Status__c
            FROM Trip__c
            WHERE StartDate__c = :Date.today().addDays(7)
            AND NumberOfParticipants__c < 10
            AND Status__c != 'Annulé'
        ]);
    }
    
    // Définir la méthode execute() pour traiter les données
    public void execute(Database.BatchableContext bc, List<Trip__c> scope) {
        for (Trip__c trip : scope) {
            trip.Status__c = 'Annulé'; // Mettre à jour le statut
        }
        update scope; // Mettre à jour les voyages
    }
    
    // Définir la méthode finish() pour effectuer des actions de fin
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Job terminé');
    }
}
