Feature: Appointment Scheduling
  As a user
  I want to book appointments at specific dates and times
  So that I can manage my schedule effectively

  Scenario: Successfully booking an appointment
    Given I am on the appointment booking page
    When I enter appointment details:
      | Field       | Value                 |
      | Date        | 2025-04-01            |
      | Time        | 14:00                 |
      | Description | Doctor appointment    |
    And I click the "Book Appointment" button
    Then I should see a confirmation message
    And the appointment should be stored in the system
    
  Scenario: Viewing my booked appointments
    Given I have previously booked an appointment
    When I navigate to the "My Appointments" page
    Then I should see my appointment in the list with correct details