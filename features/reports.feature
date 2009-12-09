Feature: Report bricks
  In order to manage the Childsi Buy A Brick campaign
  as an admin
  I want to view reports on bricks
  
  Scenario: Trying to view reports without being an admin
    Given I am not logged in as an admin
    When I go to the reports page
    Then I should be on the home page
  
  Scenario: Trying to view a report without being an admin
    Given I am not logged in as an admin
    When I go to the "generous_bricks" report page
    Then I should be on the home page
  
  Scenario: Viewing naughty bricks
    Given I am logged in as an admin
    And the following bricks:
      |value|message|display_name|first_name|last_name|email|show_value|purchased_at|
      |100_00|My generous brick 1|bob|Bob|Builder|bob@builders.com|true|2009/01/01|
      |200_00|My generous brick 2|bob|Bob|Builder|bob@builders.com|true|2009/01/01|
      |300|My not so generous brick|bob|Bob|Builder|bob@builders.com|true|2009/01/01|
      |200_00|My unpaid for brick|bob|Bob|Builder|bob@builders.com|true||
    When I go to the "generous_bricks" report page
    Then I should see "My generous brick 1"
    And I should see "My generous brick 2"
    And I should not see "My not so generous brick"
    And I should not see "My unpaid for brick"

  