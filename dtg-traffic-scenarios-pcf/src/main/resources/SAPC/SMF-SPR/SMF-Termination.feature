Feature:  Session Managemente Policy Termination
  Scenario: SMF_SESSION_TERMINATION
    Given target type is SAPC_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/delete
    Given request content is
      """
      {
  "userLocationInfo" : {
    "eutraLocation" : {
      "tai" : {
        "plmnId" : {
          "mcc" : "460",
          "mnc" : "00"
        },
        "tac" : "0064"
      },
      "ecgi" : {
        "plmnId" : {
          "mcc" : "460",
          "mnc" : "00"
        },
        "eutraCellId" : "0000001"
      },
      "ignoreEcgi" : false
    }
  }
      }
      """
    Given action name is SMF_SESSION_TERMINATION
    When we send POST request
    Then we expect response status code 204
    Then we expect response time less than 5000 milliseconds
    Then we expect response header content-length equals 0
    Then we do not expect response content
