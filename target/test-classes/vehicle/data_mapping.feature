Feature: data_mapping

  Background: calling vehicle regos
    Given url 'http://localhost:8500'
    Given path '/data/regos'
    When method GET
    Then status 200
    * def dataInput = response.data
    * def data = karate.map(dataInput, function(value, index) { return { RegistrationNumber: value} })

  Scenario Outline: return responses data
    Given path '/vehicle/<RegistrationNumber>/details'
    When method GET
    Then status 200
    * def details_data = response

    Given path '/data/<RegistrationNumber>'
    When method GET
    Then status 200
    * def source_data = response
    * def source_dob = $response.owner[*].dob

    And print "i am here"

    * def dob_format =
      """
        function() {
          for (var i = 0; i < response.owner.length; i++) {
#            var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
            var sdf = new SimpleDateFormat();
            sdf = source_data.owner[i].dob;
            sdf.applyPattern('dd/MM/yyyy');
            source_data.owner[i].dob = sdf;
          }
          return source_data.owner
        }
      """

#    * def response_convert = dob_format()

    And match details_data.data.vehicle.year == source_data.year
    And match details_data.data.vehicle.make == source_data.make
    And match details_data.data.vehicle.model == source_data.model
    And match details_data.data.vehicle.transmission == source_data.transmission
    And match details_data.data.vehicle.odometer == source_data.odometer
    And match details_data.data.registration.registrationNumber == source_data.rego
    And match details_data.data.registration.state == source_data.state
    And match details_data.data.registration.address[*].addressType == get source_data.addressModel[*].addressType
    And match details_data.data.registration.address[*].addressLine1 == get source_data.addressModel[*].address1
    And match details_data.data.registration.address[*].addressLine2 == get source_data.addressModel[*].address2
    And match details_data.data.registration.address[*].state == get source_data.addressModel[*].state
    And match details_data.data.registration.address[*].country == get source_data.addressModel[*].country
    And match details_data.data.owner[*].fullName == get source_data.owner[*].fullName
    And match details_data.data.owner[*].dateOfBirth == get source_date.owner[*].dob
    And match details_data.data.owner[*].driverLicense == get source_data.owner[*].license
    And match details_data.data.owner[*].isCurrentOwner == get source_data.owner[*].isCurrentOwner

    Examples:
      | data |