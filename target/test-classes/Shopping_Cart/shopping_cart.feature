Feature: Shopping Cart

  Scenario: success
    Given url 'http://localhost:8500'
    Given header Client-Id = "DPE-QE"
    Given path '/shoppingcart/items'
    Given param Type = "Fresh"
    Given param Discount = "Applied"
    When method GET
    Then status 200
    And match response ==
    """
    {
      "basket": [
        {
              "name": "Milk",
              "quantity": "2",
              "price": "$4"
        },
        {
              "name": "Bread",
              "quantity": "1",
              "price": "$5"
        },
        {
              "name": "Eggs",
              "quantity": "1",
              "price": "$6.5"
        }
 ]
    }
    """

  Scenario: client id missing or invalid
    Given url 'http://localhost:8500'
    Given header Client-Id = null
    Given path '/shoppingcart/items'
    Given param Type = "Fresh"
    Given param Discount = "Applied"
    When method GET
    Then status 401
    And match response ==
    """
    {
      "message":"Unauthorized request! Client-Id is missing or invalid."
    }
    """

  Scenario: incorrect type or discount or both
    Given url 'http://localhost:8500'
    Given header Client-Id = "DPE-QE"
    Given path '/shoppingcart/items'
    Given param Type = null
    Given param Discount = null
    When method GET
    Then status 400
    And match response ==
  """
    {
      "message":"Invalid request! Parameters are missing or invalid."
    }
  """