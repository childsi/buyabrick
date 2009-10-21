class AddSubscribeToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :subscribe, :boolean, :default => true
  end

  def self.down
    remove_column :bricks, :subscribe
  end
end
