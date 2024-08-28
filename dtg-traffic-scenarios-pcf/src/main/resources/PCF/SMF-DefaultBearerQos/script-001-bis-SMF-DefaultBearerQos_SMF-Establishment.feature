Feature: Session Management Policy Establishment with Default Qos and Bandwidth 

   Scenario: 	Callback handler initialization for udr subscriber
    Given action name is UDR_QUERY
    Given callback request to server type GENERIC_HTTP
    Given callback request path prefix <udrSubscriptionUri>
    Given callback request with before key imsi-
    Given callback request with after key /sm-data
    Then we wait for callback request

Scenario: Default callback handler initialization for subscription
    Given action name is UDR_SUBSCRIBER_REQUEST
    Given callback request to server type GENERIC_HTTP
    Given callback request path prefix <udrSubsNotifyUri>
    Given callback request content before key imsi-
    Given callback request content after key /sm-data
    Given callback request HTTP method POST
    Then we wait for callback request
    

  Scenario: SMF_SESSION_ESTABLISMENT
    Given target type is PCF_HTTP
    Given target tag is PCF
    Given path is /npcf-smpolicycontrol/v1/sm-policies
    Given IPv4_Address computed using Convert-IMSI-to-IPv4-Address algorithm
    Given request content is
      """
      {
        "supi": "imsi-<imsi>",
        "pduSessionId": <pduSessionId>,
        "pduSessionType": "IPV4",
        "dnn": "dnn_mbb.com",
        "ipv4Address": "<IPv4_Address>",
        "notificationUri": "http://<SMF_SERVER_ADDRESS>:<SMF_SERVER_PORT><smfNotificationUri>/imsi-<imsi>;<pduSessionId>",
        "sliceInfo": {
          "sst": 2,
          "sd": "000002"
        },
        "ratType": "NR",
        "suppFeat": "0",
        "subsSessAmbr": {
          "downlink": "3 Gbps",
          "uplink": "2 Gbps"
        },
        "subsDefQos": {
          "5qi": 5,
          "arp": {
            "preemptCap": "NOT_PREEMPT",
            "preemptVuln": "NOT_PREEMPTABLE",
            "priorityLevel": 1
          }
        },
        "userLocationInfo": {
          "nrLocation": {
            "tai": {
              "plmnId": {
                "mnc": "81",
                "mcc": "240"
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

    Given action name is SMF_SESSION_ESTABLISMENT
    When we send POST request
    Given callback handler action name is UDR_QUERY
    Then we expect callback request
    Then we send callback response with status code 200 and content
      """
      {
        "smPolicySnssaiData": {
          "2-000002": {
            "snssai": {
              "sst": 2,
              "sd": "000002"
            },
            "smPolicyDnnData": {
              "dnn_mbb.com": {
                "dnn": "dnn_mbb_com",
                "subscCats": [
                  "5G_Bronze",
                  "group_5G_temp1",
                  "group_5G_temp2",
                  "group_5G_temp3"
                ]
              }
            }
          }
        }
      }
      """
    Given callback handler action name is UDR_SUBSCRIBER_REQUEST
    Then we expect callback request
    Then we send callback response with status code 201 and header location:<udrSubsNotifyUri>/imsi-<imsi> and content
      """
      {
        "notificationUri": "http://<UDR_CLIENT_DESTINATION_HOST>:<UDR_CLIENT_DESTINATION_PORT>/npcf-smpolicycontrol/v1/callback/nudr",
        "monitoredResourceUris": [
          "<udrSubscriptionUri>/imsi-<imsi>/sm-data"
        ]
      }
      """
    Then we expect response status code 201
    Then we expect response time less than 1100 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content text property $..sessRuleId equals imsi-<imsi>;<pduSessionId>;sessRuleId1
    Then we expect response content text property $..authSessAmbr.uplink equals 2 Gbps
    Then we expect response content text property $..authSessAmbr.downlink equals 3 Gbps
    Then we expect response content number property $..5qi equals 6
    Then we expect response content list property policyCtrlReqTriggers equals DEF_QOS_CH,RAT_TY_CH,RE_TIMEOUT,SAREA_CH,SE_AMBR_CH,US_RE
    Then we expect response content property $.pccRules contain 4 objects
    Then we expect response content property $..100 exist
    Then we expect response content property $..102 exist
    Then we expect response content property $..105 exist
    Then we expect response content property $..108 exist
    Then save response header location value as LOCATION


