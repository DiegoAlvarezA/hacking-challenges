## Version 2.0
## language: en

Feature: ybegin-kryptos-world-of-wargame
  Site:
    https://wow.sinfocol.org/
  Category:
    Kryptos
  User:
    dalvarez
  Goal:
    Decrypt the given code

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Windows         | 10.0.1809 (x64)  |
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    Then I open the url with Chrome
    And I see the description to the challenge
    """
    Unos viejos amigos de una red muy popular me han enviado un código
    que dijeron era incapáz de decodificar! Y tuvieron toda la razón, no
    pude, así que les dejo el trabajo sucio a ustedes mis queridos usuarios!
    Esto fue lo que me enviaron:
    =ybegin line=128 size=6 name=sinfocol_yenc.ntx
    }oxo~
    =yend size=6 crc32=A5F4AB94
    """

  Scenario: Success:Decrypt-with-the correct-encoded-type
    Given the code
    And I see an extension ".ntx"
    Then I search if it is a valid extension
    Then I upload the file to "https://filext.com/file-extension/NTX"
    And I got this message:
    """
    The file looks like a YNC (yEnc Encoded) file
    """
    Then I change the extension to ".ync" and analize it again
    And  I got this message:
    """
    It's really a YNC file! The file type is yEnc Encoded.
    """
    Then I try to decode with "http://www.webutils.pl/index.php?idx=yenc"
    And I get this:
    """
    USENET
    """
    Then I try with the previous answer
    And I solve the challenge
