Feature: Session Management Policy Update by Default Qos Change
Scenario: SMF_SESSION_UPDATE_QOS
    Given target type is SAPC_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/update
    Given request content is
      """
      {
        "subsDefQos": {
          "5qi": 9,
          "arp": {
            "preemptCap": "NOT_PREEMPT",
            "preemptVuln": "NOT_PREEMPTABLE",
            "priorityLevel": 9
          }
        },
        "repPolicyCtrlReqTriggers": [
          "DEF_QOS_CH"
        ]
      }
      """
    Given action name is SMF_SESSION_UPDATE_QOS
    When we send POST request
    Then we expect response status code 200
    Then we expect response time less than 2000 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content number property $..authDefQos.5qi equals 9
