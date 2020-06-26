## Version 2.0
## language: en

Feature: javascript-01-javascript-valhalla
  Site:
    https://halls-of-valhalla.org/beta/
  Category:
    Javascript
  User:
    dalvarez
  Goal:
    Get the password from the server

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://halls-of-valhalla.org/beta/challenges/javascript1
    """
    When I open it with Chrome
    Then I can see the description to the challenge
    """
    Here is this awesome new AJAX function I just wrote for this page. Here is
    the PHP on the server-side:
    """
    And I see the PHP code on the server
    And an input field that tells if its value (number) is odd or even
    And an input field to submit the password

  Scenario: Success:Execute-function-that-returns-password
    Given the PHP code on the server
    And I see there is a function that returns the password "getPassword()"
    And the request contents the function to be execute "func=getOutputOther"
    When I specify the function in the request "func=getPassword"
    Then the server returns this:
    """
    asdoulkwejoiu839u8345st
    """
    And I submit the previous output in the input password
    And I solve the challenge
