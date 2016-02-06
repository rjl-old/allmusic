module KnowsTheDomain
  def allmusic
    @allmusic ||= Allmusic.new
  end
end

World(KnowsTheDomain)


Given(/^the nonsense artist "([^"]*)"$/) do |artist|
  @artist = artist
end

When(/^I search allmusic for the artist$/) do
  allmusic.artist = @artist
end

Then(/^I should get the error "([^"]*)"$/) do |error|
  expect { allmusic.get_meta }.to raise_error(error)
end

Given(/^the artist "([^"]*)" and album "([^"]*)"$/) do |artist, album|
  @artist = artist
  @album = album
end

When(/^I search allmusic$/) do
  allmusic.artist = @artist
  allmusic.album = @album
end

Then(/^the genre should be "([^"]*)" and$/) do |genre|
  allmusic.get_meta
  expect(allmusic.genre).to eq(genre)
end

Then(/^the style should be "([^"]*)"$/) do |style|
  expect(allmusic.style).to eq(style)
end
