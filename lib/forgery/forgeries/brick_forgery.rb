class BrickForgery < Forgery
  def self.brick_params
    first, last = NameForgery.first_name, NameForgery.last_name
    domain = InternetForgery.domain_name
    {
      :first_name => first,
      :last_name => last,
      :email => (rand > 0.5) ? "#{first}.#{last}@#{domain}" : nil,
      :url => (rand > 0.5) ? "http://#{domain}" : nil,
      :message => LoremIpsumForgery.sentence,
      :value => MonetaryForgery.money(:min => 200, :max => 499_99),
      :show_value => (rand > 0.2),
      :purchased_at => (rand > 0.2) ? Time.now : nil,
    }
  end
end
