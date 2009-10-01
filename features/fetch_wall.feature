Feature: Fetch wall
  In order to display the wall
  flash app
  wants fetch data about the wall
  
  Scenario: Fetch wall
    Given the following bricks:
      | value | message          | display_name | first_name | last_name | email            | show_value | naughty | purchased_at |
      | 300   | My naughty brick | bob          | Bob        | Builder   | bob@builders.com | true       | true    | 2009/01/01   |
      | 321   | My great brick   | jane         | Jane       | Doe       | jane@jane.com    | true       | false   | 2009/01/01   |
      | 654   | My great brick   | rob          | Rob        | Jones     | rob@jones.com    | false      | false   | 2009/01/01   |
    And I am on the wall xml feed
    Then the "total-bricks" element should contain "2"
    And the "total-pages" element should contain "1"
    And the "total-money" element should contain "12.75"
    And the "total-messages" element should contain "3"
    And the "date" element should contain today's date
    And I should see "My great brick"
    And I should not see "My naughty brick"
    And I should see "3.21"
    And I should not see "6.54"
    And I should see "jane"
    And I should not see "Doe"
