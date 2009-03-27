class AddTwitterToBrick < ActiveRecord::Migration
  def self.up
    add_column :bricks, :twitter, :string
  end

  def self.down
    remove_column :bricks, :twitter
  end
end
