Feature: Fetch wall
  In order to display the wall
  flash app
  wants fetch data about the wall
  
  Scenario: Fetch wall
    Given the following bricks:
      |value|message|display_name|first_name|last_name|email|show_value|naughty|purchased_at|
      |300|My naughty brick|bob|Bob|Builder|bob@builders.com|true|true|2009/01/01|
      |300|My great brick|bob|Bob|Builder|bob@builders.com|true|false|2009/01/01|
    And I am on the wall xml feed
    Then the "total-bricks" element should contain "1"
    And the "total-pages" element should contain "1"
    And the "total-money" element should contain "6.0"
    And the "total-messages" element should contain "2"
    And the "date" element should contain today's date
