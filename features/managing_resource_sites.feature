Feature: Managing Resource Sites
  In order to supply social workers with resource sites
  As a Healthify user
  I want to be able to manage resource sites

  Scenario: Basic management and navigation for Resource Sites
    Given I visit the All Resource Sites page and I am not authenticated
    When I click the "New Resource Site" link
    Then I should be redirected to User Signin page
    When fill in the following attributes:
      | Email       | srinivasgumdelli@gmail.com             |
      | Password    | srinivasgumdelli                       |
    And I click the "Log in" button
    Then I should be on the New Resource Site page
    When fill in the following attributes:
      | Name         | Food Pantry                            |
      | Address      | 222 Broadway, New York, NY 10038       |
      | Description  | A food pantry at the Healthify office. |
    And I click the "Save" button
    Then The Resource Site should be created
    And I should be on the Resource Site Details page for the resource site "Food Pantry"
    And there should be a success notice stating "Resource site created."
    And I should see the text "Address 222 Broadway, New York, NY 10038"
    When I click the "Back to All Resource Sites" link
    Then I should be on the All Resource Sites page
    And the resource sites list should include exactly the following resource sites:
      | name        | address                          |
      | Food Pantry | 222 Broadway, New York, NY 10038 |
    When I click the "Food Pantry" link
    Then I should be on the Resource Site Details page for the resource site "Food Pantry"
    When I click the "Edit this Resource Site" link
    Then I should be on the Edit Resource Site page for the resource site "Food Pantry"
    When fill in the following attributes:
      | Address | 1 World Trade Center, New York, NY 10007 |
    And I click the "Save" button
    Then I should be on the Resource Site Details page for the resource site "Food Pantry"
    And there should be a success notice stating "Resource site updated."
    And I should see the text "Address 1 World Trade Center, New York, NY 10007"
    When I click the "Delete this Resource Site" link
    Then I should be on the All Resource Sites page
    And there should be a success notice stating "The resource site 'Food Pantry' was deleted."
    And the resource sites list should be empty