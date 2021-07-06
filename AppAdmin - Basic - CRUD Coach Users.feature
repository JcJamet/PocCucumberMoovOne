@BDDSTORY-MOOV-7806
@Admin
@BasicTest
@E2E
@E2E_BDD
Feature: AppAdmin - Basic - CRUD Coach Users
  Background:
    Given an admin user logged in
    And admin navigates to the coaches list page

  @BDDTEST-MOOV-7691
  @Automation
  @BasicTest
  Scenario: AppAdmin - Basic - Create a Coach user
  Background: User is Logged In as an Admin

    And admin clicks on the create button of the list page
    When the create form is filled with
      | Prénom                  | Jean               |
      | Nom                     | Dujardin           |
      | Adresse e-mail          | jeanduj@moovone.fr |
      | Monnaie de facturation  | €                  |
      | Langue de la plateforme | Français           |
      | Timezone                | Europe/Paris       |
    And the create form is submitted
    Then a toaster is displayed with "Le coach Jean Dujardin a bien été créé" # check success toaster message

  @BDDTEST-MOOV-7692
  @Automation
  @BasicTest
  @ErrorCase
  Scenario Outline: AppAdmin - Basic - Create a Coach Error Cases
  Background: User is Logged In as an Admin

    And admin clicks on the create button of the list page
    When the field "<field>" is filled with "<value>"
    And the field "<field>" loses focus
    Then the field "<field>" displays an error "<errorMsg>"
    Examples:
      | field         | value                                                           | errorMsg                                                        |
      | firstName     | null                                                            | Ce champs est requis                                            |
      | firstName     | a                                                               | Le champ doit comprendre entre 2 et 60 caractères (actuel : 1)  |
      | firstName     | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa   | Le champ doit comprendre entre 2 et 60 caractères (actuel : 61) |
      | lastName      | null                                                            | Ce champs est requis                                            |
      | lastName      | a                                                               | Le champ doit comprendre entre 2 et 60 caractères (actuel : 1)  |
      | lastName      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa   | Le champ doit comprendre entre 2 et 60 caractères (actuel : 61) |
      | email         | null                                                            | Ce champs est requis                                            |
      | email         | ssfdsdf                                                         | Veuillez saisir une adresse e-mail valide                       |  
      | email         | azeaze@sdfsfd                                                   | Veuillez saisir une adresse e-mail valide                       |  
      | appLanguageId | null                                                            | Ce champs est requis                                            |
      | timezone      | null                                                            | Ce champs est requis                                            |

  @BDDTEST-MOOV-7809
  @BasicTest
  Scenario: AppAdmin - Basic - Coach User listing
    Then the title of the page is "Liste des coachs"
    And the table columns' names are
        | idx   | value                 |
        | 2     | Prénom NOM            |
        | 3     | Langue de coaching    |
        | 4     | Nationalité           |
        | 5     | Pays / Ville          |
        | 6     | Méthodologie          |
        | 7     | Timezone              |
        | 8     | Statut                |
        | 9     | Date de création      |

  @BDDTEST-MOOV-7810
  @BasicTest
  Scenario: AppAdmin - Basic - Search for a coach user on list page
    Given the following coach users exist
      | firstName | lastName |
      | David     | Micheau  |
      | Thomas    | Leporé   |
      | Etienne   | Bondot   |  
      | Linda     | Cabart   |
    When admin searches "Linda Cabart"
    Then the first result is
      | value        |
      | Linda Cabart |

  @BDDTEST-MOOV-7812
  @BasicTest
  Scenario: AppAdmin - Basic - Consult an Coach user
    #Need getCurrentDate method
    Given the following coach users exist
      | Prénom                     | e2eCoachUser                 |
      | Nom                        | Mishow                       |
      | Adresse e-mail             | e2eCoachUser-show@moovone.io |
      | Monnaie de facturation     | €                            |
      | Langue de la plateforme    | Français                     |
      | TimeZone                   | Europe/Paris (UTC +01:00)    |
    And admin searches "e2eExternaleUser Mishow"
    When admin clicks on the show button of the list page for of "e2eExternaleUser Mishow" # click on button show from an External user row from the list page
    Then the user details should contains
      | Date de création du compte | <CurrentDate>                |
      | Statut                     | Non activé                   |
      | Prénom                     | e2eCoachUser                 |
      | Nom                        | Mishow                       | 
      | Adresse e-mail             | e2eCoachUser-show@moovone.io |
      | TimeZone                   | Europe/Paris (UTC +01:00)    |
      | Langue de la plateforme    | Anglais                      |
      | Format de l'heure          | 24h                          |
      | Monnaie de facturation     | €                            |

  @BDDTEST-MOOV-7813
  @BasicTest
  Scenario: AppAdmin - Basic - Update Personnal informations on a Coach user
    Given the following coach users exist
      | Prénom                  | Jean               |
      | Nom                     | Update             |
      | Adresse e-mail          | jeanupd@moovone.fr |
      | Monnaie de facturation  | €                  |
      | Langue de la plateforme | Français           |
      | Timezone                | Europe/Paris       |
    And admin searches "Jean Update"
    And admin clicks on the edit button of the list page for "Jean Update"
    When the edit form is filled with
      | field     | value |
      | currency  | $     |
    And the edit form is submitted
    Then a toaster is displayed with "Le coach Jean Update a bien été modifié"

  @BDDTEST-MOOV-8064
  @BasicTest
  Scenario: AppAdmin - Basic - Create Coach - Error case - Mail already exist
    Given the following coach users exist
      | Prénom                  | Jean               |
      | Nom                     | Aidéjà             |
      | Adresse e-mail          | jeanai@moovone.fr  |
      | Monnaie de facturation  | €                  |
      | Langue de la plateforme | Français           |
      | Timezone                | Europe/Paris       |
    And admin clicks on the create button of the list page
    When the field "email" is filled with "jeanai@moovone.fr"
    And the field "email" loses focus
    Then the field "email" displays an error "Cette adresse e-mail est déjà utilisée"

  @BDDTEST-MOOV-8065
  @BasicTest
  Scenario: AppAdmin - Basic - Update Coach - Error handling
    Given the following Coach user exist
      | firstName     | Jean                |
      | lastName      | Update2             |
      | email         | jeanupd2@moovone.fr |
      | currency      | €                   |
      | appLanguageId | Français            |
      | timezone      | Europe/Paris        |
    And admin searches "Jean Update"
    And admin clicks on the edit button of the list page for "Jean Update2"
    When the field "<field>" is filled with "<value>"
    And the field "<field>" loses focus
    Then the field "<field>" displays an error "<errorMsg>"
      | field         | value                                                           | errorMsg                                                        |
      | firstName     | null                                                            | Ce champs est requis                                            |
      | firstName     | a                                                               | Le champ doit comprendre entre 2 et 60 caractères (actuel : 1)  |
      | firstName     | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa   | Le champ doit comprendre entre 2 et 60 caractères (actuel : 61) |
      | lastName      | null                                                            | Ce champs est requis                                            |
      | lastName      | a                                                               | Le champ doit comprendre entre 2 et 60 caractères (actuel : 1)  |
      | lastName      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa   | Le champ doit comprendre entre 2 et 60 caractères (actuel : 61) |
      | email         | null                                                            | Ce champs est requis                                            |
      | email         | ssfdsdf                                                         | Veuillez saisir une adresse e-mail valide                       |
      | email         | azeaze@sdfsfd                                                   | Veuillez saisir une adresse e-mail valide                       |
      | email         | &àé_"_'è'è)àç!$@rf.gt                                           | Veuillez saisir une adresse e-mail valide                       |
      | currency      | null                                                            | Ce champs est requis                                            |
      | appLanguageId | null                                                            | Ce champs est requis                                            |
      | timezone      | null                                                            | Ce champs est requis                                            |
