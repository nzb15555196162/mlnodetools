xquery version "1.0-ml";

module namespace ext = "http://marklogic.com/rest-api/resource/mljsadmintest";

import module namespace json6 = "http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";

import module namespace t = "http://marklogic.com/mljsadmin/test" at "/app/models/lib-mljsadmin-test.xqy";

declare namespace roxy = "http://marklogic.com/roxy";

(:
 : To add parameters to the functions, specify them in the params annotations.
 : Example
 :   declare %roxy:params("uri=xs:string", "priority=xs:int") ext:get(...)
 : This means that the get function will take two parameters, a string and an int.
 :)

(:
 :)
declare function ext:get(
  $context as map:map,
  $params  as map:map
) as document-node()*
{
  let $preftype := if ("application/xml" = map:get($context,"accept-types")) then "application/xml" else "application/json"
  let $out := t:test("wibble");
  return
  (
    xdmp:set-response-code(200, "OK"),
    document {
      if ("application/xml" = $preftype) then
        <ext:result>{$out}</ext:result>
      else
        fn:concat("{""result"": """,$out,"""}")
    }
  )
};
