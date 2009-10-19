# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def embed_wall_swf_tag(brick=nil, thanks=false)
    brick_link = %[, linkBrick: "#{brick.url_key}", isThanks: #{thanks}] if brick
    %[<script type="text/javascript">
    swfobject.embedSWF("http://www.childsifoundation.org/files/buyabrick/wall.swf", "wall", "800", "444", "9.0.0", "", { path: "/wall.xml", config: "http://www.childsifoundation.org/files/buyabrick/xml/config.xml"#{brick_link} }, {allowscriptaccess:"always"});
    </script>]
  end
end
