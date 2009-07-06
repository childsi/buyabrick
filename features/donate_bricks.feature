Feature: Manage bricks
  In order to donate money to Childsi
  as a donor
  I want to buy a brick
  
  Scenario: Decide which brick to buy
    Given I am on the home page
    Then I should see the following brick options:
      |£5|/bricks/new/5.00|
      |£10|/bricks/new/10.00|
      |£20|/bricks/new/20.00|
      |£50|/bricks/new/50.00|
      |£any|/bricks/new|
  
  Scenario: Buy a fixed-price brick
    Given I am on the new 5.00 brick page
    And I fill in the following details:
      |message|My great brick|
      |first_name|Bob|
      |last_name|Builder|
      |email|bob@builders.com|
      |url|http://www.builders.com|
      |show_amount|true|
    And I press "Continue"
    Then the current brick should be saved

  Scenario: Receive an empty successful callback from Protx
    Given the following successful callback is returned:
    Then I should be on the home page
  
  Scenario: Receive an empty failed callback from Protx
    Given the following successful callback is returned:
    Then I should be on the home page
  
    