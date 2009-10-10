xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0", 'xmlns:atom' => "http://www.w3.org/2005/Atom") do
  xml.channel do
    xml.title("Child's i Foundation - Buy a Brick")
    xml.link(home_url)
    xml.tag!('atom:link', :href => formatted_bricks_url(:format => 'rss'), :rel => 'self', :type => "application/rss+xml")
    xml.description("What your site is all about.")
    xml.language('en-gb')
      for brick in @bricks
        xml.item do
          xml.title(brick.title)
          xml.description(brick.twitter_message)
          xml.pubDate(brick.purchased_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(brick_url(brick))
          xml.guid(brick_url(brick))
        end
      end
  end
end
