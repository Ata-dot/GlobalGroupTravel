/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountManager {

    // Créer un client
    public static void CreateAccount(String name, String phone) {
        System.debug('CreateAccount with name: ' + name + ' and phone: ' + phone);
    
    // Vérifier les paramètres d'entrée
        if(phone == null) {
            System.debug('AccountManager.CreateAccount: Phone manquant');
            return;
        }
        if(name == null) {
            System.debug('AccountManager.CreateAccount: Nom manquant');
            return;
        }

        // Créer un nouveau client
        Account newAccount = new Account(Name = name, Phone = phone);
        insert newAccount;
        System.debug('Account created with Id: ' + newAccount.Id);
    }

    // Mettre à jour un client
    public static void UpdateAccount(Id accountId, String name, String phone) {
        System.debug('UpdateAccount with Id: ' + accountId + ' and name: ' + name + ' and phone: ' + phone);

        // Vérifier les paramètres d'entrée
        if(accountId == null) {
            System.debug('AccountManager.UpdateAccount: Id manquant');
            return;
        }
        if(phone == null) {
            System.debug('AccountManager.UpdateAccount: Phone manquant');
            return;
        }
        if(name == null) {
            System.debug('AccountManager.UpdateAccount: Nom manquant');
            return;
        }

        // Mettre à jour le client
        Account account = getAccountById(accountId);
        account.Name = name;
        account.Phone = phone;
        update account;
        System.debug('Account updated with Id: ' + account.Id);
    }

    // Supprimer un client
    public static void DeleteAccount(Id accountId) {
        System.debug('DeleteAccount with Id: ' + accountId);

        // Vérifier les paramètres d'entrée
        if(accountId == null) {
            System.debug('AccountManager.DeleteAccount: Id manquant');
            return;
        }

        // Supprimer le client
        Account account = getAccountById(accountId);
        delete account;
        System.debug('Account deleted with Id: ' + accountId);
    }

    // Récupérer un client par Id
    public static Account getAccountById(Id accountId) {
        System.debug('getAccountById with Id: ' + accountId);

        // Vérifier que le client existe             
        if(accountId == null) {
            System.debug('AccountManager.getAccountById: Id manquant');
            return null;
        }

        // Récupérer le client
        return [SELECT Id, Name, Phone FROM Account WHERE Id = :accountId];
        System.debug('Account retrieved with Id: ' + accountId);

        // Verifier du montant de la vente
        if (account.Amount == null) {
            throw new AuraHandledException('Amount is required');   
    }
       // Utilisation d'une Map pour récupérer tous les comptes
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, Phone FROM Account WHERE Id = :accountId]);

        // Récupérer la map des comptes récupérés
        return accountMap.get(accountId);
}
}