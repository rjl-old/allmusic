# Allmusic

Get genre and style information from [allmusic.com](http://www.allmusic.com)

## Installation

    gem install rjl-allmusic

## Usage

    spicy = Allmusic.new "Spice Girls", "Spiceworld"
    spicy.get_meta
    puts spicy.genre # => "Pop/Rock"
    puts spicy.style # => "Adult Contemporary"

## How it works

`Allmusicgenre` is a webscraper. It uses fuzzy string matching to improve flexibility and match.

Given an `(artist)` and an `(album)`, it:

1. Loads `http://www.allmusic.com/search/artists/(artist)`
2. Finds the (best artist match) between (artist) and the artists listed
3. Loads `http://www.allmusic.com/artist/(best artist match)/discography`
4. Finds the (best album match) between (album) and the albums listed
5. Loads `http://www.allmusic.com/album/(best album match)`
6. Sets `genre` to be the first genre
7. Sets `style` to be the first style

'Best' match is defined as the match with the highest [Jaro-Winkler distance](https://en.wikipedia.org/wiki/Jaro–Winkler_distance) from the given artist or album.

## Credits

Kiyoka Nishiyama [What is fuzzy-string-match](https://github.com/kiyoka/fuzzy-string-match)

## Copyright

Copyright (c) 2016 Richard Lyon. See LICENSE.txt for
further details.
