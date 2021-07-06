Feature: Admin login
  
  Scenario : Login with admin user
  
  Given an admin user
  And the admin user is on the page /admin
  When the admin user enters credentials
  Then Boum