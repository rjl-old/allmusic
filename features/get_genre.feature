Feature: Retrieve genre for artist/album

  In order to tag my music files with the a genre, as a user of iTunes, I want
  to get the album's genre and style from allmusic.com

  Scenario: Can't find an album

    Given the nonsense artist "dfgdsfgf"
    When I search allmusic for the artist
    Then I should get the error "Couldn't find artist 'dfgdsfgf'"

  Scenario Outline: Get album genres and styles from allmusic

    Given the artist "<artist>" and album "<album>"
    When I search allmusic
    Then the genre should be "<genre>" and the style should be "<style>"

    Examples:
      | artist       | album               | genre       | style                  |
      | ABBA         | Gold: Greatest Hits | Pop/Rock    | Contemporary Pop/Rock  |
      | Shooglenifty | Whisky Kiss         | Pop/Rock    | Celtic                 |
      | Spice Girls  | Spiceworld          | Pop/Rock    | Adult Contemporary     |
