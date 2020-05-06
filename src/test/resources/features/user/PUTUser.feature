Feature: User updates

  Background: Set authentication
    Given I set authentication token using "admin" account

  @acceptanceTest
  Scenario: Update user credentials of a user
    When I send a PUT request to "/user/credentials/{normalUser.id}" with the following parameters
      | Password | newpass |
      | Username | dperez  |
    Then I validate the response has status code 200
    And I validate the response body should match with "user/userResponseSchema.json" JSON schema
    And I validate the response contains the following data
      | userId    | {normalUser.id}        |
      | firstName | {normalUser.firstName} |
      | lastName  | {normalUser.lastName}  |
      | userName  | {normalUser.userName}  |
      | password  | {normalUser.password}  |
      | email     | {normalUser.email}     |
      | rol       | {normalUser.rol}       |

  @negativeTest
  Scenario: Update user credentials of nonexistent user
    When I send a PUT request to "/user/credentials/9000" with the following parameters
      | Password | newpass |
      | Username | dperez  |
    Then I validate the response has status code 400