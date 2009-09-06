class AddDisplayNameToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :display_name, :string
  end

  def self.down
    remove_column :bricks, :display_name
  end
end
