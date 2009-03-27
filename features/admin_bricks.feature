Feature: Admin bricks
  In order to manage the Childsi Buy A Brick campaign
  as an admin
  I want to administer bricks
  
  Scenario: Setup a fixed-price brick for someone else
    Given I am logged in as an admin
    When I go to the new 5.00 brick page
    And I fill in the following brick details:
      |message|first_name|last_name|email|url|
      |My great brick|Bob|Builder|bob@builders.com|http://www.builders.com|
    And I check "brick[show_value]"
    And I press "Continue"
    Then the current brick should be saved

  Scenario: Viewing naughty bricks
    Given I am logged in as an admin
    And the following bricks:
      |value|message|first_name|last_name|email|url|show_value|naughty|
      |300|My naughty brick|Bob|Builder|bob@builders.com|http://www.builders.com|true|true|
      |300|My great brick|Bob|Builder|bob@builders.com|http://www.builders.com|true|false|
    When I go to the naughty bricks page
    Then I should see "My naughty brick"
    And I should not see "My great brick"
