/**
 * @description       : Batch qui met à jour le statut des voyages en fonction de la logique des dates.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-28-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global class UpdateTripStatusBatch implements Database.Batchable<sObject>, Database.Stateful {

    // Méthode start() pour récupérer les voyages à traiter
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // On sélectionne tous les voyages avec leur date début et date fin
        return Database.getQueryLocator(
            [SELECT Id, StartDate__c, NumberOfParticipants__c, Status__c, EndDate__c
             FROM Trip__c]
        );
    }

    // Méthode execute() pour traiter les voyages   
    global void execute(Database.BatchableContext bc, List<Trip__c> trips) { 
        // Liste pour stocker les voyages à mettre à jour
        List<Trip__c> tripsToUpdate = new List<Trip__c>();

        // Parcours de chaque voyage pour mettre à jour le statut
        for (Trip__c trip : trips) {
            if (trip.StartDate__c != null && trip.EndDate__c != null && trip.NumberOfParticipants__c != null) {

                // Si aujourd'hui est inférieur à la date de début
                if (Date.today() < trip.StartDate__c) {
                    if (trip.Status__c != 'A venir') {  // Eviter de mettre à jour si déjà 'A venir'
                        trip.Status__c = 'A venir';
                        tripsToUpdate.add(trip);
                    }
                }
                // Si aujourd'hui est supérieur ou égal à la date de début et inférieur ou égal à la date de fin
                else if (Date.today() >= trip.StartDate__c && Date.today() <= trip.EndDate__c) {
                    if (trip.Status__c != 'En Cours') {  // Eviter de mettre à jour si déjà 'En Cours'
                        trip.Status__c = 'En Cours';
                        tripsToUpdate.add(trip);
                    }
                }
                // Si aujourd'hui est supérieur à la date de fin
                else if (Date.today() > trip.EndDate__c) {
                    if (trip.Status__c != 'Terminé') {  // Eviter de mettre à jour si déjà 'Terminé'
                        trip.Status__c = 'Terminé';
                        tripsToUpdate.add(trip);
                    }
                }
            }
        }

        // Si des voyages ont été mis à jour, on les envoie à la base de données
        if (!tripsToUpdate.isEmpty()) {
            update tripsToUpdate;
        }
    }
    
    // Méthode finish() pour effectuer des actions de fin
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch Job terminé, tous les voyages ont été mis à jour en fonction de leur statut.');
    }
}
