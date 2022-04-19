Feature: vehicle

  Background: define URL
    Given url 'http://localhost:8500'
    * def result = call read('classpath:vehicle/vehicle_regos.feature')
    * def rego = result.dataInput

  Scenario: success
    Given path '/data/'+rego
    When method GET
    Then status 200
    And match response_data.data.owner[*].fullName == get source_data.owner[*].fullName

  Scenario: invalid registration
    Given path '/data/registration'
    When method GET
    Then status 404
    And match response ==
    """
      {
        "message": "No vehicle found!"
      }
    """