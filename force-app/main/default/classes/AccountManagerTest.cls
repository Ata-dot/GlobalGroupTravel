/**
 * @description       : Classe de test pour les méthodes de gestion des comptes dans AccountManager
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-27-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountManagerTest {

    /** 
     * Test de la méthode creation d'un client.
     * Ce test vérifie si la méthode createAccount permet de créer un client avec succès.
     * - La méthode crée un client avec un nom et un numéro de téléphone.
     * - Après la création, le test récupère le client à partir de la base de données pour valider que les informations sont correctes.
     */

    // Test de la création d'un client
    @IsTest
    static void testCreateAccount() {

        // Insertion d'un client
        AccountManager.createAccount('name', 'phone');

        // Récupération du client
        Account account = [SELECT Id, Name, Phone FROM Account WHERE Name = 'name' AND Phone = 'phone'];

        // Vérification des informations du client récupéré
        System.Assert(account != null);
        System.Assert(account.Id != null);
        System.Assert(account.Name == 'name');
        System.Assert(account.Phone == 'phone');
    }
    
    /**
     * Test de la récupération d'un client.
     *  Ce test vérifie que la méthode 'getAccount' permet de récupérer un client à partir de son identifiant.
     * - Le test crée un client via la méthode de création et récupère son identifiant.
     * - Ensuite, le test appelle la méthode de récupération avec l'identifiant du client.
     * - Enfin, le test vérifie que les informations du client récupéré sont correctes.
     */

    @IsTest
    static void testGetAccount() {

        // Création d'un client via la méthode de création
        Id accountId = AccountManager.createAccount('name', 'phone');
        
        // Récupération du client via la méthode de récupération
        Account account = AccountManager.getAccount(accountId);

        // Vérification des informations du client récupéré
        System.Assert.areEqual(accountId, account.Id);
        System.Assert.areEqual('name', account.Name);
        System.Assert.areEqual('phone', account.Phone);
    }
     
    /** Test de la suppression d'un client
     * Ce test vérifie que la méthode 'deleteAccount' permet de supprimer un client à partir de son identifiant.
     * - Le test crée un client via la méthode de création et récupère son identifiant.
     * - Ensuite, le test appelle la méthode de suppression avec l'identifiant du client.
     * - Enfin, le test vérifie que le client a bien été supprimé de la base de données.
     */

    @IsTest
    static void testDeleteAccount() {

        // Création d'un client via la méthode de création
        Id accountId = AccountManager.createAccount('name', 'phone');

        // Appel de la méthode de suppression
        AccountManager.deleteAccount(accountId);

        
        try { // Tentative de récupération du client
            Account account = [SELECT Id, Name, Phone FROM Account WHERE Id = :accountId];

            // Si le client est récupéré, une exception est levée
            System.debug(account);
            System.Assert(false, 'The account should have been deleted');
        } catch (QueryException e) { 
            // Si le client n'est pas récupéré, le test est réussi
            System.debug('Account deleted with Id: ' + accountId);
            System.Assert(true, 'The account has been deleted');
        }
    }

    /** 
     * Test de la mise à jour d'un client
     * Ce test vérifie que la méthode 'updateAccount' permet de mettre à jour les informations d'un client.
     * - Le test crée un client via la méthode de création et récupère son identifiant.
     * - Ensuite, le test appelle la méthode de mise à jour avec l'identifiant du client et les nouvelles informations.
     * - Enfin, le test vérifie que les informations du client ont bien été mises à jour.
     */
    
    @IsTest
    static void testUpdateAccount() {
        // Création d'un client via la méthode de création
        Id accountId = AccountManager.createAccount('name', 'phone');

        // Mise à jour du client via la méthode de mise à jour
        AccountManager.updateAccount(accountId, 'newName', 'newPhone');

        // Récupération du client via la méthode de récupération
        Account account = AccountManager.getAccount(accountId);

        // Vérification des informations du client récupéré
        System.Assert.areEqual(accountId, account.Id);
        System.Assert.areEqual('newName', account.Name);
        System.Assert.areEqual('newPhone', account.Phone);
    } 
}