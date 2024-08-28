Feature: Session Management Policy Establishment with Default Qos and Bandwidth 
  Scenario: SMF_SESSION_ESTABLISMENT
    Given target type is SAPC_HTTP
    Given target tag is PCF
    Given path is /npcf-smpolicycontrol/v1/sm-policies
    Given IPv4_Address computed using Convert-IMSI-to-IPv4-Address algorithm
    Given request content is
      """
{
  "supi" : "imsi-<imsi>",
  "gpsi" : "msisdn-<msisdn>",
  "pduSessionId" : <pduSessionId>,
  "pduSessionType" : "IPV4",
  "dnn" : "dnn_mbb.com",
  "notificationUri" : "http://10.141.189.6:8082/policy/notification",
  "accessType" : "3GPP_ACCESS",
  "ratType" : "EUTRA",
  "userLocationInfo" : {
    "eutraLocation" : {
      "tai" : {
        "plmnId" : {
          "mcc" : "460",
          "mnc" : "00"
        },
        "tac" : "0064"
      },
      "ecgi" : {
        "plmnId" : {
          "mcc" : "460",
          "mnc" : "00"
        },
        "eutraCellId" : "0000001"
      },
      "ignoreEcgi" : false
    }
  },
  "ipv4Address" : "<IPv4_Address>",
  "ipDomain" : "10.10.10.1",
  "subsSessAmbr" : {
    "uplink" : "2 Mbps",
    "downlink" : "3 Mbps"
  },
  "subsDefQos" : {
    "arp" : {
      "priorityLevel" : 4,
      "preemptCap" : "MAY_PREEMPT",
      "preemptVuln" : "PREEMPTABLE"
    },
    "5qi" : 6
  },
  "sliceInfo" : {
    "sst" : 2,
    "sd" : "000002"
  },
  "suppFeat" : "20000"
}
      """
    Given action name is SMF_SESSION_ESTABLISMENT
    When we send POST request
    Then we expect response status code 201
    Then save response header location value as LOCATION
    Then we expect response time less than 5000 milliseconds
