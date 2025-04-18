/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 *
 */
@isTest
private class UpdateTripStausBatchTest {

    @isTest
    static void TestBatchUpdateTripStatus () {

        // Créer des voyages de test
        List<Trip__c> trips = new List<Trip__c>();

        // Voyage 1 : A venir (date de début dans le futur, moins de 10 participants)
        Trip__c trip1 = new Trip__c();
        trip1.StartDate__c = System.today().addDays(7);
        trip1.NumberOfParticipants__c = 9;
        trip1.Status__c = 'A venir';
        trip1.EndDate__c = System.today().addDays(14);
        trips.add(trip1); 

        // Voyage 2 : En cours (date de début aujourd'hui, moins de 10 participants)
        Trip__c trip2 = new Trip__c();
        trip2.StartDate__c = System.today();
        trip2.NumberOfParticipants__c = 9;
        trip2.Status__c = 'En cours';
        trip2.EndDate__c = System.today().addDays(14);
        trips.add(trip2);

        // Voyage 3 : Terminé (date de fin passée)
        Trip__c trip3 = new Trip__c();
        trip3.StartDate__c = System.today().addDays(-7);
        trip3.EndDate__c = System.today().addDays(-1);
        trip3.NumberOfParticipants__c = 9;
        trip3.Status__c = 'Terminé';
        trips.add(trip3);

        // Voyage 4 : A venir (plus de 10 participants)
         Trip__c trip4 = new Trip__c();
        trip4.StartDate__c = System.today().addDays(7);
        trip4.NumberOfParticipants__c = 11;
        trip4.Status__c = 'A venir';
        trip4.EndDate__c = System.today().addDays(14);
        trips.add(trip4);

        // Insertion des voyages
        insert trips;

        // Lancer le test
        Test.startTest();

        // Execution du batch
        System.debug ('Execution du batch UpdateTripStatusBatch...');
        Database.executeBatch(new UpdateTripStatusBatch());
        
        // Stop the test
        Test.stopTest();

        // Recupérer les voyages apres le batch
        List<Trip__c> result = [SELECT Id, Status__c FROM Trip__c];

        // Afficher les voyages
        System.debug('Liste des voyages: ' + result);

        // Voyage 1 devrait être 'A venir' (StartDate > aujourd'hui)
        System.assertEquals('A venir', result[0].Status__c);

        // Voyage 2 devrait être 'En cours' (StartDate <= aujourd'hui et EndDate > aujourd'hui)
        System.assertEquals('En cours', result[1].Status__c);

        // Voyage 3 devrait être 'Termniné' (EndDate <= aujourd'hui)
        System.assertEquals('Terminé', result[2].Status__c);

        // Voyage 4 devrait être 'A venir' (StartDate > aujourd'hui mais plus de 10 participants)
        System.assert.Equals('A venir', result[3].Status__c);

    }
    
}