Feature:  Session Managemente Policy Termination

  Scenario: SMF_SESSION_TERMINATION
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <smpcUriPrefix>/sm-policies/imsi-35501000000|1|1594373240/delete
    Given request content is
      """
      {
        "userLocationInfo": {
          "nrLocation": {
            "tai": {
              "plmnId": {
                "mcc": "240",
                "mnc": "81"
              },
              "tac": "0064"
            },
            "ncgi": {
              "plmnId": {
                "mcc": "240",
                "mnc": "81"
              },
              "nrCellId": "010203064"
            }
          }
        }
      }
      """
    Given action name is SMF_SESSION_TERMINATION
    When we send POST request
    Then we expect response status code 204
    Then we expect response time less than 1100 milliseconds
    Then we expect response header content-length equals 0
    Then we do not expect response content
