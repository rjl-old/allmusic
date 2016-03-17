require_relative '../lib/allmusic'

describe Allmusic do

  context "when valid artist and album is given" do
    it "gets the expected metadata" do
      artist = "Spice Girls"
      album = "Spiceworld"
      expected_genres = ["Pop/Rock", "Electronic"]
      expected_styles = ["Adult Contemporary", "Dance-Pop", "Euro-Dance", "Euro-Pop", "Teen Pop", "Club/Dance"]
      allmusic = Allmusic.new( artist, album )
      expect(allmusic.genres).to eq(expected_genres)
      expect(allmusic.styles).to eq(expected_styles)
    end
  end

  context "when nonsense is given" do
    it "returns empty lists" do
        artist = "dsfsdfs"
        album = "sdfsfsadfas"
        allmusic = Allmusic.new( artist, album )
        expect(allmusic.genres).to eq([])
        expect(allmusic.styles).to eq([])
    end
  end
end
