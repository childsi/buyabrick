class AddTelephoneToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :telephone, :string
  end

  def self.down
    remove_column :bricks, :telephone
  end
end
