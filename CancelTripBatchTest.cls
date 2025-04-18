/**
 * Test unitaire pour la classe CancelTripsBatch
 * Voyage annulé ou non annulé
 *
 */
@isTest
private class CancelTripBatchTest {

    @isTest
    static void TestCancelTripsBatchExecution() {

        // Créer des voyages pour tester le batch
        List<Trip__c> trips = new List<Trip__c>();
        
        // Créer un voyage avec moins de 10 participants et une date de début dans une semaine
        Trip__c trip = new Trip__c();
        trip.StartDate__c = System.today().addDays(7);
        trip.NumberOfParticipants__c = 9;
        trip.Status__c = 'A venir';
        trips.add(trip);
        
        // Créer un autre voyage avec moins de 10 participants et une date de début dans une semaine
        Trip__c trip2 = new Trip__c();
        trip2.StartDate__c = System.today().addDays(7);
        trip2.NumberOfParticipants__c = 9;
        trip2.Status__c = 'A venir';
        trips.add(trip2);

        // Créer un voyage avec plus de 10 participants et une date de début dans une semaine
        Trip__c trip3 = new Trip__c();
        trip3.StartDate__c = System.today().addDays(7);
        trip3.NumberOfParticipants__c = 11;
        trip3.Status__c = 'A venir';
        trips.add(trip3);

                // Inserter les voyages
        insert trips;

        // Afficher les voyages avant l'execution du batch
        System.debug('Liste des voyages avant l\'execution du batch: ' + trips);
        
        // Lancer le test
        Test.startTest();

        // Execution du batch
        CancelTripBatch batch = new CancelTripBatch();
        Database.executeBatch(batch);

        // Stop the test
        Test.stopTest();

        // Verifier que les voyages ayant moins de 10 participants ont été annulés
        List<Trip__c> result = [SELECT Id, Status__c FROM Trip__c WHERE Status__c = 'Annulé'];

        // Afficher les voyages annulés
        System.debug('Liste des voyages: ' + result);

        // Verifier que les voyages 1 et 2 sont annulés
        System.Assert.areEqual(2, result.size(), 'Il devrait y avoir 2 voyages annulés.');
        
        // Verifier que le voyage 3 n'est pas annulé
        Trip__c trip3AfterBatch = [SELECT Id, Status__c FROM Trip__c WHERE Id = :trip3.Id];
        System.debug('Etat du voyage 3 après le batch: ' + trip3AfterBatch.Status__c);
        System.asserNoEquals('A venir', trip3AfterBatch.Status__c, 'Le voyage 3 ne doit pas être annulé car il a plus de 10 participants');
    }   
}