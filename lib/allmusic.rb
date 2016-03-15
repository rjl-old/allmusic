require 'nokogiri'
require 'uri'
require 'open-uri'
require 'fuzzystringmatch' #https://github.com/kiyoka/fuzzy-string-match
require 'logger'

file = File.open('allmusic.log', File::CREAT)
$log = Logger.new( file )

# Allmusic.com client
# @param [String]
class Allmusic

  ARTIST_SEARCH_URL = "http://www.allmusic.com/search/artists/"

  def initialize( artist = nil, album = nil )
    @artist = artist
    @album  = album
    @metadata = get_metadata( @artist, @album )
  end

  def genres
    return @metadata[:genres]
  end

  def styles
    return @metadata[:styles]
  end

  private

  # return a list of the albums genre/styles
  # @param album_page [Nokogiri] the page node to parse
  # @param type [String] 'genre' | 'styles'
  # @return [string] list of genre / syles
  def parse( album_page, type = 'genre' )
    data = []
    data_nodes = album_page.xpath("//div[@class='#{type}']//a")
    data_nodes.each do |data_node|
      data << data_node.text
    end
    return data
  end

  # Sets @genre and @style for @album, @artist
  def get_metadata( artist, album )
    metadata = {:genres => [], :styles => []}
    # search for artist page e.g. http://www.allmusic.com/search/artists/abba
    artist_search_url = make_url(ARTIST_SEARCH_URL, artist)
    artist_search_page = nil
    begin
      artist_search_page = Nokogiri::HTML(open(artist_search_url))
    rescue
      return metadata
    end

    if no_search_result?(artist_search_page)
      return metadata
    end

    # get the url of the artist page
    artist_urls = artist_search_page.xpath("//ul[@class='search-results']//div[@class='name']/a")
    artist_url = best_match(artist, artist_urls)

    # get the artist discography page
    album_search_page = make_url(artist_url, '/discography/all')
    artist_discography_page = Nokogiri::HTML(open(album_search_page))

    # get album link
    album_urls = artist_discography_page.xpath("//td[@class='title']/a[1]")
    album_url = best_match(album, album_urls)

    unless album_url.nil?
      # get album page
      begin
        album_page = Nokogiri::HTML(open(album_url))
        metadata[:genres] = parse( album_page, 'genre' )
        metadata[:styles] = parse( album_page, 'styles')
      rescue
        return metadata
      end
    end
    return metadata
  end

  # @return [URL] Joins URL parts
  def make_url( root, path)
    # TODO: unsafe, not portable - File.join gives the wrong separator on windows
    # TODO: escape url
    clean_url = URI.escape(File.join(root, path))
    return clean_url
  end

  # @return [true, false] Returns `true` if no search results for the given page
  def no_search_result?(page)
    return !page.xpath('//div[@class="no-results"]').empty?
  end

  # @return [URL] The candidate with the highest Jaro-Winkler distance from target
  # @param target [String] the string to compare
  # @param candidates [Array] array of Nokogiri <A> nodes
  def best_match(target, candidates)
    # TODO: replace with a proper array sort
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
end
