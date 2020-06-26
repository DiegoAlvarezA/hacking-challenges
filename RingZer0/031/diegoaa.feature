## Version 2.0
## language: en

Feature: 31-javascript-ringzer0ctf
  Site:
    https://ringzer0ctf.com
  Category:
    Javascript
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
    https://ringzer0ctf.com/challenges/31
    """
    Then I open the url with Chrome
    And I see a title for the challenge
    """
    Then obfuscation is more secure?
    """
    And an input field to enter the password

  Scenario: Success:Deobfuscate-Javascript-code
    Given the title of the challenge as a hint
    Then I searched about obfuscated code
    Then understanding Obfuscated Code and how to Deobfuscate
    Then I looked for Deobfuscate tools
    And I found different ones
    But I chose for "http://www.thaoh.net/prettyjs/" (online tool)
    Then I tried to deobfuscate the javascript given in the source code
    And I got and easy code to read
    Then the password was hard code as "02l1alk3"
    Then I put the password in the input field
    And I got "FLAG-5PJne3T8d73UGv4SCqN44DXj"
    And I caught the flag

