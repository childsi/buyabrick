class BrickForgery < Forgery
  def self.value
    case (rand)
      when 0..0.5 then MonetaryForgery.money(:min => 250, :max => 9_99)
      when 0.5..0.7 then MonetaryForgery.money(:min => 10_00, :max => 19_99)
      when 0.7..0.9 then MonetaryForgery.money(:min => 20_00, :max => 49_99)
      else MonetaryForgery.money(:min => 49_99, :max => 499_99)
    end
  end
  
  def self.brick_params
    first, last = NameForgery.first_name, NameForgery.last_name
    domain = InternetForgery.domain_name
    {
      :first_name => first,
      :last_name => last,
      :email => (rand > 0.5) ? "#{first}.#{last}@#{domain}" : nil,
      :url => (rand > 0.5) ? "http://#{domain}" : nil,
      :message => LoremIpsumForgery.sentence,
      :value => value,
      :show_value => (rand > 0.2),
      :purchased_at => (rand > 0.2) ? Time.now : nil,
    }
  end
end
