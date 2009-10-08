require 'open-uri'

module UrlShortener
  def self.shorten(link)
    open('http://bit.ly/api?url=' + link, "UserAgent" => "Ruby-ShortLinkCreator").read
    rescue => e
      link
  end
end
