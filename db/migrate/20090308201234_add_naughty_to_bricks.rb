class AddNaughtyToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :naughty, :boolean, :default => false
  end

  def self.down
    remove_column :bricks, :naughty
  end
end
