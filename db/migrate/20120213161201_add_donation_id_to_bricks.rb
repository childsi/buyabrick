class AddDonationIdToBricks < ActiveRecord::Migration
  def self.up
    add_column :bricks, :donation_id, :string
  end

  def self.down
    remove_column :bricks, :donation_id
  end
end
