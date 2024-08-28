Feature: PCF Create AmPolicy


Scenario: PCF Create AmPolicy
  Given target type is PCF_HTTP
  Given path is /npcf-am-policy-control/v1/policies
  Given request header is Content-Type:application/json
  Given request content is
  """
 {
  "notificationUri" :  "http://testinjector2/callback/uri/CallbackReferenceUri",
  "supi" : "imsi-<imsi>",
  "accessType" : "3GPP_ACCESS",
  "userLoc" : {
    "nrLocation" : {
      "tai" : {
        "plmnId" : {
          "mcc" : "240",
          "mnc" : "81"
        },
        "tac" : "0313"
      },
      "ncgi" : {
        "plmnId" : {
          "mcc" : "240",
          "mnc" : "81"
        },
        "nrCellId" : "010203051"
      }
    }
  },
  "ratType" : "NR",
  "servAreaRes" : {
    "restrictionType" : "SAR_NON_ALLOWED_AREA",
    "tais" : [ {
      "tai" : {
        "plmnId" : {
          "mcc" : "240",
          "mnc" : "81"
        },
        "tac" : "0313"
      }
    }, {
      "tai" : {
        "plmnId" : {
          "mcc" : "240",
          "mnc" : "81"
        },
        "tac" : "1"
      }
    } ],
    "areas" : [ {
      "tacs" : [ "0001", "0002", "0003", "0004" ]
    } ]
  },
  "rfsp" : 40,
  "suppFeat" : "1"
}
  """
  When we send POST request
  Then we expect response status code 201
  Then save response header link value as SavedAmPolicy
  Then we expect response time less than 1100 milliseconds

