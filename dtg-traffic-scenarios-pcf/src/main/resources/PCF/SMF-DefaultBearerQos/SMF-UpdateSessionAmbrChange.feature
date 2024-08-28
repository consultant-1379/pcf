Feature: Session Management Policy Update by Session AMBR Change
Scenario: SMF_SESSION_UPDATE_AMBR
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <smpcUriPrefix><LOCATION>/update
    Given request content is
      """
      {
        "subsSessAmbr": {
          "downlink": "5 Gbps",
          "uplink": "3 Gbps"
        },
        "repPolicyCtrlReqTriggers": [
          "SE_AMBR_CH"
        ]
      }
      """
    Given action name is SMF_SESSION_UPDATE_AMBR
    When we send POST request
    Then we expect response status code 200
    Then we expect response time less than 1100 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content text property $..authSessAmbr.uplink equals 3 Gbps
    Then we expect response content text property $..authSessAmbr.downlink equals 5 Gbps
