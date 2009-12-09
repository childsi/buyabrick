Feature: Admin bricks
  In order to manage the Childsi Buy A Brick campaign
  as an admin
  I want to administer bricks
  
  Scenario: Setup a fixed-price brick for someone else
    Given I am logged in as an admin
    When I go to the new 5.00 brick page
    And I fill in the following brick details:
      |message|display_name|first_name|last_name|email|
      |My great brick|bob|Bob|Builder|bob@builders.com|
    And I check "brick[show_value]"
    And I press "Continue"
    Then the current brick should be saved

  Scenario: Viewing naughty bricks
    Given I am logged in as an admin
    And the following bricks:
      |value|message|display_name|first_name|last_name|email|show_value|naughty|
      |300|My naughty brick|bob|Bob|Builder|bob@builders.com|true|true|
      |300|My great brick|bob|Bob|Builder|bob@builders.com|true|false|
    When I go to the naughty bricks page
    Then I should see "My naughty brick"
    And I should not see "My great brick"
  
  Scenario: Trying to view naughty bricks without being an admin
    Given I am not logged in as an admin
    When I go to the naughty bricks page
    Then I should be on the home page
  
  Scenario: Trying to edit a brick without being an admin
    Given I am not logged in as an admin
    And the following bricks:
      |url_key|value|message|display_name|first_name|last_name|email|show_value|naughty|
      |abcd|300|My great brick|bob|Bob|Builder|bob@builders.com|true|false|
    When I go to the edit "abcd" brick page
    Then I should be on the home page
  
  Scenario: Trying to delete a brick without being an admin
    Given I am not logged in as an admin
    And the following bricks:
      |url_key|value|message|display_name|first_name|last_name|email|show_value|naughty|
      |abcd|300|My great brick|bob|Bob|Builder|bob@builders.com|true|false|
    # When I go to the destroy "abcd" brick page
    # Then I should be on the home page
    # And I should see "My great brick"
