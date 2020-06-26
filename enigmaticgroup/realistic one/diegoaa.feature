## Version 2.0
## language: en

Feature: realistic-one-realistic-enigmagroup
  Site:
    https://www.enigmagroup.org/
  Category:
    Realistic
  User:
    dalvarez
  Goal:
    Gain root of the server and deface the site

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://www.enigmagroup.org/pages/realistic
    """
    When I open it with Chrome
    Then I can see the description to the challenge
    """
    Some of us at enigmagroup have been getting sick and tired of
    Psychomarine's bragging on how much of a 1337 hacker he is. He even put up
    a website showing off his accomplishments. It's time someone put him in his
    place. I need you to gain root of his server and deface his site. Knocking
    him off his high horse. I already did a port scan of his server. You can
    check it out here. It might have some valuable information for you.
    Click to Accept Mission
    """
    And I see an image about a port scanning with nmap
    """
    http://challenges.enigmagroup.org/realistics/1/images/nmap_scan.png
    """
    And I click to accept
    And I get redirect to "Psychomarine" page
    """
    http://challenges.enigmagroup.org/realistics/1/
    """

  Scenario: Fail:Trying-ssh
    Given the web page
    And I see that pages are load with the parameter "?page=homepage"
    When I try with "?page=hi"
    Then I get this message:
    """
    You are on the right track. Psychomarine made a PHP include() coding flaw.
    (This exploit is simulated. Only the correct path is accepted. Did you
    really think we would give you full access to our server?)
    """
    And I make a directory traversal:
    """
    http://challenges.enigmagroup.org/realistics/1/?page=../../../../../etc/
    passwd
    """
    And I get this:
    """
    root:4d1Yq6PXGzYm6:0:0:root:/root:/bin/bash
    psychomarine:4doxGUy8UpD0o:500:500:psychomarine:/home/psychomarine:/bin/bash
    mets0c30:4d.0gmeqJKnns:501:501:mets0c30:/home/mets0c30:/bin/bash
    xero:4daaaoH4HRORM:502:502:xero:/home/xero:/bin/bash
    """
    And I decrypt the root password with "hashcat-5.1.0"
    And I try to connect with SSH "ssh root@enigmagroup.org -p 22"
    But the connection was denied by the server
    And I don't get anything, just errors

  Scenario: Success:Using-credentials-in-the-URL
    Given I try to connect through terminal, with different ports
    And I don't get any correct response
    When I look for one way to do it through the browser
    And I don't find any login page
    Then I find this method "https://username:password@www.example.com/"
    And I try with this:
    """
    https://root:31337@enigmagroup.org:8080
    """
    But I get a connection refused
    And I try with this port given in the nmap scanning:
    """
    https://root:31337@enigmagroup.org:1337
    """
    And I get a login page
    And I log in with username:root and password:31337
    And I get in the server [evidence](server.png)
