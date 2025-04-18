/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CreateTripOnOpportunityWin on Opportunity (after update) {
    
    //Liste pour stocker les trips à insérer
    List<Trip__c> trips = new List<Trip__c>();

    //Parcourir pour chaque opportunité mise à jour
    for(Opportunity opp : Trigger.new){

        //Si l'opportunité est gagnée
        if(opp.StageName == 'Closed Won'){

            //Créer un trip pour l'opportunité
            Trip__c trip = new Trip__c();
            trip.Opportunity__c = opp.Id;
            trip.Name = opp.Name + ' Trip';
            trip.StartDate__c = Date.today();
            trip.EndDate__c = Date.today().addDays(7);
            trip.Status__c = 'Planned';
            trip.Destination__c = opp.AccountId;
            trip.NumberOFParticipants__c = 1;
            trips.add(trip);
        }
    }

    //Insérer les trips
    insert trips;

}