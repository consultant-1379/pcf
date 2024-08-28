Feature: Session Management Policy Update by group change

Scenario: Callback handler initialization for notification
    Given callback request to server type SMF_HTTP
    Given callback request path prefix <smfNotificationUri>
    Given callback request with before key imsi-
    Given callback request with after key ;<pduSessionId>
    Given action name is SUBSCRIBER_NOTIFICATION
    Then we wait for callback request

Scenario: UDR_NOTIFICATION_CHANGE
    Given target type is UDR_HTTP
    Given target tag is UDR
    Given path is /npcf-smpolicycontrol/v1/callback/nudr
    Given request content is
      """
      {
        "ueId": "imsi-<imsi>",
        "smPolicyData": {
          "smPolicySnssaiData": {
            "2-000002": {
              "snssai": {
                "sst": 2,
                "sd": "000002"
              },
              "smPolicyDnnData": {
                "dnn_mbb.com": {
                  "dnn": "dnn_mbb.com",
                  "subscCats": [
                    "5G_Silver"
                  ]
                }
              }
            }
          }
        }
      }
      """
    Given action name is UDR_NOTIFICATION_CHANGE
    When we send POST request
    Then we expect response status code 204
    Then we expect response time less than 1100 milliseconds
    Then we expect response header content-length equals 0
    Then we do not expect response content

  Scenario: Wait for callbacl request and perfom action
    Given action name is callback
    When we receive callback request
    Then we expect request content text property resourceUri equals http://<PCF_CLIENT_DESTINATION_HOST>:<PCF_CLIENT_DESTINATION_PORT>/npcf-smpolicycontrol/v1/sm-policies/imsi-<imsi>;<pduSessionId>
    Then we expect request content text property $..sessRuleId equals imsi-<imsi>;<pduSessionId>;sessRuleId1
    Then we expect request content text property $..authSessAmbr.uplink equals 3 Gbps
    Then we expect request content text property $..authSessAmbr.downlink equals 5 Gbps
    Then we expect request content number property $..authDefQos.5qi equals 8
    Then we send response with status code 204

