Feature: Session Management Update Basic FUP

Scenario: SMF_SESSION_UPDATE_FUP
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is <LOCATION>/update
    Given request content is
      """
      {
        "accuUsageReports": [
        {
            "refUmIds": "100",
            "volUsage" : 1024000,
            "volUsageUplink" : 512000,
            "volUsageDownlink": 512000

        }
        ],
        "repPolicyCtrlReqTriggers": [
          "US_RE"
        ]
      }
      """
    Given action name is SMF_SESSION_UPDATE_FUP
    When we send POST request
    Then we expect response status code 200
    Then we expect response time less than 500 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content text property $..refUmData equals 100
    Then we expect response content property $.umDecs exist

