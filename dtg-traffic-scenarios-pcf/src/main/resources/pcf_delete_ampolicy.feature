Feature: PCF AmPolicy Deregistration

Scenario: Delete AmPolicy with PCF
  Given target type is PCF_HTTP
  Given path is /npcf-am-policy-control/v1/policies/imsi-<imsi>_http___testinjector2_callback_uri_CallbackReferenceUri
  Given request header is Content-Type:application/json

  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 1100 milliseconds

