Feature: vehicle  Background: define URL    Given url 'http://localhost:8500'#    * def result = call read('classpath:vehicle/vehicle_regos.feature')#    * def registrations = result.'data'    Given path '/data/regos'    When method GET    Then status 200    * def dataInput = response["data"]#    * def data = karate.mapWithKey(dataInput, 'data')    * def data = karate.map(values, function(value, index) { return { data: value} })    And print data#  Scenario: success#    Given path '/vehicle/',registration,'/details'#    When method GET#    Then status 200#  Scenario Outline: success#    Given path '/vehicle/<data>/details'#    When method GET#    Then status 200#    Examples:#      | data |#    And print#  Scenario: invalid registration#    Given path '/vehicle/registration/details'#    When method GET#    Then status 404#    And match response ==#    """#      {#        "message": "No vehicle found!"#      }#    """