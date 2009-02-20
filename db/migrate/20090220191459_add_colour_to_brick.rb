class AddColourToBrick < ActiveRecord::Migration
  def self.up
    add_column :bricks, :colour, :string, :size => 8
  end

  def self.down
    remove_column :bricks, :colour
  end
end
