class Wall
  attr_accessor :bricks, :total
  
  def initialize
    self.bricks = Brick.find(:all, :conditions => 'purchased_at IS NOT NULL', :order => 'purchased_at DESC', :limit => 160)
    self.total = Brick.sum(:value, :conditions => 'purchased_at IS NOT NULL') / 100.0
  end
  
  def rows
    @rows ||= bricks.in_groups_of(16).reverse
  end
  
  def empty_rows
    10 - rows.size
  end
end