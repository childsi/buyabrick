class BrickForgery < Forgery
  def self.brick_params
    {
      :name => NameForgery.full_name,
      :email => (rand > 0.5) ? InternetForgery.email_address : nil,
      :url => (rand > 0.5) ? "http://#{InternetForgery.domain_name}" : nil,
      :message => LoremIpsumForgery.sentence,
      :value => MonetaryForgery.money(:min => 200, :max => 500_00),
      :show_value => (rand > 0.2),
      :purchased_at => (rand > 0.2) ? Time.now : nil,
    }
  end
end
