/**
 * @description       : Test unitaire pour le trigger CreateTripOnOpportunityWin
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/**
 * Test unitaire pour le trigger CreateTripOnOpportunityWin
 * Mettre à jour une opportunité avec le stage Closed Won
 * Vérifier que le voyage a été créé
 * Vérifier que le voyage a été créé avec les valeurs correctes     
 */

@isTest
private class TestCreateTripOnOpportunityWin {
    @IsTest
    static void testCreateTripOnOpportunityWin() {

        // Create an account
        Account acc = new Account(
            Name = 'AccountName',
            Phone = '1234567890',
            Industry = 'Education'
        );
        insert acc;
        System.debug('Account created with Id: ' + acc.Id);

        // Create an opportunity
        Opportunity opp = new Opportunity(
            CloseDate = Date.today().addDays(10),
            Name = 'OpportunityName',
            StageName = 'Prospecting',
            AccountId = acc.Id,
            Amount = 10000,
            Destination__c = 'Paris',
            NumberOFParticipants__c = 1,
            StartDate__c = Date.today().addDays(1),
            EndDate__c = Date.today().addDays(7)
        );
        insert opp;
        System.debug('Opportunity created with Id: ' + opp.Id);

        // Update the opportunity
        opp.StageName = 'Closed Won';
        update opp;
        System.debug('Opportunity updated with StageName: ' + opp.StageName);

        // Verify that the trip was created
        List<Trip__c> trips = [SELECT Id FROM Trip__c WHERE Opportunity__c = :opp.Id];
        System.debug('Trips created: ' + trips.size());
        System.assertEquals(1, trips.size());


        // Verify that the trip was created with the correct values
        Trip__c trip = trips[0];
        System.assertEquals(opp.Id, trip.Opportunity__c);
        System.debug('trip lié à l\'opportunité: ' + trip.Opportunity__c);
        System.assertEquals(opp.Name + ' Trip', trip.Name);
        System.debug('Nom du voyage: ' + trip.Name);
        System.assertEquals(Date.today(), trip.StartDate__c);
        System.debug('Date de début du voyage: ' + trip.StartDate__c);
        System.assertEquals(Date.today().addDays(7), trip.EndDate__c);
        System.debug('Date de fin du voyage: ' + trip.EndDate__c);
        System.assertEquals('Planned', trip.Status__c);
        System.debug('Statut du voyage: ' + trip.Status__c);
        
    }

}
