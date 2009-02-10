require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bricks/index.html.erb" do
  include BricksHelper
  
  before(:each) do
    assigns[:bricks] = [
      stub_model(Brick,
        :value => 1,
        :name => "value for name",
        :email => "value for email",
        :url => "value for url",
        :message => "value for message"
      ),
      stub_model(Brick,
        :value => 1,
        :name => "value for name",
        :email => "value for email",
        :url => "value for url",
        :message => "value for message"
      )
    ]
  end

  it "should render list of bricks" do
    render "/bricks/index.html.erb"
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for message".to_s, 2)
  end
end

