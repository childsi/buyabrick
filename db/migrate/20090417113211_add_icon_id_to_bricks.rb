class AddIconIdToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :icon_id, :integer
  end
  
  def self.down
    remove_column :bricks, :icon_id
  end
end
