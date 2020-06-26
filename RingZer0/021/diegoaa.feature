## Version 2.0
## language: en

Feature: 21-sql-injection-ringzer0ctf
  Site:
    https://ringzer0ctf.com
  Category:
    SQL Injection
  User:
    dalvarez
  Goal:
    capture the flag

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://ringzer0ctf.com/challenges/21
    """
    When I open the url with Chrome
    Then I see a login form
    And the input field to submit the flag

  Scenario: Success:Sql-injection
    Given the login form with user and password fields
    When I put a single quote in the password field
    Then I get this error:
    """
    ERROR: syntax error at or near "da39a3ee5e6b4b0d3255bfef95601890afd80709"
    LINE 1: ...OM users WHERE (username = (''') AND password = ('da39a3ee5e... ^
    """
    And I see part of the query
    Then I try to login as admin user by building the following:
    """
    admin
    """
    And I close the query with:
    """
    admin'))
    """
    And double dash at the end to avoid execution of the following conditions
    Then I submit the form with "admin'))--"
    And I get the flag "FLAG-mdeq68jNN88xLB1o2m8V33Ld"
