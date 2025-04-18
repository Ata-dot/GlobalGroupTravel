/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

/**
 * Test Trigger pour le trigger TripDatesValidation

 * 
 * 
 * 
 * 
 *

 */

@isTest
private class TestTripDatesValidation {

    // Test pour vérifier que les dates de début et de fin sont obligatoires
    @isTest
    static void testStartDateAndEndDateRequired() {

        // Create an opportunity with only the Name field set; all other fields are null
        Trip__c trip = new Trip__c();
        trip.Name = 'Trip 1';
        trip.StartDate__c = null;
        trip.EndDate__c = null;

        // Afficher les valeurs des champs avant l'insertion
        System.debug('Avant l\'insertion: ' + trip);

        // Insert the trip
        Test.startTest();
        try {
            insert trip;
            System.assert(false, 'DML operation should have thrown an exception');
        } catch (DmlException e) {

            // Afficher le message d'erreur
            System.debug('Message d\'erreur: ' + e.getMessage());

            // Verifier que le message d'erreur contient le texte attendu
            System.assert(e.getMessage().contains('Les dates de début et de fin sont obligatoires'));
        }
        Test.stopTest();

        // Verifier que le trip n'a pas été inséré
        List<Trip__c> trips = [SELECT Id FROM Trip__c WHERE Name = 'Trip 1'];
        System.debug('Trips: ' + trips);
        System.Assert.areEqual(0, trips.size(), 'Trip should not have been inserted');
    }

}