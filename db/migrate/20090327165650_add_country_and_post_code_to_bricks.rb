class AddCountryAndPostCodeToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :country, :string, :size => 32
    add_column :bricks, :postcode, :string, :size => 8
  end

  def self.down
    remove_column :bricks, :postcode
    remove_column :bricks, :country
  end
end
