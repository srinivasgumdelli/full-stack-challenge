Feature: Managing Eligibilities
  In order to supply resource sites with the eligibilities
  As a Healthify admin
  I want to be able to manage eligibilities

  Scenario: Basic management and navigation for Eligibilities
    Given I visit the All Eligibilities page and I am not authenticated
    Then I should be redirected to User Signin page
    When fill in the following attributes:
      | Email       | srinivasgumdelli@gmail.com             |
      | Password    | srinivasgumdelli                       |
    And I click the "Log in" button
    Then I should be on All Eligibilities page as normal user
    When I visit Eligibilities admin page
    Then I should be redirected to All Resource Sites Page
    And there should be an alert stating "You require admin privileges for editing eligibilities"

  Scenario: Advanced management and navigation for Eligibilities
    Given I visit the All Eligibilities page and I am not authenticated
    Then I should be redirected to User Signin page
    When fill in the following attributes:
      | Email       | user@healthify.com  |
      | Password    | healthify           |
    And I click the "Log in" button
    Then I should be on All Eligibilities page as admin
    When I click the "Add New Eligibility" link
    Then I should be New Eligibility page
    When fill in the following attributes:
      | Eligibility | Men        |
      | Description | Men Only   |
    And I click the "Save" button
    Then I should be on the Eligibility Details page for the eligibility "Men"
    And there should be a success notice stating "Eligibility created."
    And I should see the text "Men Only"
    When I click the "Back to All Eligibilities" link
    Then I should be on the All Eligibilities page
    And the eligibilities list should include exactly the following eligibilities:
      | eligibility | description |
      | Men         | Men Only    |
    When I click the "Men" link
    Then I should be on the Eligibility Details page for the eligibility "Men"
    When I click the "Edit this Eligibility" link
    Then I should be on the Edit Eligibility page for the eligibility "Men"
    When fill in the following attributes:
      | Description | Test Description |
    And I click the "Save" button
    Then I should be on the Eligibility Details page for the eligibility "Men"
    And there should be a success notice stating "Eligibility updated."
    And I should see the text "Description Test Description"
    When I click the "Delete this Eligibility" link
    Then I should be on the All Eligibilities page
    And there should be an alert stating "The eligibility could not be deleted. Are there any resource sites with this eligibility?"
