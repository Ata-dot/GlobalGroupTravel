/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContractManager {

    // Créer un contrat
    @AuraEnabled
    public static Contract createContract(Id accountId, String contractName, String startDate, String endDate) {
        System.debug('ContractManager.createContract');

        // Verifier que l'account n'est pas null
        if (accountId == null) {
            throw new AuraHandledException('Account ID is required');
        }

        // Verifier que le nom du contrat n'est pas null
        if (String.isBlank(contractName)) {
            throw new AuraHandledException('Contract Name is required');
        }

        // Verifier que la date de début n'est pas null
        if (String.isBlank(startDate)) {
            throw new AuraHandledException('Start Date is required');
        }

        // Verifier que la date de fin n'est pas null
        if (String.isBlank(endDate)) {
            throw new AuraHandledException('End Date is required');
        }

        // Verification que la date de début est antérieure à la date de fin
        if (Date.valueOf(startDate) >= Date.valueOf(endDate)) {
            throw new AuraHandledException('Start Date must be before End Date');
        }

        // Créer le contrat
        Contract contract = new Contract();
        contract.AccountId = accountId;
        contract.Name = contractName;
        contract.StartDate = Date.valueOf(startDate);
        contract.EndDate = Date.valueOf(endDate);
        insert contract;
        return contract;
    }

    // Mettre à jour un contrat
    @AuraEnabled
    public static Contract updateContract(Id contractId, String contractName, String startDate, String endDate) {
        System.debug('ContractManager.updateContract');

        // Verifier que l'ID du contrat n'est pas null
        if (contractId == null) {
            throw new AuraHandledException('Contract ID is required');
        }

        // Verifier que le nom du contrat n'est pas null
        if (String.isBlank(contractName)) {
            throw new AuraHandledException('Contract Name is required');
        }

        // Verifier que la date de début n'est pas null 
        if (String.isBlank(startDate)) {
            throw new AuraHandledException('Start Date is required');
        }

        // Verifier que la date de fin n'est pas null
        if (String.isBlank(endDate)) {
            throw new AuraHandledException('End Date is required');
        }

        // Verification que la date de début est antérieure à la date de fin
        if (Date.valueOf(startDate) >= Date.valueOf(endDate)) {
            throw new AuraHandledException('Start Date must be before End Date');
        }

        // Mettre à jour le contrat
        Contract contract = getContractById(contractId);
        contract.Name = contractName;
        contract.StartDate = Date.valueOf(startDate);
        contract.EndDate = Date.valueOf(endDate);
        update contract;
        return contract;
        System.debug('ContractManager.updateContract');
    }

    // Supprimer un contrat
    @AuraEnabled
    public static void deleteContract(Id contractId) {
        System.debug('ContractManager.deleteContract');

        // Verifier que l'ID du contrat n'est pas null
        if (contractId == null) {
            throw new AuraHandledException('Contract ID is required');
        }

        // Supprimer le contrat
        Contract contract = getContractById(contractId);
        delete contract;
        System.debug('ContractManager.deleteContract');
    }

    // Récupérer un contrat par son ID
    @AuraEnabled
    public static Contract getContractById(Id contractId) {
        System.debug('ContractManager.getContractById');

        // Verifier que l'ID du contrat n'est pas null
        if (contractId == null) {
            throw new AuraHandledException('Contract ID is required');
        }
        // Récupérer le contrat via SOQL
        return [SELECT Id, Name, StartDate, EndDate FROM Contract WHERE Id = :contractId];

        // Verifier si le contrat existe
        if (contract == null) {
            throw new AuraHandledException('Contract not found');
        }
        return contract;
    }

    // Récupérer plusieurs contrats par leurs ID
    @AuraEnabled
    public static List<Contract> getContractsById(List<Id> contractIds) {
        System.debug('ContractManager.getContractsById');

        // Verifier que la liste des ID n'est pas null
        if (contractIds == null) {
            throw new AuraHandledException('Contract IDs are required');
        }

        // Récupérer les contrats via SOQL
        return [SELECT Id, Name, StartDate, EndDate FROM Contract WHERE Id IN :contractIds];

        return contracts;
    }
}