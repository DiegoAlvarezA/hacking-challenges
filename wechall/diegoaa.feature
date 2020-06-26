## Version 2.0
## language: en

Feature: php-0817-phpexploit-wechall
  Site:
    https://www.wechall.net/
  Category:
    PHP Exploit
  User:
    dalvarez
  Goal:
    include solution.php

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://www.wechall.net/challenge/php0817/index.php
    """
    Then I open the url with Chrome
    And I see a description of the challenge
    """
    I have written another include system for
    my dynamic webpages,
    but it seems to be vulnerable to LFI.
    Here is the code:
    <?php
    if (isset($_GET['which']))
    {
        $which = $_GET['which'];
        switch ($which)
        {
        case 0:
        case 1:
        case 2:
                require_once $which.'.php';
                break;
        default:
                echo GWF_HTML::error('PHP-0817',
                'Hacker NoNoNo!', false);
                break;
         }
     }
    ?>
    """

  Scenario: Fail:passing-expected-parameters
    Given the PHP source code
    Then I noticed that the code expected the one parameter (which)
    Then I conclude the parameter is the page name to include
    Then I passed ?which=solution.php to the URL
    And get the following error
    """
    PHP Warning(2): require_once(solution.php.php):
    failed to open stream: No such file or directory
    in /home/wechall/www/wc5/www/challenge/php0817/php0817.include
    line 10
    """
    Then I decide to look at the code one more time

  Scenario: Success:passing-parameter-without-extension
    Then I noticed the code attached and extra extension to the parameter
    Then I passed the parameter ?which=solution
    And I conclude that ?which=solution worked
    And solved the challenge
