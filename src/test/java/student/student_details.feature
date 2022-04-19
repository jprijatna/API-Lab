Feature: student_details

  Background: define url
    Given url 'http://localhost:8500'
    * def uniqueId = call read('classpath:student/student_create.feature@student_created')
    * def dataId = uniqueId.ID
    * def result = call read('classpath:student/student_token.feature@token_create')
    * def auth_token = result.authToken

  Scenario: success
    Given path '/student/'+dataId+'/details'
    Given header Client-Id = 2000
    Given header Authorization = auth_token
    When method GET
    Then status 200
    And match response ==
    """
    {
      "data": {
        "id": #string,
        "firstName": #string,
        "lastName": #string,
        "nationality": #string,
        "dateOfBirth": #string,
        "email": #string,
        "mobileNumber": #string
      }
    }
    """

  Scenario: invalid or missing client-id or authorisation
    Given path '/student/'+dataId+'/details'
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

  Scenario: invalid Id
    Given path '/student/id/details'
    Given header Client-Id = 2000
    Given header Authorization = auth_token
    When method GET
    Then status 404
    And match response ==
    """
      {
         "message": "No student found!"
      }
    """