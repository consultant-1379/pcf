Feature:  Session Management Policy Termination

  Scenario: SMF_SESSION_TERMINATION
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/delete
    Given request content is
      """
      {
       
      }
      """
    Given action name is SMF_SESSION_TERMINATION
    When we send POST request
    Then we expect response status code 204
    Then we expect response time less than 500 milliseconds
    Then we expect response header content-length equals 0
    Then we do not expect response content
