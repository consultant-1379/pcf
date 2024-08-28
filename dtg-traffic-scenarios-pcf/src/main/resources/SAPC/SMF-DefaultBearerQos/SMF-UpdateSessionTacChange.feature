Feature: Session Management Policy Update by TAC change
  Scenario: SMF_SESSION_UPDATE_TAC
    Given target type is SAPC_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/update
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
              "tac": "0063"
            },
            "ncgi": {
              "plmnId": {
                "mcc": "240",
                "mnc": "81"
              },
              "nrCellId": "010203063"
            }
          }
        },
        "repPolicyCtrlReqTriggers": [
          "SAREA_CH"
        ]
      }
      """
    Given action name is SMF_SESSION_UPDATE_TAC
    When we send POST request
    Then we expect response status code 200
    Then we expect response time less than 2000 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content number property $..authDefQos.5qi equals 8
