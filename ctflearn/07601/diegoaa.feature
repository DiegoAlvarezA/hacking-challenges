## Version 2.0
## language: en

Feature: 07601-forensics-ctflearn
  Site:
    https://ctflearn.com
  Category:
    Forensics
  User:
    dalvarez
  Goal:
    capture the flag 

  Background:
  Hacker's software:
    | <Software name> |    <Version>     |
    | Ubuntu          |18.04.02 LTS (x64)|
    | Chrome          | 75.0.3770.142    |
  Machine information:
    Given the challenge URL
    """
    https://ctflearn.com/problems/97
    """
    Then I open the url with Chrome
    And I see a description of the challenge
    """
    https://mega.nz/#!CXYXBQAK!6eLJSXvAfGnemqWpNbLQtOHBvtkCzA7-zycVjhHPYQQ 
    I think I lost my flag in there. Hopefully, it won't get attacked...
    """
    Then I downloaded the file
    And I got image "AGT.png"

  Scenario: Fail:Opening-the-file
    Given the downloaded file, I tried to opened it
    Then I got a error
    """
    Error fatal leyendo el archivo gráfico PNG: Not a PNG file
    """
    Then I conclude the file was not and image
    Then I tried to open with some text editor
    And It got slow when opening the file
    Then I tried the command "cat"
    And I looked for "ABCTF{the_flag}" in the file
    But with "cat" command, it just print
    """
    Coincidencia en el archivo binario AGT.png
    """
    Then I made a research about how to get binary data from a file

  Scenario: Fail:Extract-binary-data
    Given the following solution to extract binary data from a file
    """
    https://stackoverflow.com/questions/38833090/how-to-extract-text-portion-of-a-binary-file-in-linux-bash
    """
    Then I executed "strings AGT.png"
    And I got data in a human-readable way 
    Then I executed "strings AGT.png | grep ABCTF"
    And I got a flag
    """
    ABCTF{fooled_ya_dustin}
    """
    Then I tried with that flag
    But It was the wrong one
  
  Scenario: Success:Extract-hidden-files
    Given the data with the command "strings"
    Then I inspected it, and I got these lines
    """
    __MACOSX/Secret Stuff.../UX
      O^I
    __MACOSX/Secret Stuff.../Don't Open This.../UX
	    O^Ip
    __MACOSX/Secret Stuff.../Don't Open This.../._I Warned You.jpegUX
    """
    And I wondered, there may be more files here
    Then I read an article about how to hide files inside images in linux
    """
    https://www.makeuseof.com/tag/hide-files-inside-images-linux/
    """
    And I conclude that It can be reach with ZIP
    Then I tried to unzip the file, and I got this file
    """
    I Warned You.jpeg
    """
    Then I tried with "strings I\ Warned\ You.jpeg | grep ABCTF"
    And I got a flag
    """
    ABCTF{Du$t1nS_D0jo}
    """
    Then I tried, It worked
    And solved the challenge
