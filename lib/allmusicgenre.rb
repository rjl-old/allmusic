# Client for scraping Allmusic.com

require 'nokogiri'
require 'uri'
require 'open-uri'
require 'fuzzystringmatch' #https://github.com/kiyoka/fuzzy-string-match

class Allmusic

  attr_accessor :album, :artist
  attr_reader   :genre, :style

  ARTIST_SEARCH = "http://www.allmusic.com/search/artists/"
  ALBUM_SEARCH = "http://www.allmusic.com/search/albums/"

  def initialize( artist = nil, album = nil)
    @artist = artist
    @album = album
  end

  # Sets genre and style for album, artist
  def get_meta


    # search for artist page e.g. http://www.allmusic.com/search/artists/abba
    artist_search_url = make_url(ARTIST_SEARCH, @artist)
    artist_search_page = Nokogiri::HTML(open(artist_search_url))

    if no_search_result?(artist_search_page)
      raise "Couldn't find artist '#{@artist}'"
      exit
    end

    # get the url of the artist page
    artist_urls = artist_search_page.xpath("//ul[@class='search-results']//div[@class='name']/a")
    artist_url = best_match(@artist, artist_urls)

    # get the artist discography page
    album_search_page = make_url(artist_url, '/discography/all')
    artist_discography_page = Nokogiri::HTML(open(album_search_page))

    # get album link
    album_urls = artist_discography_page.xpath("//td[@class='title']/a[1]")
    album_url = best_match(@album, album_urls)


    # get album page
    album_page = Nokogiri::HTML(open(album_url))

    # get genre
    # TODO: Improve this is there are more than one
    @genre = album_page.xpath("//div[@class='genre']//a[1]").text

    # get style
    @style = album_page.xpath("//div[@class='styles']//a[1]").text
  end

  # return a clean, joined url
  # TODO: unsafe, not portable - File.join gives the wrong separator on windows
  # TODO: escape url
  def make_url( root, path)
    clean_url = File.join(root, path)

    return clean_url
  end

  def no_search_result?(page)
    return !page.xpath('//div[@class="no-results"]').empty?
  end

  # return the closest match to 'target' from list 'candidates'
  # 'closest' is highest Jaro-Winkler distance
  # TODO: replace with a proper array sort
  def best_match(target, candidates)
    confidence = 0
    best_url = nil
    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    candidates.each do |candidate|
      title = candidate.text
      distance = jarow.getDistance(target, title)
      if distance > confidence
        confidence = distance
        best_url = candidate['href']
      end
    end
    return best_url
  end

  def debug( prefix = "debug", message )
    puts "-"*50
    puts "#{prefix}: #{message}"
    puts "="*50
  end
end
