class Wall
  attr_accessor :bricks, :total
  
  def initialize
    self.bricks = Brick.find(:all,
      :limit => 160,
      :order => 'purchased_at DESC', 
      :conditions => ["purchased_at IS NOT NULL and naughty=:naughty", { :naughty => false }])
    self.total = Brick.sum(:value, :conditions => 'purchased_at IS NOT NULL') / 100.0
  end
  
  def rows
    @rows ||= bricks.in_groups_of(16)
  end
  
  def empty_rows
    10 - rows.size
  end
end