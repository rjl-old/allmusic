# Allmusic 0.4

Get genre and style information from [allmusic.com](http://www.allmusic.com)

## Installation

    gem install rjl-allmusic

## Usage

    require 'allmusic'

    spicy = Allmusic.new "Spice Girls", "Spiceworld"
    puts spicy.genres # => ["Pop/Rock", "Electronic"]
    puts spicy.styles # => ["Adult Contemporary", "Dance-Pop", "Euro-Dance", "Euro-Pop", "Teen Pop", "Club/Dance"]

## How it works

`Allmusicgenre` is a webscraper. It uses fuzzy string matching to improve flexibility and match.

Given an `(artist)` and an `(album)`, it:

1. Loads `http://www.allmusic.com/search/artists/(artist)`
2. Finds the (best artist match) between (artist) and the artists listed
3. Loads `http://www.allmusic.com/artist/(best artist match)/discography`
4. Finds the (best album match) between (album) and the albums listed
5. Loads `http://www.allmusic.com/album/(best album match)`
6. Gets 'genres' and 'styles'

'Best' match is defined as the match with the highest [Jaro-Winkler distance](https://en.wikipedia.org/wiki/Jaro–Winkler_distance) from the given artist or album.

## Warning

This is an early release. There are exactly three test cases. I would be stunned if it did not break at around five.

## Changes

0.1 Initial release
0.2 Add 'genres' and 'styles' attributes to return list of all
0.3 Improve recovery from bad searchs
0.4 'Initialise' gets meta. Added tests. Clean code.

## TODO

1. Pick cooler test cases.

## Credits

Kiyoka Nishiyama [What is fuzzy-string-match](https://github.com/kiyoka/fuzzy-string-match)

## Copyright

Copyright (c) 2016 Richard Lyon. See LICENSE.txt for
further details.
