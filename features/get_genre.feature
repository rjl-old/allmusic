Feature: Retrieve genre for artist/album

  In order to tag my music files with the a genre, as a user of iTunes, I want
  to get the album's genre and style from allmusic.com

  Scenario: Can't find an album

    Given the nonsense artist "dfgdsfgf"
    When I search allmusic for the artist
    Then I should get the error "Couldn't find artist 'dfgdsfgf'"

  Scenario: Get album genre from allmusic

    Given the artist "ABBA" and album "Gold: Greatest Hits"
    When I search allmusic
    Then the genre should be "Pop/Rock" and
    And the style should be "Contemporary Pop/Rock"
