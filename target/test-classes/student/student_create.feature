Feature: student_create

  Background: define url
    Given url 'http://localhost:8500'
    * def result = call read('classpath:student/student_token.feature@token_create')
    * def dataGen = Java.type('helper.DataGenerator');
    * def auth_token = result.authToken

@student_created
  Scenario: creating student
    Given path '/student/create'
    * def randomEmail = dataGen.getRandomEmail()
    Given header Client-Id = 2000
    Given header Authorization = auth_token
    And request
    """
    {
      'firstName': 'Joy',
      'lastName': 'Potter',
      'nationality': 'Australian',
      'dateOfBirth': '14 April 2022',
      'email': #(randomEmail),
      'mobileNumber': '1234 567 890'
      }
    """
    When method POST
    Then status 201
    * def ID = response["id"]
    And match response ==
    """
      {
        "id": #string,
        "message": "New student was created successfully!"
      }
    """

  Scenario: invalid or missing client-id or authorisation
    Given path '/student/create'
    Given header Client-Id = 2000
    Given header Authorization = null
    And request
    """
    {
      'firstName': 'Joy',
      'lastName': 'Potter',
      'nationality': 'Australian',
      'dateOfBirth': '14 April 2022',
      'email': #(randomEmail),
      'mobileNumber': '1234 567 890'
      }
    """
    When method POST
    Then status 401
    And match response ==
    """
      {
        "message": "Unauthorized request."
      }
    """

  Scenario: email taken
    Given path '/student/create'
    Given header Client-Id = 2000
    Given header Authorization = auth_token
    And request
    """
    {
      'firstName': 'Joy',
      'lastName': 'Potter',
      'nationality': 'Australian',
      'dateOfBirth': '14 April 2022',
      'email': 'antionette62@test.com',
      'mobileNumber': '1234 567 890'
      }
    """
    When method POST
    Then status 400
    And match response ==
    """
      {
        "message": "ERROR! Student exists!"
      }
    """

  Scenario: other cases
    Given path '/'
    When method GET
    Then status 502