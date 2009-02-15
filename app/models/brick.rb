class Brick < ActiveRecord::Base
  validates_presence_of :name
  validate :valid_email?
  
  def self.wall
    Brick.find(:all, :conditions => 'purchased_at IS NOT NULL', :order => 'purchased_at')
  end
  
  def valid_email?
    TMail::Address.parse(email) unless email.blank?
  rescue
    errors.add_to_base("Must be a valid email")
  end
  
  def protx_hash
    hash = {
      'Amount' => value,
      'Currency' => 'GBP',
      'Description' => "Buy-a-brick: #{message}",
    }
    hash['CustomerEMail'] = email unless email.blank?
    hash
  end
end
