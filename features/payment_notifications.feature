Feature: Payment notifications
  In order to receive a callback from Sage
  as the Sage system
  I want to make payment notification callbacks
  
  Scenario: When a technical error occurs
    When the following unsuccessful payment notification is received:
      | Status | 
      | ERROR |
