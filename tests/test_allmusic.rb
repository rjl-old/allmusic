require 'test/unit'
require 'test/unit/assertions'
require_relative '../lib/allmusic'

class TestAllmusic < Test::Unit::TestCase

  def test_get_metadata
    artist = "Spice Girls"
    album = "Spiceworld"
    allmusic = Allmusic.new( artist, album )
    expected_genres = ["Pop/Rock", "Electronic"]
    expected_styles = ["Adult Contemporary", "Dance-Pop", "Euro-Dance", "Euro-Pop", "Teen Pop", "Club/Dance"]
    # allmusic.get_meta
    assert_equal(expected_genres, allmusic.genres)
    assert_equal(expected_styles, allmusic.styles)
  end

  # def test_nonsense_album
  #   artist = "sdfsfsd"
  #   allmusic = Allmusic.new( artist )
  #   allmusic.get_meta
  #   assert_equal(nil, allmusic.genres)
  #   assert_equal(nil, allmusic.styles)
  # end

  # def test_album_missing
  # end
end
