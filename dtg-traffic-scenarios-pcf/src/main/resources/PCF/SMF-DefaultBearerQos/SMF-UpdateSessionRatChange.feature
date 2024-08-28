Scenario: SMF_SESSION_UPDATE_RAT
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <smpcUriPrefix><LOCATION>/update
    Given request content is
      """
      {
        "subsSessAmbr": {
          "uplink": "2 Gbps",
          "downlink": "3 Gbps"
        },
        "subsDefQos": {
          "5qi": 5,
          "arp": {
            "preemptCap": "NOT_PREEMPT",
            "preemptVuln": "NOT_PREEMPTABLE",
            "priorityLevel": 1
          }
        },
        "ratType": "EUTRA",
        "repPolicyCtrlReqTriggers": [
          "RAT_TY_CH"
        ]
      }
      """
    Given action name is SMF_SESSION_UPDATE_RAT
    When we send POST request
    Then we expect response status code 200
    Then we expect response time less than 1100 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content text property $..authSessAmbr.uplink equals 1 Gbps
    Then we expect response content text property $..authSessAmbr.downlink equals 2 Gbps
    Then we expect response content number property $..authDefQos.5qi equals 9