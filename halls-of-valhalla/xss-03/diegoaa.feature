## Version 2.0
## language: en

Feature: xss-03-xss-valhalla
  Site:
    https://halls-of-valhalla.org/beta/
  Category:
    XSS
  User:
    dalvarez
  Goal:
    Inject the XSS onto this page

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
    | OWASP Xenotix   |       6.2        |
  Machine information:
    Given the challenge URL
    """
    https://halls-of-valhalla.org/challenges/xss/xss3.php
    """
    When I open the url with Chrome
    Then I see a form to send comments
    And the message to the challenge
    """
    Your goal is to inject the javascript <script>alert(1)</script> onto this
    page. Note: this challenge is automated so there are a limited number of
    accepted answers.
    """
    When I send some comment
    Then It is displayed on screen

  Scenario: Fail:Trying-some-xss-payloads
    Given the form to send comments
    And this payloads list:
    """
    https://github.com/pgaijin66/XSS-Payloads/blob/master/payload.txt
    """
    When I try fuzzing with "Xenotix" tool
    Then I don't get any alert
    And I could not resolve the challenge

   Scenario: Success:XSS-payload-in-url-parameter
    Given the failed last attempts
    And knowing that there is a "topic" parameter
    When I try with "?topic=<variable>"
    Then I get the "<variable>" word on the page title
    Then if I try closing the tag title
    And then I inject the javascript:
    """
    ?topic=</title><script>alert(1)</script>
    """
    Then I get the alert
    And I solve the challenge
