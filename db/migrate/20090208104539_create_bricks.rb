class CreateBricks < ActiveRecord::Migration
  def self.up
    create_table :bricks do |t|
      t.string :url_key, :size => 4, :null => false
      
      t.string :first_name
      t.string :last_name
      
      t.string :email
      t.string :url
      t.string :message
      
      t.integer :value
      t.boolean :show_value, :default => true
      t.datetime :purchased_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bricks
  end
end
