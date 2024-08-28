Feature: Session Management Policy Establishment with Basic Fair Usage

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
        "notificationUri": "http://10.200.67.66:7072<smfNotificationUri>/imsi-<imsi>|<pduSessionId>",
        "sliceInfo": {
          "sst": 2,
          "sd": "000002"
        },
        "ratType": "NR",
        "smfId": "smf1",
        "suppFeat": "10",
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
        }
      }
      """

    Given action name is SMF_SESSION_ESTABLISMENT
    When we send POST request
    Then we expect response status code 201
    Then we expect response time less than 500 milliseconds
    Then we expect response content property $.sessRules contain 1 objects
    Then we expect response content property $..sessRuleId exist
    Then we expect response content text property $..authSessAmbr.uplink equals 2 Mbps
    Then we expect response content text property $..authSessAmbr.downlink equals 3 Mbps
    Then we expect response content number property $..authDefQos.5qi equals 9
    Then we expect response content list property policyCtrlReqTriggers equals RAT_TY_CH,RE_TIMEOUT,SE_AMBR_CH,US_RE
    Then we expect response content property $.pccRules contain 5 objects
    Then we expect response content property $..100 exist
    Then we expect response content property $..102 exist
    Then we expect response content property $..105 exist
    Then we expect response content property $..108 exist
    Then we expect response content property $..3002 exist
    Then we expect response content property $.qosDecs exist
    Then we expect response content property $..qosDecs.QosProfile2 exist
    Then we expect response content property $.traffContDecs exist
    Then we expect response content property $.umDecs exist
    Then we expect response content property $..umDecs.100 exist
    Then we expect response content text property $.suppFeat equals 10
    Then save response header location value as LOCATION
    