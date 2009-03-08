module RandomKey

  def self.included(base)
    base.extend ClassMethods
    class << base
      attr_accessor :random_key_field
      attr_accessor :random_key_size
      attr_accessor :random_key_type # uppercase, downcase, numbers
    end
  end
  
  module ClassMethods
    def has_random_key(field_name, options = {})
      self.random_key_field    = field_name
      self.random_key_size     = options[:size] || 10
      self.random_key_type     = [*options[:include]] if options[:include]

      before_create :set_random_key
    end
  end

protected
  def set_random_key
    while send(self.class.random_key_field).blank?
      s=generate_random_string
      unless self.class.find(:first, :conditions => { self.class.random_key_field => s })
        send("#{self.class.random_key_field}=", s)
      end
    end
  end
  
  def generate_random_string
    if type = self.class.random_key_type
      chars = []
      chars += ('a'..'z').to_a if type.include?(:downcase)
      chars += ('A'..'Z').to_a if type.include?(:uppercase)
      chars += ('0'..'9').to_a if type.include?(:numbers)
    else
      chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    end
    chars.flatten!
    
    chars.inject('') { |t,i| t << chars[rand(chars.size)] }[0..self.class.random_key_size-1]
  end
end
