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
    And I fill in "brick_display_name" with "bob the builder"
    And I fill in "brick_message" with "My great brick"
    And I fill in "brick_first_name" with "Bob"
    And I fill in "brick_last_name" with "Builder"
    And I fill in "brick_email" with "bob@builder.co.uk"
    And I fill in "brick_telephone" with "01234567"
    And I check "brick_show_value"
    When I press "Continue"
    Then the current brick should be saved
    And I should see "bob the builder"
    And I should see "has donated £5.00 to the wall"
  
  Scenario: Buying a new brick but entering an invalid email address
    Given I am on the new 5.00 brick page
    And I fill in "brick_display_name" with "bob the builder"
    And I fill in "brick_message" with "My great brick"
    And I fill in "brick_first_name" with "Bob"
    And I fill in "brick_last_name" with "Builder"
    And I fill in "brick_email" with "bad email address"
    And I check "brick_show_value"
    And I press "Continue"
    Then I should see "Personalise the brick"
  
  Scenario: View the bricks
    Given the following bricks:
      | url_key | value | message          | display_name | first_name | last_name | email       | show_value | naughty | purchased_at |
      | aaa     | 500   | Purchased        | Bob          | Bob        | Jones     | foo@bar.com | true       | false   | 2009/10/01   |
      | bbb     | 500   | Awaiting payment | Jane         | Bob        | Jones     | foo@bar.com | true       | false   |              |
    When I am on the bricks page
    Then I should see "Purchased" 
    And I should see "Bob" 
    And I should not see "Jane"
    And I should not see "Jones"
    When I am on the bricks page
    When I am on the bricks rss page
    Then I should see "Bob has donated £5.00 to the wall"
    And I should not see "Jane"
  
  Scenario: View a brick
    Given the following bricks:
      | url_key | value | message | display_name | first_name | last_name | email       | show_value | naughty |
      | aaa     | 500   | Message | Display Name | First      | Last      | foo@bar.com | true       | false   |
    When I am on the "aaa" brick page
    Then I should see "Display Name" 
    And I should not see "First"
    And I should not see "Last"

  Scenario: Receive an empty successful callback from Protx
    Given the following successful callback is returned:
    Then I should be on the home page
  
  Scenario: Receive an empty failed callback from Protx
    Given the following successful callback is returned:
    Then I should be on the home page
  
    