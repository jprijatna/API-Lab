Feature: student_all

  Background: define url
    Given url 'http://localhost:8500'
    * def result = call read('classpath:student/student_token.feature@token_create')
    * def auth_token = result.authToken

  Scenario: view all students
    Given path '/students'
    Given header Client-Id = 2000
    Given header Authorization = auth_token
    When method GET
    Then status 200

  Scenario: invalid or missing client-id or authorisation
    Given path '/students'
    Given header Client-Id = 2000
    Given header Authorization = null
    When method GET
    Then status 401
    And match response ==
    """
      {
        "message": "Unauthorized request."
      }
    """

  Scenario: other cases
    Given path '/'
    When method GET
    Then status 502