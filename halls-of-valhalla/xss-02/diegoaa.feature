## Version 2.0
## language: en

Feature: xss-02-xss-valhalla
  Site:
    https://halls-of-valhalla.org/beta/
  Category:
    XSS
  User:
    dalvarez
  Goal:
    Inject the XSS into the form

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://halls-of-valhalla.org/challenges/xss/xss2.php
    """
    When I open the url with Chrome
    Then I see a login form
    And the message to the challenge
    """
    Your task is to inject the following XSS into this form:
    <script>alert(1)</script>
    """

  Scenario: Fail:Trying-some-payloads
    Given the login form with username and password fields
    And after trying with different xss payloads both in the fields and URL
    And without having any answer
    When I try with "<img src=xss onerror=alert('1')>" in the URL
    Then I see the form tag is malformed and leaves an attribute outside
    """
    <form action='/challenges/xss/xss2.php/<img src=xss onerror=alert('1')>
    ' method='post'>
    """
    Then I try with:
    """
    <img src=xss onerror=alert('1')><script>alert(1)</script>
    """
    Then I get the alert
    But I don't get the points
    And It seems the challenge expects another type of xss
    And I could not resolve the challenge

   Scenario: Success:Simple-xss-payload
    Given the challenge expects another type of xss
    And after make a simple payload to malforme the form tag
    And I conclude that with just "'>" the form tag is closed
    When I try with "'><script>alert(1)</script>"
    Then I get the alert
    And get the points
    And solved the challenge
