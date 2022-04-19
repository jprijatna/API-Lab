Feature: Student

  Background: define url
    Given url 'http://localhost:8500'

  @token_create
  Scenario: success
   Given path '/token'
   And request {key: 'quality-engineering'}
   Given header Client-Id = 2000
   When method POST
   Then status 200
   * def authToken = response["token"]
   And match response ==
    """
    {
      token: #present
    }
    """

  Scenario: invalid key
    Given path '/token'
    Given header Client-Id = 2000
    And request {"key": null}
    When method POST
    Then status 400
    And match response ==
    """
    {
      "error": "Invalid key!"
    }
    """