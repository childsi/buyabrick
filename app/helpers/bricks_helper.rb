module BricksHelper
  def brick_image_tag(value)
    name = (value.blank?) ? 'any' : value.to_i.round
    image_tag("/images/bricks/_#{name}.jpg", :alt => "£#{name} brick")
  end
end
