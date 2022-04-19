Feature: vehicle

  Background: define URL
    Given url 'http://localhost:8500'

  Scenario: success
    Given path '/data/regos'
    When method GET
    Then status 200
    * def dataInput = response["data"]
    * def data = karate.mapWithKey(dataInput, 'data')
    And print data

