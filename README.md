GlobalGroupTravel-Cr-ez-un-back-end-Apex-et-une-BDD
Ce projet a pour objectif de mettre en place un système CRM sur Salesforce pour la gestion des voyages de groupe pour les entreprises et organisations.

Structure du projet

force-app-main-default/ : Code source pour Apex, LWC, objets personnalisés, et déclencheurs.
tests/ : Tests unitaires pour chaque partie du code.
documentations/ : Documentation de l'architecture et des fonctionnalités.
configuration/ : Configuration de l'architecture et des fonctionnalités.

Convention de nommage

Nommage des classes Apex : Nom clair et descriptif, utilisation du PascalCase, suffixer en fonction du type (Controller, Service, TriggerHandler, Helper). Exemple : AccountManager.
Nommage des Trigger : Nom avec le nom de l'objet suivi du mot Trigger. Exemple : CreateTriponOpportunitywin.trigger.
Nommage des méthodes et variables : Nommer les variables de manière descriptive, utilisation du CamelCase. Exemple : totalParticipants.
