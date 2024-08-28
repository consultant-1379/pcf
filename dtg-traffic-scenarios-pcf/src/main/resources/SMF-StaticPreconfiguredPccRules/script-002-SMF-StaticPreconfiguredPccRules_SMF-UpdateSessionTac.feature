Feature: Session Management Update by session TAC Change 

Scenario: SMF_SESSION_UPDATE_TAC
    Given target type is PCF_HTTP
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
              "tac": "0065"
            },
            "ncgi": {
              "plmnId": {
                "mcc": "240",
                "mnc": "81"
              },
              "nrCellId": "010203065"
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
    Then we expect response time less than 500 milliseconds
    Then we expect response content property $..2000 exist
    Then we expect response content property $..3000 exist
    Then we expect response content property $..3001 exist
    Then we expect response content property $.qosDecs exist
    Then we expect response content property $..qosDecs.QosProfile_nonGBR_high exist
