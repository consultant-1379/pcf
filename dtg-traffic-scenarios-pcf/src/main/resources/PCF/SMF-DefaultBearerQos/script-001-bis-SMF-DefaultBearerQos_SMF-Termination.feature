Feature:  SMF send policy control termination to PCF and pcf respond with 204 code and no body

 Scenario: 	Callback handler initialization delete
    Given action name is SUBSCRIBER_DEREGISTER
    Given callback request to server type GENERIC_HTTP
    Given callback request path prefix <smpcUriPrefix><udrSubsNotifyUri>
    Given callback request with before key imsi-
    Given callback request HTTP method DELETE
    Then we wait for callback request

  Scenario: SMF_SESSION_TERMINATION
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/delete
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
    Given callback handler action name is SUBSCRIBER_DEREGISTER
    Then we expect callback request
    Then we send callback response with status code 204

